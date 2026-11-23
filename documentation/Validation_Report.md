# Relational Database Validation Report

Total Tests: **17** | Passed: **17** | Failed: **0**

| Test ID | Category | Test Name | Expected | Actual | Status |
| :---: | :--- | :--- | :---: | :---: | :---: |
| TC-01 | Record Count | Categories Count | 16 | 16 | **PASS** |
| TC-02 | Record Count | PaymentMethods Count | 18 | 18 | **PASS** |
| TC-03 | Record Count | Products Count | 84800 | 84800 | **PASS** |
| TC-04 | Record Count | Customers Count | 115327 | 115327 | **PASS** |
| TC-05 | Record Count | Orders Count | 408782 | 408782 | **PASS** |
| TC-06 | Record Count | OrderDetails Count | 584524 | 584524 | **PASS** |
| TC-07 | PK Uniqueness | Categories PK Duplicates | 0 | 0 | **PASS** |
| TC-08 | PK Uniqueness | PaymentMethods PK Duplicates | 0 | 0 | **PASS** |
| TC-09 | PK Uniqueness | Products PK Duplicates | 0 | 0 | **PASS** |
| TC-10 | PK Uniqueness | Customers PK Duplicates | 0 | 0 | **PASS** |
| TC-11 | PK Uniqueness | Orders PK Duplicates | 0 | 0 | **PASS** |
| TC-12 | PK Uniqueness | OrderDetails PK Duplicates | 0 | 0 | **PASS** |
| TC-13 | FK Integrity | Orders -> Customers Orphans | 0 | 0 | **PASS** |
| TC-14 | FK Integrity | Orders -> PaymentMethods Orphans | 0 | 0 | **PASS** |
| TC-15 | FK Integrity | OrderDetails -> Orders Orphans | 0 | 0 | **PASS** |
| TC-16 | FK Integrity | OrderDetails -> Products Orphans | 0 | 0 | **PASS** |
| TC-17 | FK Integrity | Products -> Categories Orphans | 0 | 0 | **PASS** |
