# Retail & E-Commerce Data Engineering & Relational Database

---

## 1. Overview
This repository contains the exploratory data analysis, data cleaning pipeline, and normalized relational database implementation for an e-commerce platform transaction dataset (Pakistan E-Commerce Transactions, July 2016 – August 2018).

The raw dataset contains **584,524 transaction line items** across **408,782 orders** and **115,327 customers**, representing **4.195 billion PKR** in gross order demand.

### Key Analysis Findings
1. **Fulfillment Funnel:** Only 41.5% of placed orders are completed. 36.4% are canceled prior to dispatch, and 13.0% are returned/refunded post-delivery.
2. **Payment Channel Friction:** Digital payment methods (Easypay, Payaxis, Bank Alfalah) have cancellation rates above 60%–77%. Cash on Delivery (COD) has a low cancellation rate (8.0%), but a high return rate (23.7%) at customer doorstep.
3. **Repeated Header Total in Raw File:** The raw CSV repeated the full order `grand_total` across every line item of multi-item orders (81,854 orders). Summing this column directly over-counted revenue by ~1.09 billion PKR (+28.0%). This is resolved by normalizing into separate `Orders` and `OrderDetails` tables.

---

## 2. Directory Layout

```text
Retail_Ecommerce_Project/
│
├── data/
│   ├── raw/
│   │   └── Pakistan Largest Ecommerce Dataset.csv   # Raw extract (untouched)
│   └── cleaned/                                     # Clean relational CSVs
│       ├── Categories.csv                           # 16 categories
│       ├── PaymentMethods.csv                       # 18 payment methods
│       ├── Products.csv                             # 84,800 catalog SKUs
│       ├── Customers.csv                            # 115,327 customer records
│       ├── Orders.csv                               # 408,782 order headers
│       └── OrderDetails.csv                         # 584,524 line items
│
├── notebooks/
│   ├── 01_exploratory_data_analysis.ipynb           # Data profiling & EDA
│   ├── 02_data_cleaning.ipynb                       # Cleaning & normalization
│   └── figures/                                     # Exported charts
│       ├── 01_order_status_breakdown.png
│       ├── 02_payment_fulfillment_rates.png
│       ├── 03_monthly_revenue_trends.png
│       ├── 04_category_performance.png
│       ├── 05_customer_order_frequency.png
│       └── 06_discount_vs_status.png
│
├── sql/
│   ├── 01_Create_Database.sql                       # Database creation DDL
│   ├── 02_Create_Tables.sql                         # Table DDL
│   ├── 03_Load_Data.sql                             # BULK INSERT statements
│   ├── 04_Constraints_Indexes.sql                   # Keys, checks, and indexes
│   └── 05_Validation.sql                            # Verification queries
│
├── documentation/
│   ├── Business_Requirements.md                     # Business requirements document
│   ├── Data_Dictionary.md                           # Column definitions & types
│   ├── Data_Quality_Report.md                       # Quality audit & defect log
│   ├── Dataset_Inventory.md                         # File counts, grains, structure
│   ├── EDA_Findings.md                              # Key analysis findings
│   ├── KPI_Definitions.md                           # KPI catalog & formulas
│   ├── Data_Cleaning_Report.md                      # Log of cleaning actions
│   ├── Data_Integration_Report.md                   # Relational reconciliation
│   ├── Database_Design.md                           # Schema architecture & indexes
│   ├── Validation_Report.md                         # Automated test results
│   └── Handover_Document.md                         # Handover notes
│
├── diagrams/
│   └── ERD.md                                       # Entity relationship diagram
│
├── README.md
└── requirements.txt
```

---

## 3. Relational Data Model

The database is implemented in Third Normal Form (3NF) on Microsoft SQL Server (`RetailEcommerce_DB`):
- `Customers` (1) $\rightarrow$ (N) `Orders`
- `PaymentMethods` (1) $\rightarrow$ (N) `Orders`
- `Categories` (1) $\rightarrow$ (N) `Products`
- `Products` (1) $\rightarrow$ (N) `OrderDetails`
- `Orders` (1) $\rightarrow$ (N) `OrderDetails`

See `diagrams/ERD.md` for the full visual diagram and `documentation/Database_Design.md` for table specifications and indexing details.

---

## 4. How to Run

### Setup Environment
```powershell
py -m pip install -r requirements.txt
```

### Run Analysis & Data Cleaning
Open and execute the Jupyter Notebooks in order:
1. `notebooks/01_exploratory_data_analysis.ipynb` — Data exploration, profiling, and fulfillment analysis.
2. `notebooks/02_data_cleaning.ipynb` — Data cleaning, handling nulls, and exporting the 6 relational CSV tables.

### SQL Server Deployment
Run the SQL scripts in SSMS or Azure Data Studio in numeric order:
1. `sql/01_Create_Database.sql`
2. `sql/02_Create_Tables.sql`
3. `sql/03_Load_Data.sql`
4. `sql/04_Constraints_Indexes.sql`
5. `sql/05_Validation.sql`
