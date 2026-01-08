# 🤖 RoboTable

**Self-hosted Airtable alternative for team collaboration**

RoboTable is a free, open-source database management platform that gives your team Airtable-like spreadsheet functionality without the monthly fees, row limits, or vendor lock-in. Built on NocoDB and optimized for deployment on Render + Supabase.

---

## ✨ Features

- **Spreadsheet Interface**: Familiar grid, kanban, gallery, and calendar views
- **Relations & Formulas**: Link tables, create calculated fields, build complex workflows
- **Team Collaboration**: Role-based access control, real-time updates, commenting
- **API Access**: Auto-generated REST APIs and SDKs for custom integrations
- **Webhooks**: Trigger external systems on data changes
- **Data Sovereignty**: Your data, your infrastructure, your control

---

## 🎯 Use Cases

RoboTable is perfect for:

- ✅ **CRM** - Customer management, deals pipeline, interaction tracking
- ✅ **Project Management** - Tasks, milestones, team assignments, kanban boards
- ✅ **Content Calendar** - Publishing schedules, content planning, approval workflows
- ✅ **Inventory Tracking** - Asset management, stock levels, locations
- ✅ **Internal Tools** - Admin panels, data management, team dashboards

---

## 🚀 Quick Start

### Prerequisites

- Docker installed ([download here](https://www.docker.com/products/docker-desktop))
- Git (for deployment to Render)

### 1. Local Testing (5 minutes)

```bash
# Clone or download this repository
cd RoboTable

# Launch with Docker Compose
docker-compose up -d

# Access RoboTable
open http://localhost:8080
```

Create your first account and start building tables!

### 2. Production Deployment (15 minutes)

See [docs/setup-guide.md](./docs/setup-guide.md) for detailed instructions on deploying to Render with Supabase.

**Quick summary:**
1. Get Supabase connection string
2. Push to GitHub
3. Connect to Render with `render.yaml`
4. Set environment variables
5. Deploy!

**Cost**: $7/month (Render Starter) - supports 50-100 concurrent users

---

## 📁 Project Structure

```
RoboTable/
├── Dockerfile                 # Container configuration
├── docker-compose.yml         # Local development setup
├── render.yaml               # Render deployment config
├── .env.example              # Environment variables template
├── .gitignore                # Git ignore rules
├── README.md                 # This file
└── docs/
    ├── setup-guide.md        # Detailed setup instructions
    ├── user-guide.md         # How to use RoboTable
    └── api-guide.md          # API integration documentation
```

---

## 🔧 Configuration

### Environment Variables

Copy `.env.example` to `.env` and configure:

```env
# Supabase PostgreSQL (recommended)
NC_DB=pg://db.your-project.supabase.co:5432?u=postgres&p=password&d=postgres

# JWT secret for authentication
NC_AUTH_JWT_SECRET=your-random-secure-secret

# Public URL
NC_PUBLIC_URL=http://localhost:8080
```

For Render deployment, set these in the Render dashboard instead of `.env` file.

---

## 🏗️ Architecture

```
┌─────────────────┐
│   Your Team     │
│   (Browsers)    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   RoboTable     │
│  (Render.com)   │
│   + NocoDB UI   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Supabase      │
│  (PostgreSQL)   │
│   Your Data     │
└─────────────────┘
```

**Why this stack?**
- **Render**: Handles hosting, SSL, auto-deploys, health checks
- **Supabase**: Production-grade database with automatic backups
- **NocoDB**: Provides the Airtable-like UI and API layer

---

## 💰 Cost Comparison

| Solution | Monthly Cost | Users | Limits |
|----------|--------------|-------|--------|
| **Airtable Pro** | $240 | 10 | 50K records/base |
| **Retool** | $500 | 10 | Limited complexity |
| **RoboTable** | **$7** | **100+** | **Unlimited** |

**Savings**: $233-493/month = $2,796-5,916/year

---

## 📚 Documentation

- **[Setup Guide](./docs/setup-guide.md)** - Detailed deployment instructions
- **[User Guide](./docs/user-guide.md)** - How to use RoboTable features
- **[API Guide](./docs/api-guide.md)** - API integration and automation
- **[NocoDB Docs](https://docs.nocodb.com)** - Official NocoDB documentation

---

## 🔒 Security

- ✅ HTTPS enforced by Render
- ✅ JWT-based authentication
- ✅ Role-based access control
- ✅ Supabase automatic backups
- ✅ Environment variable secrets
- ✅ Regular security updates (Docker image)

---

## 🛠️ Common Commands

```bash
# Start local instance
docker-compose up -d

# Stop local instance
docker-compose down

# View logs
docker-compose logs -f

# Restart after config changes
docker-compose restart

# Remove all data (DESTRUCTIVE)
docker-compose down -v
```

---

## 🚨 Troubleshooting

### Can't access localhost:8080
- Check Docker is running: `docker ps`
- Check logs: `docker-compose logs`
- Try different port in `docker-compose.yml`

### Data disappeared after restart
- Ensure volume is mounted in `docker-compose.yml`
- Check: `docker volume ls`

### Slow performance
- Add database indexes on frequently queried columns
- Monitor Supabase dashboard for slow queries
- Upgrade Render plan if needed

More help: See [docs/setup-guide.md](./docs/setup-guide.md) troubleshooting section

---

## 🤝 Support

- **Issues**: Open an issue on GitHub
- **Questions**: Check [docs/](./docs/) folder
- **NocoDB**: [Official community](https://github.com/nocodb/nocodb)

---

## 📝 License

RoboTable is based on [NocoDB](https://github.com/nocodb/nocodb) which is licensed under AGPL-3.0.

This project configuration and documentation are provided as-is for team use.

---

## 🎯 Next Steps

1. ✅ [Launch locally](./docs/setup-guide.md#local-testing) and explore
2. ✅ [Connect to Supabase](./docs/setup-guide.md#supabase-integration) for production database
3. ✅ [Deploy to Render](./docs/setup-guide.md#render-deployment) for team access
4. ✅ [Invite your team](./docs/user-guide.md#inviting-users) and start collaborating

---

**Built with ❤️ for teams who value data sovereignty and cost efficiency**

*Last updated: 2026-01-06*
