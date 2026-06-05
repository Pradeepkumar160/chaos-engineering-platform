# ============================================================
#  Chaos Engineering Platform - Setup & Run Script
#  For Windows PowerShell
#  Author: Pradeep Kumar
# ============================================================

$ErrorActionPreference = "Stop"

# Colors
function Write-Cyan($msg)  { Write-Host $msg -ForegroundColor Cyan }
function Write-Green($msg) { Write-Host $msg -ForegroundColor Green }
function Write-Yellow($msg){ Write-Host $msg -ForegroundColor Yellow }
function Write-Red($msg)   { Write-Host $msg -ForegroundColor Red }

Clear-Host
Write-Cyan  "  ╔════════════════════════════════════════════╗"
Write-Cyan  "  ║      CHAOS ENGINEERING PLATFORM            ║"
Write-Cyan  "  ║      Setup & Launch Script                 ║"
Write-Cyan  "  ╚════════════════════════════════════════════╝"
Write-Host ""

# ── 1. Check Node.js ─────────────────────────────────────────
Write-Yellow "► Checking Node.js..."
try {
    $nodeVersion = node --version 2>&1
    $major = [int]($nodeVersion -replace 'v(\d+)\..*','$1')
    if ($major -lt 18) {
        Write-Red "  ✗ Node.js $nodeVersion found but v18+ required."
        Write-Red "    Download from: https://nodejs.org/en/download"
        exit 1
    }
    Write-Green "  ✓ Node.js $nodeVersion detected"
} catch {
    Write-Red "  ✗ Node.js not found!"
    Write-Red "    Please install from: https://nodejs.org/en/download"
    Write-Red "    Then re-run this script."
    exit 1
}

# ── 2. Check npm ─────────────────────────────────────────────
Write-Yellow "► Checking npm..."
try {
    $npmVersion = npm --version 2>&1
    Write-Green "  ✓ npm v$npmVersion detected"
} catch {
    Write-Red "  ✗ npm not found! It usually comes with Node.js."
    exit 1
}

# ── 3. Check if package.json exists ──────────────────────────
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptDir

if (-not (Test-Path "package.json")) {
    Write-Red "  ✗ package.json not found in: $scriptDir"
    Write-Red "    Make sure you are running this from the project folder."
    exit 1
}

# ── 4. Install dependencies ───────────────────────────────────
Write-Yellow "► Installing dependencies..."
if (-not (Test-Path "node_modules")) {
    Write-Host "  Installing express and cors packages..."
    npm install --silent
    if ($LASTEXITCODE -ne 0) {
        Write-Red "  ✗ npm install failed!"
        exit 1
    }
    Write-Green "  ✓ Dependencies installed"
} else {
    Write-Green "  ✓ node_modules already present (skipping install)"
}

# ── 5. Check port 3000 ────────────────────────────────────────
Write-Yellow "► Checking port 3000..."
$portInUse = $false
try {
    $conn = New-Object System.Net.Sockets.TcpClient
    $conn.Connect("localhost", 3000)
    $conn.Close()
    $portInUse = $true
} catch {}

if ($portInUse) {
    Write-Yellow "  ⚠ Port 3000 is already in use."
    Write-Yellow "    The server might already be running."
    Write-Yellow "    Open http://localhost:3000 in your browser."
    $open = Read-Host "  Open browser now? (Y/n)"
    if ($open -ne 'n' -and $open -ne 'N') {
        Start-Process "http://localhost:3000"
    }
    exit 0
}

Write-Green "  ✓ Port 3000 is free"

# ── 6. Launch server ──────────────────────────────────────────
Write-Host ""
Write-Cyan  "  ╔════════════════════════════════════════════╗"
Write-Cyan  "  ║         STARTING THE PLATFORM...           ║"
Write-Cyan  "  ╚════════════════════════════════════════════╝"
Write-Host ""
Write-Green "  🚀 Server will start on: http://localhost:3000"
Write-Host ""
Write-Yellow "  Features included:"
Write-Host "  ✅  6 Microservices pre-configured (API Gateway, Auth, User, Product, Order, Notification)"
Write-Host "  ✅  Chaos Experiments (CPU Stress, Memory Pressure, Network Latency, Pod Kill, Disk I/O)"
Write-Host "  ✅  Real-time Metrics Simulation (auto-refreshes every 8 seconds)"
Write-Host "  ✅  SLO Tracking with Error Budgets"
Write-Host "  ✅  Incident Management"
Write-Host "  ✅  AI Root Cause Analysis (via Claude AI — works offline with fallback)"
Write-Host "  ✅  Service Topology & Blast Radius Visualization"
Write-Host "  ✅  Resilience Scoring Dashboard"
Write-Host "  ✅  Audit Logs & Notifications"
Write-Host ""
Write-Yellow "  Press Ctrl+C to stop the server"
Write-Host ""

# Open browser after 2 seconds
Start-Job -ScriptBlock {
    Start-Sleep 2
    Start-Process "http://localhost:3000"
} | Out-Null

# Start server
node server.js
