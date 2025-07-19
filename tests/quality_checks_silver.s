/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

-- ====================================================================
-- Checking 'silver.crm_cust_info'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    cst_id,
    COUNT(*) 
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- TABLE: silver.crm_cust_info
-- COLUMN: cst_id

SELECT
cst_id,
COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

-- Check for unwanted Spaces
-- Expectations: No Reults
SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

-- Data Standarization & Consistency
SELECT DISTINCT cst_material_status
FROM silver.crm_cust_info

SELECT * FROM silver.crm_cust_info

--------------------------------
  
-- Check for Nulss or Duplicates in Primary Key.
-- Expectations: No Result.
SELECT
	prd_id,
	COUNT(*)
	FROM bronze.crm_prd_info
	GROUP BY prd_id
	HAVING COUNT(*) > 1 OR prd_id IS NULL

-- Check for unwanted Spaces.
-- Expectation: No Result
SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- Check for NULLs or Negative Numbers
-- Expectations: No Results
SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

-- Data Standarization & Consistency
SELECT DISTINCT prd_line 
FROM bronze.crm_prd_info

-- Check for Invalid Date Orders
SELECT *
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt
-------------- Silver Checks. -----------------
-- ====================================================================
-- Checking 'silver.crm_prd_info'
-- ====================================================================
-- Check for unwanted Spaces.
-- Expectation: No Result
SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- Check for NULLs or Negative Numbers
-- Expectations: No Results
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

-- Data Standarization & Consistency
SELECT DISTINCT prd_line 
FROM silver.crm_prd_info

-- Check for Invalid Date Orders
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

SELECT * FROM silver.crm_prd_info
-----------------------------------
--- Sales Details CRM -----------------
-- ====================================================================
-- Checking 'silver.crm_sales_details'
-- ====================================================================
-- check for invalid dates
SELECT
NULLIF(sls_order_dt,0) sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <=0 
OR LEN(sls_order_dt) != 8
OR sls_order_dt > 20500101
OR sls_order_dt < 19000101
-------------------------------- 
SELECT
NULLIF(sls_ship_dt,0) sls_ship_dt
FROM bronze.crm_sales_details
WHERE sls_ship_dt <=0 
OR LEN(sls_ship_dt) != 8
OR sls_ship_dt > 20500101
OR sls_ship_dt < 19000101
-------------------------------
SELECT
NULLIF(sls_due_dt,0) sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt <=0 
OR LEN(sls_due_dt) != 8
OR sls_due_dt > 20500101
OR sls_due_dt < 19000101
------------------------------
-- Check for invalid Date Orders
SELECT
*
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt
------------------------------
-- Check Data Consistency: Between Sales, Quantity and Price
-- >> Sales = Quantity * Price
-- >> Values must not be NULL, zero or negative.

SELECT DISTINCT
sls_sales AS old_sls_sales,
sls_quantity,
sls_price as old_sls_price, 

CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * abs(sls_price)
		THEN sls_quantity * ABS(sls_price)
	ELSE sls_sales
END AS sls_sales,

CASE WHEN sls_price IS NULL OR sls_price <= 0
		THEN sls_sales / NULLIF(sls_quantity,0)
	ELSE sls_price
END AS sls_price

FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price 
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity,sls_price
-----------------------------------
SELECT * FROM silver.crm_sales_details
----------------------------------------

-- Identify Out-Of-Range Dates
SELECT DISTINCT
bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE()

-- Data Standarization and Consistency
SELECT DISTINCT gen
FROM silver.erp_cust_az12

----------------------------------------
-- Data Standarization and Consistency
SELECT DISTINCT cntry
FROM silver.erp_loc_a101
ORDER BY cntry

SELECT * FROM silver.erp_loc_a101
----------------------------------------
-- Check for unwanted Spaces
SELECT *
FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance)

-- Check Data Standardiazation and Consistency
SELECT DISTINCT
subcat
FROM bronze.erp_px_cat_g1v2
---------------------------------------
