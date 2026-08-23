select * from sales limit 10
--SALES ANALYSIS==================================================================
--KPI
-- 1.total revenue for may
SELECT SUM(final_invoice_amount) AS total_revenue
FROM sales
WHERE month = 'May';
--2.total orders for may
SELECT COUNT(order_id) AS total_orders
FROM sales
WHERE month = 'May';
--3.avg order value
SELECT AVG(final_invoice_amount) AS average_order_value
FROM sales
WHERE month = 'May';
--4.highest order value (costly product)
SELECT MAX(final_invoice_amount) AS highest_order
FROM sales
WHERE month = 'May';
--===================================================================
--Product Peformance
--5.top product by revenue
SELECT
product_name,
SUM(final_invoice_amount) AS revenue
FROM sales
WHERE month = 'May'
GROUP BY product_name
ORDER BY revenue DESC;
--6.no.of orders per product
SELECT
product_name,
COUNT(*) AS total_orders
FROM sales
WHERE month = 'May'
GROUP BY product_name
ORDER BY total_orders DESC;
--=================================================================
--Sate wise analysis
--7.revenue by state
SELECT
billing_state,
SUM(final_invoice_amount) AS revenue
FROM sales
WHERE month = 'May'
GROUP BY billing_state
ORDER BY revenue DESC;
--8.by orders
SELECT
billing_state,
COUNT(*) AS orders
FROM sales
WHERE month = 'May'
GROUP BY billing_state
ORDER BY orders DESC;
--================================================================
--Trend
--9. which day customer placed more orders
SELECT
weekday,
COUNT(*) AS orders
FROM sales
WHERE month = 'May'
GROUP BY weekday
ORDER BY orders DESC;
--wednesday more revenue too?
SELECT
    weekday,
    COUNT(*) AS total_orders,
    SUM(final_invoice_amount) AS total_revenue
FROM sales
WHERE month = 'May'
GROUP BY weekday
ORDER BY total_revenue DESC;
--===============================================================
--Discount analysis
SELECT
SUM(ABS(total_discount))
FROM sales
WHERE month = 'May';
--10.more revenue on discount?
SELECT
    CASE
        WHEN total_discount = 0 THEN 'No Discount'
        ELSE 'Discount Applied'
    END AS discount_status,
    COUNT(*) AS total_orders,
    SUM(final_invoice_amount) AS total_revenue,
AVG(final_invoice_amount) AS avg_order_value
FROM sales
WHERE month = 'May'
GROUP BY discount_status;
--11.product with high discount
SELECT
product_name,
AVG(ABS(total_discount)) AS avg_discount
FROM sales
WHERE month = 'May'
GROUP BY product_name
ORDER BY avg_discount DESC;
--==========================================================
--12.orders from shopsy
SELECT
is_shopsy_order,
COUNT(*)
FROM sales
WHERE month = 'May'
GROUP BY is_shopsy_order;
--==========================================================
--Payment analysis
--13.payment method prefered
SELECT
order_type,
COUNT(*)
FROM sales
GROUP BY order_type;
--==========================================================
--customer distribution
--14.states with most customer
SELECT
billing_state,
COUNT(DISTINCT beneficiary_name)
FROM sales
GROUP BY billing_state
ORDER BY count DESC;
--===========================================================
--15.customer by revenue
SELECT
beneficiary_name,
SUM(final_invoice_amount) revenue
FROM sales
GROUP BY beneficiary_name
ORDER BY revenue DESC;
--16.do we have repeated customers
SELECT
    beneficiary_name,
    COUNT(order_id) AS total_orders
FROM sales
GROUP BY beneficiary_name
HAVING COUNT(order_id) > 1
ORDER BY total_orders DESC;
--RETURN ANALYSIS========================================================
--17.no of returns=================================================
SELECT COUNT(*) AS total_returned_orders
FROM returns;
--18.return rate====================================================
SELECT
    ROUND(
        (SELECT COUNT(*) FROM returns)::NUMERIC
        /
        (SELECT COUNT(*) FROM sales WHERE month = 'May')
        *100,
        2
    ) AS return_rate_percentage;
--19.no of cancels===============================================
SELECT COUNT(*) AS total_cancelled_orders
FROM cancel;
--20.cancel rate==================================================
SELECT
    ROUND(
        (SELECT COUNT(*) FROM cancel)::NUMERIC
        /
        (SELECT COUNT(*) FROM sales WHERE month = 'May')
        *100,
        2
    ) AS cancellation_rate_percentage;
