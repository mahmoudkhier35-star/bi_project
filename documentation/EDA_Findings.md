# Exploratory Data Analysis: Key Findings & Observations
## Retail & E-Commerce Platform

---

## 1. Fulfillment Breakdown: 49.4% Order Drop-Off
- **Observation:** Only 41.5% of placed orders reach completed status. 36.4% of orders are canceled prior to fulfillment, and 13.0% are returned or refunded post-delivery.
- **Numbers:** Out of 408,782 total orders placed, 169,502 completed, 148,656 were canceled, and 53,158 were returned/refunded.
- **Why it matters:** Out of 4.195B PKR in placed order demand, only 958.8M PKR materialized into completed net revenue. Customer acquisition spend is wasted when nearly half of placed orders fail to complete.
- **Recommended Action:** Implement pre-dispatch verification (e.g., SMS/WhatsApp confirmation for COD orders) and add address validation at checkout.

---

## 2. Digital Gateway Friction vs. Cash on Delivery (COD)
- **Observation:** Digital payment methods show cancellation rates exceeding 60-70%, while Cash on Delivery (COD) shows low cancellation but high post-delivery return rates.
- **Numbers:**
  - **Payaxis (Card Gateway):** 66.1% canceled, 23.3% completed (67,912 orders, 703.8M PKR lost in cancellations).
  - **Easypay (Mobile Wallet):** 64.8% canceled, 22.7% completed (60,278 orders, 559.6M PKR lost in cancellations).
  - **Bank Alfalah:** 72.9% canceled, 2.4% completed (16,912 orders, 448.9M PKR lost in cancellations).
  - **Cash on Delivery (COD):** 8.0% canceled, 58.4% completed, but **23.7% returned/refunded** at the doorstep (182,449 orders).
- **Why it matters:** The platform faces two distinct operational bottlenecks:
  1. *Online payment drop-offs:* Clunky payment gateway redirects, OTP failures, and banking authorization errors cause shoppers to abandon orders.
  2. *COD delivery refusals:* COD shoppers face no upfront financial commitment and can refuse delivery on impulse, driving up return-to-origin (RTO) courier costs.
- **Recommended Action:** Optimize payment gateway SDKs to reduce checkout timeout errors; require a small advance shipping deposit on high-value COD orders to verify buyer intent.

---

## 3. Seasonality & Promotional Peaks
- **Observation:** Sales volume is heavily concentrated in November mega-sales (November 2016 and November 2017), followed by fulfillment dips and elevated return rates.
- **Numbers:**
  - November 2017 saw over 90,000 orders placed in a single month (>350M PKR in gross demand).
  - However, completed revenue lagged significantly as courier networks became congested, leading to delivery delays and doorstep cancellations.
- **Why it matters:** Order surges during promotion peaks exceed partner courier handling capacity, damaging customer experience.
- **Recommended Action:** Set daily dispatch caps during sales events based on confirmed courier pickup quotas.

---

## 4. Category Performance & Return Rates
- **Observation:** Product categories show different margin and fulfillment profiles. Electronics drive large order values with lower return rates, whereas fashion items drive high item volume but higher returns.
- **Numbers:**
  - **Mobiles & Tablets:** Generated the largest demand (>2.31B PKR), 36.0% completion rate, 10.1% return rate.
  - **Appliances:** 612.4M PKR demand, 39.5% completion rate, 10.0% return rate.
  - **Women's Fashion:** High volume (59,721 items), 48.2% completion, but **14.2% return rate**.
  - **Men's Fashion:** High volume (92,221 items), 13.6% return rate.
  - **Superstore & Beauty:** High completion rates (>55%), returns under 5%, but lower average ticket size.
- **Why it matters:** High returns in fashion erode already thin margins due to reverse courier charges and inventory repackaging costs.
- **Recommended Action:** Improve product sizing charts and customer photo reviews on apparel pages to reduce sizing-related returns.

---

## 5. Customer Purchase Frequency & Wholesale Accounts
- **Observation:** More than half of customers purchase once and never return, while a small group of wholesale accounts drives significant volume.
- **Numbers:**
  - **One-time buyers:** 62,240 customers (54.0% of customer base) placed only 1 order, generating 445.3M PKR.
  - **Repeat buyers (2-10 orders):** 47,739 customers (41.4%) placed 172,074 orders, generating 1.70B PKR.
  - **Frequent buyers (11-50 orders):** 4,779 customers (4.1%) placed 93,078 orders, generating 1.18B PKR.
  - **Wholesale / Power buyers (50+ orders):** 568 accounts (0.5%) placed 81,381 orders, generating 867.5M PKR (average spend: 1.53M PKR per account).
- **Why it matters:** The 54% one-time buyer rate shows weak organic retention. Meanwhile, the top 568 accounts are commercial resellers who depend on the platform for inventory.
- **Recommended Action:** Implement automated post-purchase re-engagement campaigns within 14 days of delivery; create a dedicated wholesale ordering portal with volume pricing for B2B buyers.
