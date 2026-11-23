# KPI Definitions & Metric Catalog
## Retail & E-Commerce Platform

---

## 1. Directly Measurable Metrics

### KPI 1: Gross Merchandise Value (GMV)
- **Category:** Financial / Demand
- **Formula:** $\sum (\text{fact\_order\_items.unit\_price} \times \text{fact\_order\_items.qty\_ordered})$
- **Columns:** `unit_price`, `qty_ordered`
- **Meaning:** Total monetary value of all goods ordered prior to discounts, cancellations, or returns.
- **Limitation:** Represents placed customer demand, not realized cash flow.

### KPI 2: Total Units Sold
- **Category:** Operational
- **Formula:** $\sum \text{qty\_ordered}$ WHERE `is_completed = 1`
- **Columns:** `qty_ordered`, `is_completed`
- **Meaning:** Physical units delivered to customers.
- **Limitation:** Can be skewed by bulk orders containing dozens of units in a single line.

### KPI 3: Placed Orders Count
- **Category:** Operational
- **Formula:** $\text{COUNT}(\text{DISTINCT } \text{order\_id})$
- **Columns:** `order_id`
- **Meaning:** Total count of orders submitted through checkout.

### KPI 4: Completed Orders Count
- **Category:** Operational
- **Formula:** $\text{COUNT}(\text{DISTINCT } \text{order\_id})$ WHERE `is_completed = 1`
- **Columns:** `order_id`, `is_completed`
- **Meaning:** Count of orders successfully delivered and paid.

### KPI 5: Active Customer Count
- **Category:** Customer
- **Formula:** $\text{COUNT}(\text{DISTINCT } \text{customer\_id})$ WHERE `customer_id <> 0`
- **Columns:** `customer_id`
- **Meaning:** Distinct registered accounts placing at least one order.

### KPI 6: Promotional Discount Value
- **Category:** Financial
- **Formula:** $\sum \text{discount\_amount}$
- **Columns:** `discount_amount`
- **Meaning:** Total value of coupons and discounts applied to orders.

---

## 2. Calculated Ratios & Metrics with Assumptions

### KPI 7: Net Completed Revenue
- **Category:** Financial
- **Formula:** $\sum \text{order\_net\_amount}$ WHERE `is_completed = 1`
- **Columns:** `order_net_amount`, `is_completed`
- **Meaning:** Realized cash revenue from completed orders after discounts.
- **Assumption:** Orders marked `received` or in-progress are treated as pending and excluded until confirmed `complete`.

### KPI 8: Average Order Value (AOV)
- **Category:** Financial
- **Formula:** $\frac{\text{Net Completed Revenue}}{\text{Completed Orders}}$
- **Columns:** `order_net_amount`, `is_completed`, `order_id`
- **Meaning:** Average completed invoice revenue per delivered order.
- **Assumption:** Calculated strictly on completed orders; calculating on canceled orders would skew the metric.

### KPI 9: Fulfillment Rate (%)
- **Category:** Operational
- **Formula:** $\frac{\text{Completed Orders}}{\text{Total Placed Orders}} \times 100$
- **Columns:** `is_completed`, `order_id`
- **Meaning:** Percentage of placed orders successfully delivered.

### KPI 10: Cancellation Rate (%)
- **Category:** Operational
- **Formula:** $\frac{\text{Canceled Orders}}{\text{Total Placed Orders}} \times 100$
- **Columns:** `is_canceled`, `order_id`
- **Meaning:** Percentage of placed orders aborted pre-dispatch or dropped at gateway.

### KPI 11: Return / Refund Rate (%)
- **Category:** Operational / Logistics
- **Formula:** $\frac{\text{Refunded Orders}}{\text{Total Placed Orders}} \times 100$
- **Columns:** `is_refunded`, `order_id`
- **Meaning:** Percentage of orders returned by customers or rejected at the door.

### KPI 12: Repeat Purchase Rate (%)
- **Category:** Customer Retention
- **Formula:** $\frac{\text{Customers with } \ge 2 \text{ completed orders}}{\text{Total Customers with } \ge 1 \text{ completed order}} \times 100$
- **Columns:** `customer_id`, `is_completed`
- **Meaning:** Percentage of customers who return to make subsequent purchases.

---

## 3. Metrics Not Available in the Dataset

| Desired Metric | Missing Data | Why It Matters |
| :--- | :--- | :--- |
| **Gross Margin (%)** | Cost of Goods Sold (`COGS`) | Profitability cannot be computed directly without item acquisition costs. |
| **Delivery Lead Time** | Dispatch and delivery timestamps | Transit speed and courier SLA compliance cannot be measured. |
| **Geographic Sales Breakdown** | Customer City / Province | Cannot map regional demand or identify courier delivery performance by province. |
| **Return Reasons** | Reason codes | Cannot distinguish between sizing issues, damaged goods, or late delivery. |
| **Cart Abandonment Rate** | Session / Cart Add logs | Only orders that reached checkout submission are recorded. |