--21.combined breakdown==========================================
SELECT
    (SELECT COUNT(*) FROM sales WHERE month = 'May') AS total_orders,
    (SELECT COUNT(*) FROM returns) AS returned_orders,
    (SELECT COUNT(*) FROM cancel) AS cancelled_orders;
--22.return reason==============================================
SELECT
    reason,
    COUNT(*) AS total_returns
FROM returns
GROUP BY reason
ORDER BY total_returns DESC
--23.return sub reason===========================================
SELECT
    sub_reason,
    COUNT(*) AS total_returns
FROM returns
GROUP BY sub_reason
ORDER BY total_returns DESC;
--24.contrb=======================================================
SELECT
    reason,
    COUNT(*) AS total_returns,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM returns),
        2
    ) AS percentage
FROM returns
GROUP BY reason
ORDER BY total_returns DESC;
--24.cancel reason===============================================
SELECT
    reason,
    COUNT(*) AS total_cancellations
FROM cancel
GROUP BY reason
ORDER BY total_cancellations DESC;
--25,cancel sub-reason==============================================
SELECT
    sub_reason,
    COUNT(*) AS total_cancellations
FROM cancel
GROUP BY sub_reason
ORDER BY total_cancellations DESC;
--26.contrb=========================================================
SELECT
    reason,
    COUNT(*) AS total_cancellations,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM cancel),
        2
    ) AS percentage
FROM cancel
GROUP BY reason
ORDER BY total_cancellations DESC;
--27.product with highest returns================================
SELECT
    sku,
    COUNT(*) AS total_returns
FROM returns
GROUP BY sku
ORDER BY total_returns DESC;
--28.product with highest cancels=================================
SELECT
    sku,
    COUNT(*) AS total_cancellations
FROM cancel
GROUP BY sku
ORDER BY total_cancellations DESC;
--29.total breakdown======================================================
WITH sales_summary AS (
    SELECT
        sku_clean,
        COUNT(DISTINCT order_item_id) AS total_sold
    FROM sales
	WHERE month = 'May'
    GROUP BY sku_clean
),

returns_summary AS (
    SELECT
        sku,
        COUNT(*) AS total_returned
    FROM returns
    GROUP BY sku
)

SELECT
    s.sku_clean,
    s.total_sold,
    COALESCE(r.total_returned, 0) AS total_returned,
    ROUND(
        COALESCE(r.total_returned, 0)::NUMERIC
        / s.total_sold * 100,
        2
    ) AS return_rate_percentage
FROM sales_summary s
LEFT JOIN returns_summary r
ON s.sku_clean = r.sku
ORDER BY return_rate_percentage DESC;
--30.revenue lost(return)================================================
SELECT
    reason,
    COUNT(*) AS total_returns,
    SUM(return_amount) AS revenue_lost
FROM returns
GROUP BY reason
ORDER BY revenue_lost DESC;
--31.revenue lost(cancel)==============================================
SELECT
    sub_reason,
    COUNT(*) AS total_cancels,
    SUM(cancellation_amount) AS revenue_lost
FROM cancel
GROUP BY sub_reason
ORDER BY revenue_lost DESC;
--finding insights(search traffic)==================================
--32.product with highest views=====================================
SELECT
product_title,
SUM(product_views) AS views
FROM search_traffic
GROUP BY product_title
ORDER BY views DESC;
--33.most clicked===================================================
SELECT
product_title,
SUM(product_clicks) AS clicks
FROM search_traffic
GROUP BY product_title
ORDER BY clicks DESC;
--32.highest revenue from search=====================================
SELECT
product_title,
SUM(revenue) AS revenue
FROM search_traffic
GROUP BY product_title
ORDER BY revenue DESC;
--33.highest conversion rate===========================================
SELECT
    product_title,
    SUM(product_views) AS total_views,
    SUM(sales) AS total_units_sold,
    ROUND(AVG(conversion_rate)::numeric, 2) AS avg_conversion_rate
FROM search_traffic
GROUP BY product_title
ORDER BY avg_conversion_rate DESC;
--34.click through rate=============================================
SELECT
product_title,
AVG(click_through_rate) AS ctr
FROM search_traffic
GROUP BY product_title
ORDER BY ctr DESC;
--35.products having high visibility poor conversion===================
SELECT
product_title,
SUM(product_views) AS views,
SUM(sales) AS sales,
ROUND(
SUM(sales)*100.0/
NULLIF(SUM(product_views),0),
2
) AS sales_per_view
FROM search_traffic
GROUP BY product_title
ORDER BY sales_per_view;