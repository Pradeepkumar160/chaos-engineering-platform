# 🌪️ Chaos Engineering Platform.       

A production-grade chaos engineering dashboard with real-time metrics, SLO tracking, AI-powered root cause analysis, and service topology visualization.

---

## 🚀 Quick Start (Windows PowerShell)

### Option 1 — PowerShell (Recommended)

```powershell
# 1. Open PowerShell in this folder (Shift+Right-Click → "Open PowerShell window here")
# 2. If scripts are blocked, run this once:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# 3. Run the setup & launch script:
.\START.ps1
```

### Option 2 — Command Prompt (CMD)

Double-click `START.bat` or run in CMD:
```cmd
START.bat
```

### Option 3 — Manual

```powershell
# Install dependencies (first time only)
npm install

# Start the server
node server.js
```

Then open **http://localhost:3000** in your browser.

---

## 📋 Requirements

- **Node.js v18+** — Download from https://nodejs.org/en/download
- **npm** (comes with Node.js)
- No database required — uses in-memory storage

---

## ✨ Features

| Feature | Description |
|---|---|
| 📊 **Dashboard** | Real-time KPI cards — availability, latency, error rate, resilience score |
| ⚡ **Chaos Experiments** | CPU Stress, Memory Pressure, Network Latency, Pod Kill, Disk I/O |
| 📈 **Metrics Simulation** | Live metric degradation when experiments run, auto-restores on stop |
| 🎯 **SLO Tracking** | Error budget tracking with breach alerts |
| 🚨 **Incident Management** | Create, track, and resolve incidents with severity levels |
| 🤖 **AI Root Cause Analysis** | Claude AI-powered RCA (with offline fallback) |
| 🗺️ **Service Topology** | Visual dependency map with blast radius analysis |
| 📉 **Resilience Scoring** | Per-service resilience scores with trend tracking |
| 🔔 **Notifications** | In-app alerts for SLO breaches and critical incidents |
| 📋 **Audit Logs** | Full experiment event log |

---

## 🏗️ Pre-configured Services

1. **API Gateway** — Entry point for all external traffic
2. **Auth Service** — JWT authentication and authorization  
3. **User Service** — User profile and management
4. **Product Service** — Product catalog and inventory
5. **Order Service** — Order processing and fulfillment
6. **Notification Service** — Email, SMS, and push notifications

---

## 🧪 How to Run a Chaos Experiment

1. Open the **Experiments** tab in the dashboard
2. Click **"New Experiment"**
3. Fill in name, select type (e.g., CPU Stress), choose a service
4. Click **Create**, then click **▶ Start**
5. Watch real-time metrics degrade in the **Metrics** tab
6. Click **⏹ Stop** to restore normal metrics
7. Use **AI RCA** to analyze what happened

---

## 🌐 API Endpoints

| Method | Endpoint | Description |
|---|---|---|
| GET | `/` | Dashboard HTML |
| GET | `/api/services` | List all services |
| GET | `/api/experiments` | List experiments |
| POST | `/api/experiments` | Create experiment |
| POST | `/api/experiments/:id/start` | Start experiment |
| POST | `/api/experiments/:id/stop` | Stop experiment |
| GET | `/api/metrics/latest/:serviceId` | Latest metrics |
| GET | `/api/incidents` | List incidents |
| POST | `/api/incidents` | Create incident |
| GET | `/api/dashboard/stats` | Aggregated stats |
| POST | `/api/rca/analyze` | AI root cause analysis |
| GET | `/api/notifications` | User notifications |

---

## ⚙️ Configuration

Change port (default: 3000):
```powershell
$env:PORT=8080; node server.js
```

---

## 🛠️ Tech Stack

- **Backend**: Node.js + Express.js (ESM modules)
- **Frontend**: Vanilla JS + Chart.js + Google Fonts
- **Storage**: In-memory (no DB setup needed)
- **AI**: Anthropic Claude API (with fallback engine)
- **Charts**: Chart.js 4.4

---

## 📁 Project Structure

```
chaos-engineering-platform/
├── server.js          ← Complete server + embedded frontend
├── package.json       ← Dependencies (express, cors)
├── START.ps1          ← PowerShell launcher
├── START.bat          ← CMD launcher
└── README.md          ← This file
```

---

Built with ❤️ by Pradeep Kumar | LPU B.Tech CSE
