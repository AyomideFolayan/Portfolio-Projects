-- 1. average closing price per year
SELECT 
    YEAR(date) AS year, 
    ROUND(AVG(close_price), 2) AS avg_closing_price
FROM alibaba_stock
GROUP BY YEAR(date)
ORDER BY YEAR(date);

-- 2. average daily price fluctuation per year
SELECT 
    YEAR(date) AS year, 
    ROUND(AVG(high_price - low_price), 2) AS avg_daily_volatility
FROM alibaba_stock
GROUP BY YEAR(date)
ORDER BY YEAR(date);


-- 4. days with the highest percentage price changes
SELECT 
    date, 
    open_price, 
    close_price, 
    ROUND(((close_price - open_price) / open_price) * 100, 2) AS daily_change_percent, 
    volume
FROM alibaba_stock
ORDER BY ABS(daily_change_percent) DESC
LIMIT 10;

-- 5. Monthly Performance: average closing price and total trading volume per month
SELECT 
    YEAR(date) AS year, 
    MONTH(date) AS month, 
    ROUND(AVG(close_price), 2) AS avg_closing_price, 
    SUM(volume) AS total_traded_volume
FROM alibaba_stock
GROUP BY YEAR(date), MONTH(date)
ORDER BY YEAR(date), MONTH(date);

-- 6. Moving Average: Calculate a 7-day moving average for closing price
SELECT 
    date, 
    close_price, 
    ROUND(AVG(close_price) OVER (ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS moving_avg_7d
FROM alibaba_stock;

-- Daily Return (Percentage Change)
SELECT 
    date, 
    close_price, 
    LAG(close_price) OVER (ORDER BY date) AS prev_close,
    ROUND(((close_price - LAG(close_price) OVER (ORDER BY date)) / LAG(close_price) OVER (ORDER BY date)) * 100, 2) AS daily_return
FROM alibaba_stock;


-- Volume Change (Day-over-Day)
SELECT 
    date, 
    volume, 
    LAG(volume) OVER (ORDER BY date) AS prev_volume,
    ROUND(((volume - LAG(volume) OVER (ORDER BY date)) / NULLIF(LAG(volume) OVER (ORDER BY date), 0)) * 100, 2) AS volume_change_percent
FROM alibaba_stock;


-- 52-Week High & Low
SELECT 
    date, 
    close_price,
    MAX(close_price) OVER (ORDER BY date ROWS BETWEEN 251 PRECEDING AND CURRENT ROW) AS high_52_week,
    MIN(close_price) OVER (ORDER BY date ROWS BETWEEN 251 PRECEDING AND CURRENT ROW) AS low_52_week
FROM alibaba_stock;

-- close price Day of the Week and Month
SELECT 
    date, 
    DAYOFWEEK(date) AS day_of_week, 
    MONTH(date) AS month,
    close_price
FROM alibaba_stock;

-- Volume Change (Day-over-Day)
SELECT 
    date, 
    volume, 
    LAG(volume) OVER (ORDER BY date) AS prev_volume,
    ROUND(((volume - LAG(volume) OVER (ORDER BY date)) / NULLIF(LAG(volume) OVER (ORDER BY date), 0)) * 100, 2) AS volume_change_percent
FROM alibaba_stock;

