CREATE DATABASE IF NOT EXISTS CarPriceDB;
USE CarPriceDB;

CREATE TABLE IF NOT EXISTS CarPrices (
    id INT PRIMARY KEY AUTO_INCREMENT,
    make VARCHAR(50),
    model VARCHAR(50),
    year INT,
    mileage INT,
    horsepower INT,
    price DECIMAL(10,2),
    fuel_type VARCHAR(50),
    transmission VARCHAR(50)
);

-- Feature Engineering: 
----- Calculate Age of Car
ALTER TABLE CarPrices ADD COLUMN age_of_car INT;
UPDATE CarPrices SET age_of_car = YEAR(CURDATE()) - year;

-- Calculate Mileage per Year
ALTER TABLE CarPrices ADD COLUMN mileage_per_year DECIMAL(10,2);
UPDATE CarPrices SET mileage_per_year = mileage;

-- Calculate Price per Horsepower
ALTER TABLE CarPrices ADD COLUMN price_per_hp DECIMAL(10,2);
UPDATE CarPrices SET price_per_hp = price;

-- 4. Encoding categorical variables using Label Encoding
-- Fuel Type Encoding (Example: Gasoline=1, Diesel=2, Electric=3)
ALTER TABLE CarPrices ADD COLUMN fuel_type_encoded INT;
UPDATE CarPrices 
SET fuel_type_encoded = CASE 
    WHEN fuel_type = 'Gasoline' THEN 1
    WHEN fuel_type = 'Diesel' THEN 2
    WHEN fuel_type = 'Electric' THEN 3
    ELSE 0 
END;


-- Transmission Encoding (Example: Automatic=1, Manual=2, Other=3)
ALTER TABLE CarPrices ADD COLUMN transmission_encoded INT;
UPDATE CarPrices 
SET transmission_encoded = CASE 
    WHEN transmission = 'Automatic' THEN 1
    WHEN transmission = 'Manual' THEN 2
    ELSE 3 
END;

-- 5.Product
-- Average price by car age
SELECT age_of_car, AVG(price) AS avg_price 
FROM CarPrices 
GROUP BY age_of_car 
ORDER BY age_of_car;


-- Average mileage per year grouped by fuel type
SELECT fuel_type, AVG(mileage_per_year) AS avg_mileage_per_year 
FROM CarPrices 
GROUP BY fuel_type;

-- Transmission preference and price distribution
SELECT transmission, COUNT(*) AS count, AVG(price) AS avg_price 
FROM CarPrices 
GROUP BY transmission 
ORDER BY count DESC;

-- Identify Popular Car Models
ALTER TABLE CarPrices ADD COLUMN model_popularity INT;
UPDATE CarPrices 
SET model_popularity = (SELECT COUNT(*) FROM CarPrices AS c WHERE c.model = CarPrices.model);

-- Average price by car age
SELECT age_of_car, AVG(price) AS avg_price 
FROM CarPrices 
GROUP BY age_of_car 
ORDER BY age_of_car;

-- Transmission preference and price distribution
SELECT transmission, COUNT(*) AS count, AVG(price) AS avg_price 
FROM CarPrices 
GROUP BY transmission 
ORDER BY count DESC;

-- Most popular car models
SELECT model, COUNT(*) AS model_count 
FROM CarPrices 
GROUP BY model 
ORDER BY model_count DESC;
