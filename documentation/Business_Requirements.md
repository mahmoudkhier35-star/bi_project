# Business Requirements Document (BRD)
## Retail & E-Commerce Platform

---

## 1. Project Background & Context
The project covers transactional data from an e-commerce platform operating in Pakistan across multiple retail categories (Mobiles & Tablets, Men's & Women's Fashion, Appliances, Superstore, Home & Living). The available transaction history runs from July 2016 through August 2018 (26 months), totaling 584,524 line items, 408,782 distinct orders, and 115,326 customers.

While order volume grew steadily across this period, the business faced significant revenue leakage: a large share of placed orders never converted into delivered, paid sales. In addition, existing reporting relied on flat-file exports where order-level totals were repeated across line items, causing reported GMV to be overstated by roughly 28% (~1.09 billion PKR).

---

## 2. Problem Statement
Only **41.5% of placed orders (169,502 orders)** reach completed status. The remaining 58.5% fall into two main failure buckets:
1. **Pre-fulfillment cancellations (36.4% / 148,656 orders):** Heavily driven by digital payment methods (Easypay, Payaxis, Bank Alfalah) where customer drop-off and gateway failure rates exceed 60-70%.
2. **Post-delivery returns and refunds (13.0% / 53,158 orders):** Primarily affecting Cash on Delivery (COD) shipments, where customers reject packages at the door or request refunds post-delivery.
3. **Low customer repeat rate:** 54.0% of customers place only one order and do not return, pointing to weak customer retention.

---

## 3. Project Objectives
- Build a single source of truth in SQL Server using a normalized relational model, separating order headers from order line items to eliminate revenue over-counting.
- Provide clear operational reporting on fulfillment funnels by payment method, category, and time period.
- Quantify cancellation root causes between payment gateway technical friction and COD doorstep refusals.
- Segment customers by order frequency and identify wholesale accounts vs standard retail buyers.
- Prepare clean normalized relational tables ready for Data Warehouse modeling (Star Schema) and ETL pipelines.

---

## 4. Key Stakeholders
- **Commercial & Merchandising:** Needs net revenue, category demand, and promotional discount tracking.
- **Operations & Logistics:** Needs fulfillment rates, courier return rates, and order completion benchmarks.
- **Payments & Partnerships:** Needs gateway completion tracking to evaluate payment provider performance.
- **CRM & Retention:** Needs customer frequency tiers and cohort retention metrics.
- **Data & BI Team:** Uses the cleaned warehouse tables for ETL workflows and dashboard models.

---

## 5. Core Business Questions
1. What is the actual completed revenue month-over-month versus gross order demand?
2. What are the true fulfillment, cancellation, and return rates across payment methods?
3. Why do digital prepaid channels experience high cancellation while COD experiences high return rates?
4. Which product categories generate the highest completed cash flow versus return rates?
5. What percentage of the customer base consists of one-time buyers versus repeat or wholesale buyers?
6. Does heavy discounting correlate with higher order completion or higher cancellation rates?

---

## 6. Target KPIs

| KPI Name | Definition / Formula | Baseline | Target |
| :--- | :--- | :---: | :---: |
| **Gross Merchandise Value (GMV)** | $\sum (\text{unit\_price} \times \text{qty\_ordered})$ for all orders | 4.195B PKR | Track trend |
| **Net Completed Revenue** | $\sum \text{order\_net\_amount}$ where status = 'complete' | 958.8M PKR | Maximize |
| **Fulfillment Rate** | Completed Orders / Total Orders Placed | 41.5% | > 60% |
| **Cancellation Rate** | Canceled Orders / Total Orders Placed | 36.4% | < 25% |
| **Return / Refund Rate** | Refunded Orders / Total Orders Placed | 13.0% | < 8% |
| **Average Order Value (AOV)** | Net Completed Revenue / Completed Orders | 5,656 PKR | Track trend |
| **Repeat Purchase Rate** | Customers with $\ge 2$ orders / Total Customers | 46.0% | > 52% |

---

## 7. Scope Boundaries

### In Scope
- Exploratory data analysis, statistical profiling, and anomaly detection.
- Data cleaning pipeline (handling nulls, string artifacts, empty padding, and typing).
- Relational schema design (normalized 3NF model with 6 relational tables).
- T-SQL scripts for database creation, table DDL, constraints, indexing, validation checks, views, and core business queries.
- Data dictionary, KPI documentation, and handover notes.

### Out of Scope
- Building visual Power BI `.pbix` report files.
- Implementing physical SSIS `.dtsx` packages in Visual Studio.
- Training predictive machine learning models.

---

## 8. Data Limitations
- **No geographic columns:** The raw dataset lacks customer city, province, or postal code.
- **No cost data (COGS):** Product acquisition cost is missing; net sales revenue is used rather than gross margin.
- **Working Date redundancy:** `Working Date` matches `created_at` in 100% of rows; it does not indicate shipping or delivery date.
- **Return reasons:** The dataset records refunded status, but not the specific customer return reason (e.g., sizing, defect, delayed delivery).
