# RoboTable - Self-Hosted Airtable Alternative
# Based on NocoDB

FROM nocodb/nocodb:latest

# Disable telemetry for privacy
ENV NC_DISABLE_TELE=true

# Set healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD node -e "require('http').get('http://localhost:8080/api/v1/health', (r) => {process.exit(r.statusCode === 200 ? 0 : 1)})"

# Expose port
EXPOSE 8080

# Note: Environment variables should be set at runtime:
# - NC_DB: Database connection string (Supabase PostgreSQL recommended)
# - NC_AUTH_JWT_SECRET: JWT secret for authentication
# - NC_PUBLIC_URL: Public URL where RoboTable is accessible
# - PORT: Port to run on (default: 8080)
