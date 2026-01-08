# RoboTable API Guide

Complete guide for integrating RoboTable with other tools via API.

---

## Table of Contents

1. [Getting Started](#getting-started)
2. [Authentication](#authentication)
3. [API Endpoints](#api-endpoints)
4. [Examples](#examples)
5. [Webhooks](#webhooks)
6. [Best Practices](#best-practices)

---

## Getting Started

### What You Can Do

RoboTable auto-generates REST APIs for all your tables:
- ✅ Create, read, update, delete records (CRUD)
- ✅ Filter and sort data
- ✅ Paginate large datasets
- ✅ Work with relations and lookups
- ✅ Trigger webhooks on data changes

### API Base URL

```
Local:  http://localhost:8080/api/v1
Render: https://robotable.onrender.com/api/v1
```

### API Documentation

Auto-generated Swagger docs:
```
https://robotable.onrender.com/api/v1/docs
```

---

## Authentication

### Getting API Token

1. Click profile icon (top-right)
2. Select **"Account Settings"**
3. Navigate to **"Tokens"** tab
4. Click **"Create Token"**
5. Name your token (e.g., "Python Script", "N8N Integration")
6. Copy token immediately (won't be shown again!)

### Using Token

Include in `xc-auth` header:

```bash
curl -X GET \
  "https://robotable.onrender.com/api/v1/db/data/noco/Project/Table" \
  -H "xc-auth: YOUR_TOKEN_HERE"
```

**Security**: Treat tokens like passwords - never commit to git!

---

## API Endpoints

### Base Pattern

```
/api/v1/db/data/noco/{project}/{table}
```

Where:
- `{project}`: Your project name (e.g., "MyWorkspace")
- `{table}`: Your table name (e.g., "Customers")

### Common Operations

#### List All Records

```bash
GET /api/v1/db/data/noco/{project}/{table}
```

**Query Parameters**:
- `limit`: Number of records (default: 25, max: 1000)
- `offset`: Skip records for pagination
- `where`: Filter conditions (JSON)
- `sort`: Sort by field(s)
- `fields`: Select specific fields only

#### Get Single Record

```bash
GET /api/v1/db/data/noco/{project}/{table}/{id}
```

#### Create Record

```bash
POST /api/v1/db/data/noco/{project}/{table}
Content-Type: application/json

{
  "field1": "value1",
  "field2": "value2"
}
```

#### Update Record

```bash
PATCH /api/v1/db/data/noco/{project}/{table}/{id}
Content-Type: application/json

{
  "field1": "new_value"
}
```

#### Delete Record

```bash
DELETE /api/v1/db/data/noco/{project}/{table}/{id}
```

#### Bulk Operations

```bash
POST /api/v1/db/data/bulk/noco/{project}/{table}
Content-Type: application/json

[
  {"field1": "value1"},
  {"field1": "value2"},
  {"field1": "value3"}
]
```

---

## Examples

### Python

#### Setup

```python
pip install requests
```

#### Basic Operations

```python
import requests
import json

API_URL = "https://robotable.onrender.com/api/v1"
PROJECT = "MyWorkspace"
TABLE = "Customers"
TOKEN = "your-token-here"

headers = {
    "xc-auth": TOKEN,
    "Content-Type": "application/json"
}

# List all customers
response = requests.get(
    f"{API_URL}/db/data/noco/{PROJECT}/{TABLE}",
    headers=headers
)
customers = response.json()
print(f"Found {len(customers['list'])} customers")

# Create new customer
new_customer = {
    "Customer Name": "Acme Corp",
    "Email": "contact@acme.com",
    "Status": "Lead",
    "Deal Value": 50000
}
response = requests.post(
    f"{API_URL}/db/data/noco/{PROJECT}/{TABLE}",
    headers=headers,
    json=new_customer
)
print(f"Created customer: {response.json()}")

# Update customer
customer_id = response.json()['Id']
update_data = {"Status": "Qualified"}
response = requests.patch(
    f"{API_URL}/db/data/noco/{PROJECT}/{TABLE}/{customer_id}",
    headers=headers,
    json=update_data
)
print(f"Updated customer status")

# Filter customers
params = {
    "where": json.dumps({"Status": {"eq": "Lead"}}),
    "limit": 100
}
response = requests.get(
    f"{API_URL}/db/data/noco/{PROJECT}/{TABLE}",
    headers=headers,
    params=params
)
leads = response.json()
print(f"Found {len(leads['list'])} leads")
```

#### Advanced Filtering

```python
# Complex filter: Status = "Lead" AND Deal Value > 10000
filter_conditions = {
    "_and": [
        {"Status": {"eq": "Lead"}},
        {"Deal Value": {"gt": 10000}}
    ]
}

params = {
    "where": json.dumps(filter_conditions),
    "sort": "-Deal Value",  # Descending
    "limit": 50
}

response = requests.get(
    f"{API_URL}/db/data/noco/{PROJECT}/{TABLE}",
    headers=headers,
    params=params
)
```

#### Pagination

```python
def fetch_all_records(api_url, project, table, headers):
    """Fetch all records with pagination"""
    all_records = []
    offset = 0
    limit = 100

    while True:
        params = {"limit": limit, "offset": offset}
        response = requests.get(
            f"{api_url}/db/data/noco/{project}/{table}",
            headers=headers,
            params=params
        )
        data = response.json()
        records = data['list']

        if not records:
            break

        all_records.extend(records)
        offset += limit

        print(f"Fetched {len(all_records)} records so far...")

    return all_records

# Usage
all_customers = fetch_all_records(API_URL, PROJECT, TABLE, headers)
print(f"Total customers: {len(all_customers)}")
```

---

### JavaScript/Node.js

#### Setup

```bash
npm install node-fetch
```

#### Basic Operations

```javascript
const fetch = require('node-fetch');

const API_URL = "https://robotable.onrender.com/api/v1";
const PROJECT = "MyWorkspace";
const TABLE = "Customers";
const TOKEN = "your-token-here";

const headers = {
  "xc-auth": TOKEN,
  "Content-Type": "application/json"
};

// List all customers
async function listCustomers() {
  const response = await fetch(
    `${API_URL}/db/data/noco/${PROJECT}/${TABLE}`,
    { headers }
  );
  const data = await response.json();
  console.log(`Found ${data.list.length} customers`);
  return data.list;
}

// Create new customer
async function createCustomer(customerData) {
  const response = await fetch(
    `${API_URL}/db/data/noco/${PROJECT}/${TABLE}`,
    {
      method: "POST",
      headers,
      body: JSON.stringify(customerData)
    }
  );
  const data = await response.json();
  console.log("Created customer:", data);
  return data;
}

// Update customer
async function updateCustomer(id, updateData) {
  const response = await fetch(
    `${API_URL}/db/data/noco/${PROJECT}/${TABLE}/${id}`,
    {
      method: "PATCH",
      headers,
      body: JSON.stringify(updateData)
    }
  );
  const data = await response.json();
  console.log("Updated customer:", data);
  return data;
}

// Usage
(async () => {
  const customers = await listCustomers();

  const newCustomer = await createCustomer({
    "Customer Name": "Tech Startup Inc",
    "Email": "hello@techstartup.com",
    "Status": "Lead",
    "Deal Value": 25000
  });

  await updateCustomer(newCustomer.Id, { Status: "Qualified" });
})();
```

#### Filtering Example

```javascript
async function filterCustomers(status, minValue) {
  const filter = {
    _and: [
      { Status: { eq: status } },
      { "Deal Value": { gte: minValue } }
    ]
  };

  const params = new URLSearchParams({
    where: JSON.stringify(filter),
    sort: "-Deal Value",
    limit: 100
  });

  const response = await fetch(
    `${API_URL}/db/data/noco/${PROJECT}/${TABLE}?${params}`,
    { headers }
  );

  return await response.json();
}

// Get qualified leads over $10k
const results = await filterCustomers("Qualified", 10000);
```

---

### cURL

#### List Records

```bash
curl -X GET \
  "https://robotable.onrender.com/api/v1/db/data/noco/MyWorkspace/Customers" \
  -H "xc-auth: YOUR_TOKEN"
```

#### Create Record

```bash
curl -X POST \
  "https://robotable.onrender.com/api/v1/db/data/noco/MyWorkspace/Customers" \
  -H "xc-auth: YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "Customer Name": "New Customer",
    "Email": "customer@example.com",
    "Status": "Lead"
  }'
```

#### Update Record

```bash
curl -X PATCH \
  "https://robotable.onrender.com/api/v1/db/data/noco/MyWorkspace/Customers/123" \
  -H "xc-auth: YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"Status": "Qualified"}'
```

#### Delete Record

```bash
curl -X DELETE \
  "https://robotable.onrender.com/api/v1/db/data/noco/MyWorkspace/Customers/123" \
  -H "xc-auth: YOUR_TOKEN"
```

---

## Webhooks

### Setting Up Webhooks

1. Open table in RoboTable
2. Click gear icon → **"Webhooks"**
3. Click **"Add Webhook"**
4. Configure:
   - **Name**: Descriptive name
   - **URL**: Your endpoint
   - **Method**: Usually POST
   - **Trigger**: Insert/Update/Delete
   - **Condition**: Optional filter (only trigger if condition met)

### Webhook Payload

```json
{
  "type": "after",
  "id": "webhook_unique_id",
  "data": {
    "Id": 123,
    "Customer Name": "Acme Corp",
    "Email": "contact@acme.com",
    "Status": "Lead",
    "Deal Value": 50000,
    "Created": "2026-01-06T10:30:00Z"
  },
  "table": "Customers",
  "operation": "insert"
}
```

### Webhook Examples

#### Send to Slack

```python
import requests

def handle_webhook(request):
    """Receive webhook and send to Slack"""
    data = request.json

    # Extract customer info
    customer = data['data']
    operation = data['operation']

    # Format Slack message
    message = {
        "text": f"New customer: {customer['Customer Name']}",
        "blocks": [
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": f"*New Lead Added*\n"
                           f"Name: {customer['Customer Name']}\n"
                           f"Email: {customer['Email']}\n"
                           f"Deal Value: ${customer['Deal Value']:,}"
                }
            }
        ]
    }

    # Send to Slack
    slack_webhook = "https://hooks.slack.com/services/YOUR/WEBHOOK/URL"
    requests.post(slack_webhook, json=message)

    return {"status": "success"}
```

#### Trigger N8N Workflow

RoboTable → Webhook → N8N:

1. In N8N: Create webhook trigger node
2. Copy webhook URL
3. In RoboTable: Add webhook with N8N URL
4. In N8N: Build workflow (send email, update CRM, etc.)

---

## Best Practices

### 1. Authentication

- **Generate separate tokens** for each integration
- **Name tokens descriptively** ("Python Script", "Zapier", "Mobile App")
- **Rotate tokens** if compromised
- **Store tokens securely** (environment variables, secret managers)

### 2. Rate Limiting

- **Batch operations** when possible (bulk create/update)
- **Add delays** between requests (100-500ms recommended)
- **Use pagination** for large datasets (limit=1000 max)
- **Cache data** locally when appropriate

### 3. Error Handling

```python
import time

def api_request_with_retry(url, headers, max_retries=3):
    """Make API request with exponential backoff"""
    for attempt in range(max_retries):
        try:
            response = requests.get(url, headers=headers)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            if attempt == max_retries - 1:
                raise
            wait_time = 2 ** attempt  # Exponential backoff
            print(f"Request failed, retrying in {wait_time}s...")
            time.sleep(wait_time)
```

### 4. Data Validation

- **Validate input** before sending to API
- **Check response status** codes
- **Handle missing fields** gracefully
- **Test with small datasets** first

### 5. Performance

- **Select specific fields** instead of fetching all
- **Use filters** to reduce data transfer
- **Cache frequently accessed data**
- **Batch operations** (100-1000 records at a time)

---

## Common Use Cases

### 1. Daily Data Sync

```python
import schedule
import time

def sync_customers():
    """Sync customers from external CRM to RoboTable"""
    # Fetch from external system
    external_customers = fetch_from_external_crm()

    # Batch create in RoboTable
    for batch in chunks(external_customers, 100):
        requests.post(
            f"{API_URL}/db/data/bulk/noco/{PROJECT}/Customers",
            headers=headers,
            json=batch
        )

    print(f"Synced {len(external_customers)} customers")

# Schedule daily at 2 AM
schedule.every().day.at("02:00").do(sync_customers)

while True:
    schedule.run_pending()
    time.sleep(60)
```

### 2. Form to RoboTable

```html
<!-- HTML Form -->
<form id="contactForm">
  <input name="name" placeholder="Name" required>
  <input name="email" type="email" placeholder="Email" required>
  <textarea name="message" placeholder="Message"></textarea>
  <button type="submit">Submit</button>
</form>

<script>
document.getElementById('contactForm').addEventListener('submit', async (e) => {
  e.preventDefault();

  const formData = new FormData(e.target);
  const data = {
    "Customer Name": formData.get('name'),
    "Email": formData.get('email'),
    "Notes": formData.get('message'),
    "Status": "Lead",
    "Source": "Website Form"
  };

  await fetch('https://robotable.onrender.com/api/v1/db/data/noco/MyWorkspace/Customers', {
    method: 'POST',
    headers: {
      'xc-auth': 'YOUR_TOKEN',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(data)
  });

  alert('Thank you! We'll be in touch soon.');
  e.target.reset();
});
</script>
```

### 3. Automated Reporting

```python
def generate_weekly_report():
    """Generate and email weekly sales report"""
    # Fetch this week's deals
    filter_conditions = {
        "Created": {"gte": "2026-01-01"}
    }

    response = requests.get(
        f"{API_URL}/db/data/noco/{PROJECT}/Deals",
        headers=headers,
        params={"where": json.dumps(filter_conditions)}
    )

    deals = response.json()['list']

    # Calculate metrics
    total_value = sum(d['Deal Value'] for d in deals)
    closed_deals = [d for d in deals if d['Status'] == 'Closed Won']

    # Format report
    report = f"""
    Weekly Sales Report
    ===================
    Total Deals: {len(deals)}
    Total Value: ${total_value:,}
    Closed Deals: {len(closed_deals)}
    Close Rate: {len(closed_deals)/len(deals)*100:.1f}%
    """

    # Send email (pseudo-code)
    send_email(to="team@company.com", subject="Weekly Report", body=report)
```

---

## Filter Operators Reference

| Operator | Meaning | Example |
|----------|---------|---------|
| `eq` | Equal | `{"Status": {"eq": "Lead"}}` |
| `neq` | Not equal | `{"Status": {"neq": "Churned"}}` |
| `gt` | Greater than | `{"Value": {"gt": 10000}}` |
| `lt` | Less than | `{"Value": {"lt": 1000}}` |
| `gte` | Greater than or equal | `{"Value": {"gte": 5000}}` |
| `lte` | Less than or equal | `{"Value": {"lte": 50000}}` |
| `like` | Contains (SQL LIKE) | `{"Name": {"like": "%Corp%"}}` |
| `nlike` | Not contains | `{"Email": {"nlike": "%spam%"}}` |
| `in` | In list | `{"Status": {"in": ["Lead", "Qualified"]}}` |
| `is` | Is null | `{"Notes": {"is": "null"}}` |
| `isnot` | Is not null | `{"Email": {"isnot": "null"}}` |

---

## Troubleshooting

### Issue: 401 Unauthorized

**Solution**: Check API token is valid and included in `xc-auth` header

### Issue: 404 Not Found

**Solution**: Verify project and table names are correct (case-sensitive)

### Issue: Rate Limited

**Solution**: Add delays between requests, use bulk operations

### Issue: Timeout

**Solution**: Reduce request size, add pagination, optimize filters

---

## Next Steps

- [Setup Guide](./setup-guide.md) - Deploy RoboTable
- [User Guide](./user-guide.md) - Learn RoboTable features
- [Swagger Docs](https://robotable.onrender.com/api/v1/docs) - Interactive API docs

---

*Last updated: 2026-01-06*
