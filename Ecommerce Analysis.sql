Create Database Ecommerce;
USE Ecommerce;
SELECT * FROM master_table LIMIT 10;

-- 1. What are the top 5 product categories by revenue?
SELECT product_category_name_english,
ROUND(SUM(price + freight_value	),2) AS total_revenue
FROM master_table
GROUP BY product_category_name_english
ORDER BY total_revenue DESC
LIMIT 5;

-- 2. What is the monthly revenue trend?
SELECT DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,
SUM(price + freight_value) AS monthly_revenue
FROM master_table
GROUP BY month
ORDER BY month;

-- 3. What is the average delivery time by state?
SELECT customer_state,
AVG(delivery_days) AS avg_del_days
FROM master_table
WHERE delivery_days IS NOT NULL
GROUP BY customer_state
ORDER BY avg_del_days DESC;

-- 4. Which payment method generates the highest revenue?
SELECT payment_type,
SUM(payment_value) AS total_pay_rev
FROM master_table
GROUP BY payment_type
ORDER BY total_pay_rev DESC;

-- 5. What is the average review score per category?
SELECT product_category_name_english,
AVG(review_score) AS avg_review_score
FROM master_table
WHERE review_score IS NOT NULL
GROUP BY product_category_name_english
ORDER BY avg_review_score DESC;

-- 6. Which sellers generate the highest revenue?
SELECT seller_id,
SUM(price + freight_value) AS seller_revenue
FROM master_table
GROUP BY seller_id
ORDER BY seller_revenue DESC
LIMIT 10;

-- 7. What percentage of orders are delivered late?
SELECT
     ROUND(
     (SUM(
     CASE 
        WHEN order_delivered_customer_date > order_estimated_delivery_date 
        THEN 1 ELSE 0
	 END
     ) / COUNT(*)) * 100,
     2) AS late_delivery_percentage
     FROM master_table
     WHERE order_delivered_customer_date IS NOT NULL;
