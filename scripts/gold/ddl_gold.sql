/*


This script creates views for the gold layer.


*/

CREATE VIEW gold.dim_customers AS
SELECT
	ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
	cst_id AS customer_id,
	cst_key AS customer_number,
	cst_firstname AS first_name,
	cst_lastname AS last_name,
	cntry AS country,
	cst_marital_status AS marital_status,
	CASE WHEN cst_ gndr!='n/a' THEN cst_gndr
		 ELSE COALESCE(gen,'n/a') END AS gender,
	bdate AS birthdate,
	cst_create_date AS create_date
FROM silver.crm_cust_info
LEFT JOIN silver.erp_cust_az12 ON cst_key=cid
LEFT JOIN silver.erp_loc_a101 l ON cst_key=l.cid

SELECT * FROM silver.erp_px_cat_g1v2;

SELECT * FROM silver.crm_prd_info;


CREATE VIEW gold.dim_product AS
SELECT
ROW_NUMBER() OVER (ORDER BY prd_start_dt, prd_key) as product_key,
prd_id AS product_id,
prd_key AS product_number,
prd_nm AS product_name,
cat_id AS category_id,
pc.cat AS category,
pc.subcat AS subcategory,
pc.maintenance,
prd_cost AS cost,
prd_line AS product_line,
prd_start_dt AS start_date
FROM silver.crm_prd_info
LEFT JOIN silver.erp_px_cat_g1v2 pc ON cat_id=id
WHERE prd_end_dt IS NULL;

select * from silver.crm_sales_details
select * from gold.dim_customers


CREATE VIEW gold.fact_sales AS
SELECT
s.sls_ord_num AS order_numer,
pr.product_key,
cus.customer_key,
s.sls_order_dt AS order_date,
s.sls_ship_dt AS shipping_date,
s.sls_due_dt AS due_date,
s.sls_sales AS sales_amount,
s.sls_quantity AS quantity,
s.sls_price price
FROM silver.crm_sales_details s
LEFT JOIN gold.dim_customers cus ON cus.customer_id=s.sls_cust_id
LEFT JOIN gold.dim_product pr ON pr.product_number=s.sls_prd_key

