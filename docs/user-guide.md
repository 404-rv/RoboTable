# RoboTable User Guide

Complete guide for using RoboTable effectively.

---

## Table of Contents

1. [Getting Started](#getting-started)
2. [Tables & Fields](#tables--fields)
3. [Views](#views)
4. [Relations](#relations)
5. [Filters & Sorts](#filters--sorts)
6. [Formulas](#formulas)
7. [Collaboration](#collaboration)
8. [Importing Data](#importing-data)
9. [Best Practices](#best-practices)

---

## Getting Started

### Creating Your First Table

1. Click **"Add Table"** in left sidebar
2. Choose method:
   - **Create Empty Table**: Start from scratch
   - **Import from CSV**: Upload existing data
   - **Template**: Use pre-built structure

3. Add fields (columns):
   - Click **"+"** icon
   - Select field type
   - Configure options

### Field Types

| Type | Use For | Example |
|------|---------|---------|
| **SingleLineText** | Short text | Name, Email, SKU |
| **LongText** | Paragraphs | Description, Notes |
| **Number** | Numeric values | Quantity, Price, Age |
| **Checkbox** | Yes/No | Active, Completed |
| **SingleSelect** | One choice | Status, Priority, Category |
| **MultiSelect** | Multiple choices | Tags, Skills, Platforms |
| **Date** | Dates | Birthday, Due Date, Created |
| **DateTime** | Date + Time | Appointment, Last Modified |
| **Email** | Email addresses | Contact Email |
| **URL** | Web links | Website, Portfolio |
| **Phone** | Phone numbers | Contact Number |
| **Currency** | Money | Price, Budget, Revenue |
| **Percent** | Percentages | Discount, Completion |
| **Rating** | Star rating | Priority, Satisfaction |
| **Attachment** | Files | Documents, Images |
| **LinkToAnotherRecord** | Relations | Customer → Orders |
| **Formula** | Calculations | Total, Full Name |
| **Rollup** | Aggregate from relations | Sum of Order Values |
| **Lookup** | Pull from relations | Customer Name |

---

## Tables & Fields

### Best Practices for Table Structure

**1. CRM Table**
```
Customers Table:
- Customer Name (SingleLineText)
- Email (Email)
- Phone (Phone)
- Company (SingleLineText)
- Status (SingleSelect: Lead, Qualified, Customer, Churned)
- Deal Value (Currency)
- Next Follow-Up (Date)
- Notes (LongText)
- Owner (SingleSelect: team member names)
```

**2. Project Management Table**
```
Tasks Table:
- Task Name (SingleLineText)
- Description (LongText)
- Assignee (SingleSelect)
- Status (SingleSelect: To Do, In Progress, Review, Done)
- Priority (Rating: 1-5 stars)
- Due Date (Date)
- Project (LinkToAnotherRecord → Projects)
- Estimated Hours (Number)
- Tags (MultiSelect)
```

**3. Content Calendar Table**
```
Content Table:
- Title (SingleLineText)
- Content Type (SingleSelect: Blog, Social, Video, Email)
- Author (SingleSelect)
- Status (SingleSelect: Draft, Review, Approved, Published)
- Publish Date (DateTime)
- Platform (MultiSelect: Twitter, LinkedIn, Instagram)
- URL (URL)
- Performance (Number: views/engagement)
```

**4. Inventory Table**
```
Products Table:
- Product Name (SingleLineText)
- SKU (SingleLineText)
- Quantity (Number)
- Location (SingleSelect)
- Reorder Point (Number)
- Supplier (LinkToAnotherRecord → Suppliers)
- Unit Cost (Currency)
- Last Restocked (Date)
- Image (Attachment)
```

---

## Views

### View Types

**Grid View** (Default)
- Standard spreadsheet layout
- Best for: Detailed data entry and editing

**Gallery View**
- Card-based visual layout
- Best for: Products, team members, images
- **How to create**:
  1. Click "Create View" → Gallery
  2. Select field for card title
  3. Choose image field (optional)

**Kanban View**
- Drag-and-drop board organized by status
- Best for: Pipelines, workflows, project management
- **How to create**:
  1. Click "Create View" → Kanban
  2. Select "Group by" field (usually Status)
  3. Drag cards between columns

**Form View**
- Public or private data collection form
- Best for: Customer submissions, applications, feedback
- **How to create**:
  1. Click "Create View" → Form
  2. Select fields to include
  3. Customize form design
  4. Share public link

**Calendar View**
- Date-based calendar display
- Best for: Content calendars, events, deadlines
- **How to create**:
  1. Click "Create View" → Calendar
  2. Select date field for calendar
  3. Choose view mode (month/week/day)

### Customizing Views

**Per-View Settings**:
- **Filters**: Show only specific records
- **Sorts**: Order records by field(s)
- **Grouping**: Organize into sections
- **Hide Fields**: Reduce clutter
- **Field Width**: Adjust column sizes
- **Row Height**: Compact, standard, or tall

**Example: Sales Pipeline Kanban**
1. Create kanban view grouped by Status
2. Add filter: "Owner = Me"
3. Sort by: Deal Value (descending)
4. Hide fields: Internal Notes, Created Date
5. Result: Personal pipeline showing biggest deals first

---

## Relations

### Creating Relations

**One-to-Many** (e.g., Customer → Orders)
1. In Orders table, add field
2. Type: LinkToAnotherRecord
3. Select: Customers table
4. Relation type: "Many Orders belong to one Customer"

**Many-to-Many** (e.g., Students ↔ Courses)
1. In Students table, add field
2. Type: LinkToAnotherRecord
3. Select: Courses table
4. Relation type: "Many Students have many Courses"

### Using Related Data

**Lookup Field**:
- Pull data from related records
- Example: In Orders table, lookup Customer Email from Customers

**Rollup Field**:
- Aggregate data from related records
- Example: In Customers table, sum of all Order Values

**Example: CRM with Orders**
```
Customers Table:
- Customer Name
- Total Order Value (Rollup: Sum of Orders.Amount)
- Last Order Date (Rollup: Max of Orders.Date)
- Orders (LinkToAnotherRecord)

Orders Table:
- Order ID
- Customer (LinkToAnotherRecord → Customers)
- Customer Email (Lookup from Customer.Email)
- Amount (Currency)
- Date (Date)
- Status (SingleSelect)
```

---

## Filters & Sorts

### Creating Filters

Click "Filter" button → Add condition:

**Common Filter Patterns**:
```
Show active customers:
- Status = "Active"

Show overdue tasks:
- Due Date < Today
- Status ≠ "Done"

Show high-value leads:
- Deal Value > 10000
- Status = "Lead"

Show my tasks:
- Assignee = "Your Name"
- Status ∈ ["To Do", "In Progress"]
```

### Filter Operators

- `=` Equal to
- `≠` Not equal to
- `>` Greater than
- `<` Less than
- `≥` Greater than or equal
- `≤` Less than or equal
- `is empty` Field has no value
- `is not empty` Field has value
- `contains` Text contains substring
- `does not contain` Text doesn't contain
- `starts with` / `ends with` Text position

### Multiple Filters

**AND Logic** (all conditions must be true):
```
Status = "Active" AND Deal Value > 5000
```

**OR Logic** (any condition can be true):
```
Status = "Lead" OR Status = "Qualified"
```

### Sorting

Click column header → Sort ascending/descending

**Multi-level sorting**:
1. Sort by Priority (descending)
2. Then sort by Due Date (ascending)
Result: High priority first, then by deadline

---

## Formulas

### Common Formula Patterns

**Concatenation** (combine text):
```javascript
// Full Name
{First Name} & " " & {Last Name}

// Full Address
{Street} & ", " & {City} & ", " & {State} & " " & {Zip}
```

**Calculations**:
```javascript
// Total Price
{Quantity} * {Unit Price}

// Discount Amount
{Original Price} * ({Discount Percent} / 100)

// Days Until Due
DATETIME_DIFF({Due Date}, TODAY(), 'days')
```

**Conditional Logic**:
```javascript
// Status Badge
IF({Quantity} < {Reorder Point}, "🔴 Reorder", "✅ In Stock")

// Priority Label
IF({Priority} >= 4, "HIGH", IF({Priority} >= 2, "MEDIUM", "LOW"))

// Deal Size Category
IF({Deal Value} > 50000, "Enterprise",
   IF({Deal Value} > 10000, "Mid-Market", "SMB"))
```

**Date Operations**:
```javascript
// Days Since Created
DATETIME_DIFF(TODAY(), {Created}, 'days')

// Is Overdue
AND({Due Date} < TODAY(), {Status} != "Done")

// Quarter
"Q" & CEILING(MONTH({Date}) / 3)
```

---

## Collaboration

### Inviting Users

**Method 1: Workspace Invite**
1. Click workspace name → "Invite"
2. Enter email
3. Select role (Creator, Editor, Commenter, Viewer)
4. Click "Invite"

**Method 2: Share Link**
1. Click "Share" in top-right
2. Copy link
3. Share with team
4. They create account and join

### Roles & Permissions

| Role | View | Comment | Edit | Delete | Manage |
|------|------|---------|------|--------|---------|
| **Creator** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Editor** | ✅ | ✅ | ✅ | ✅ | ❌ |
| **Commenter** | ✅ | ✅ | ❌ | ❌ | ❌ |
| **Viewer** | ✅ | ❌ | ❌ | ❌ | ❌ |

### Commenting

1. Right-click on any cell
2. Select "Add Comment"
3. Type message
4. Tag users with `@username`
5. Click "Comment"

Team members receive notifications for mentions.

### Activity Log

View all changes:
1. Click record
2. Expand details panel
3. View "Activity" tab
4. See who changed what and when

---

## Importing Data

### Import from CSV

1. Click table dropdown → "Import CSV"
2. Select file or drag-and-drop
3. Map columns to fields
4. Preview import
5. Click "Import"

**Tips**:
- First row should be headers
- Use UTF-8 encoding
- Max file size: 5MB (split large files)

### Import from Airtable

1. Get Airtable API key
2. Get Base ID
3. In RoboTable: "Import" → "Airtable"
4. Enter credentials
5. Select tables
6. Import

### Export Data

1. Open table
2. Click three-dots menu
3. Select "Download as CSV"
4. Save file

---

## Best Practices

### 1. Table Design

**DO**:
- ✅ Use consistent naming (e.g., "Customer Name" not "Name")
- ✅ Create separate tables for different entities
- ✅ Use SingleSelect for status fields
- ✅ Add descriptions to complex fields

**DON'T**:
- ❌ Store lists in single text field (use MultiSelect)
- ❌ Duplicate data (use relations instead)
- ❌ Use too many fields (split into related tables)

### 2. View Organization

- Create separate views for different workflows
- Name views clearly: "My Tasks", "This Week", "High Priority"
- Use filters to reduce noise
- Pin frequently used views

### 3. Performance

- Add database indexes for filtered/sorted fields
- Use relations instead of duplicating data
- Archive old records periodically
- Optimize formulas (avoid nested calculations)

### 4. Team Collaboration

- Document your structure (field descriptions)
- Use consistent conventions
- Assign clear ownership
- Regular team training

### 5. Data Quality

- Use field validation (required fields)
- Add default values
- Create templates for common records
- Regular data cleanup

---

## Keyboard Shortcuts

| Action | Shortcut |
|--------|----------|
| New record | `Ctrl+Enter` |
| Delete record | `Del` |
| Expand record | `Space` |
| Copy cell | `Ctrl+C` |
| Paste cell | `Ctrl+V` |
| Search | `Ctrl+F` |
| Undo | `Ctrl+Z` |
| Save | `Ctrl+S` |

---

## Next Steps

- [Setup Guide](./setup-guide.md) - Deploy RoboTable
- [API Guide](./api-guide.md) - Integrate with other tools
- [NocoDB Docs](https://docs.nocodb.com) - Advanced features

---

*Last updated: 2026-01-06*
