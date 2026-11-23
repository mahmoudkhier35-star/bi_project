# Project Handover & Technical Documentation
## Retail & E-Commerce Relational Database Foundation

---

## 1. Overview & Completed Scope

This document provides the technical handover package for downstream project stages (Data Warehouse / Star Schema modeling, SSIS ETL pipeline, and Power BI dashboard development).

### Completed Deliverables:
1. **Data Understanding & Profiling:**
   - Audited the raw export (1,048,575 rows), identified and excluded 464,051 blank padding rows and 5 empty trailing columns (`Unnamed: 21` through `25`).
   - Documented field profiles in [Dataset_Inventory.md](Dataset_Inventory.md) and [Data_Dictionary.md](Data_Dictionary.md).
2. **Exploratory Data Analysis (EDA):**
   - Conducted statistical profiling and diagnosed the raw dataset's `grand_total` duplication issue across multi-item orders (+1.09B PKR distortion).
   - Identified order fulfillment funnels: 41.5% completed, 36.4% canceled, 13.0% returned.
   - Identified payment channel friction: 62%–77% cancellation on digital gateways vs. 23.7% doorstep returns on COD.
   - Executed and documented in `notebooks/01_exploratory_data_analysis.ipynb`.
3. **Data Cleaning & Normalization:**
   - Standardized text categories, handled missing values and guest checkouts (`Customer ID = 0`), and cast strict data types.
   - Normalized the dataset into 6 relational tables (3NF): `Categories`, `PaymentMethods`, `Products`, `Customers`, `Orders`, and `OrderDetails`.
   - Executed and documented in `notebooks/02_data_cleaning.ipynb`.
4. **SQL Server Implementation:**
   - Authored executable T-SQL scripts (`sql/01_Create_Database.sql` through `sql/05_Validation.sql`) establishing database DDL, bulk loading, primary/foreign key constraints, and B-Tree indexes.
5. **Quality Validation:**
   - Executed 17 automated tests verifying 0 duplicate primary keys and 0 orphan foreign key records across all tables (100% pass rate in [Validation_Report.md](Validation_Report.md)).

---

## 2. Directory Structure

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
│       ├── Customers.csv                            # 115,327 customers
│       ├── Orders.csv                               # 408,782 order headers
│       └── OrderDetails.csv                         # 584,524 line items
│
├── notebooks/
│   ├── 01_exploratory_data_analysis.ipynb           # EDA & profiling notebook
│   ├── 02_data_cleaning.ipynb                       # Cleaning & normalization notebook
│   └── figures/                                     # Exported EDA plots
│
├── sql/
│   ├── 01_Create_Database.sql                       # Database creation DDL
│   ├── 02_Create_Tables.sql                         # Relational table DDL
│   ├── 03_Load_Data.sql                             # BULK INSERT statements
│   ├── 04_Constraints_Indexes.sql                   # PKs, FKs, checks, and indexes
│   └── 05_Validation.sql                            # Verification queries
│
├── documentation/
│   ├── Business_Requirements.md                     # Business requirements & questions
│   ├── Data_Dictionary.md                           # Column metadata & types
│   ├── Data_Quality_Report.md                       # Quality defect log
│   ├── Dataset_Inventory.md                         # File structures and grains
│   ├── EDA_Findings.md                              # Key analysis findings
│   ├── KPI_Definitions.md                           # KPI catalog & formulas
│   ├── Data_Cleaning_Report.md                      # Log of cleaning transformations
│   ├── Data_Integration_Report.md                   # Relational schema reconciliation
│   ├── Database_Design.md                           # Relational architecture specs
│   ├── Validation_Report.md                         # Automated test results
│   └── Handover_Document.md                         # Technical handover guide
│
├── diagrams/
│   └── ERD.md                                       # Entity relationship diagram
│
├── README.md
└── requirements.txt
```

---

## 3. Handover to Data Warehouse & Dimensional Modeling

The relational database (`RetailEcommerce_DB`) serves as the structured operational source for building the analytical Data Warehouse and Star Schema.

### Recommended Star Schema Architecture:
1. **Dimension Tables:**
   - `Dim_Customer`: Sourced from `Customers`, enriched with customer purchase tiers and lifetime frequency.
   - `Dim_Product`: Sourced from `Products`, joined with `Categories(category_name)`.
   - `Dim_PaymentMethod`: Sourced from `PaymentMethods`, with channel groupings (COD, Mobile Wallet, Net Banking, Credit/Debit).
   - `Dim_Date`: Generated calendar dimension spanning July 2016 through August 2018 (Year, Quarter, Month, Weekday, Weekend flag, Fiscal Year).
2. **Fact Tables:**
   - `Fact_Orders` (Order Header Grain): Sourced from `Orders` (`order_id`, `customer_id`, `payment_method_id`, `order_date_key`, `status`, `grand_total`).
   - `Fact_OrderItems` (Line Item Grain): Sourced from `OrderDetails` (`order_detail_id`, `order_id`, `product_id`, `qty_ordered`, `price`, `discount_amount`, `total_amount`).

### Recommended Analytical Queries to Implement:
- Monthly revenue trends and year-over-year seasonality.
- Fulfillment and cancellation rate analysis by payment gateway.
- Product category revenue contribution and return rates.
- Customer segmentation (One-Time vs. Repeat Buyers).

---

## 4. Handover to SSIS ETL Pipeline

- Source files are prepared in `data/cleaned/` with UTF-8 encoding and comma delimiters.
- Staging table structures match the column specifications in `sql/02_Create_Tables.sql`.
- Referential integrity must follow load order: `Categories` & `PaymentMethods` $\rightarrow$ `Products` & `Customers` $\rightarrow$ `Orders` $\rightarrow$ `OrderDetails`.

---

## 5. Handover to Power BI Reporting

- **Business Requirements:** Defined in [Business_Requirements.md](Business_Requirements.md).
- **KPI Metrics:** Formulated in [KPI_Definitions.md](KPI_Definitions.md).
- **Core Visualizations:** 6 baseline exploratory charts are available in `notebooks/figures/`.
