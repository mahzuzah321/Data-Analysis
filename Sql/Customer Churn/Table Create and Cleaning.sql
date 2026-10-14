use customer_churn
CREATE TABLE telecom_customer_churn (
    `Customer ID` VARCHAR(20) PRIMARY KEY,
    `Gender` VARCHAR(10),
    `Age` INT,
    `Married` VARCHAR(5),
    `Number of Dependents` INT,
    `City` VARCHAR(100),
    `Zip Code` INT,
    `Latitude` DECIMAL(10,6),
    `Longitude` DECIMAL(10,6),
    `Number of Referrals` INT,
    `Tenure in Months` INT,
    `Offer` VARCHAR(50),
    `Phone Service` VARCHAR(5),
    `Avg Monthly Long Distance Charges` DECIMAL(10,2),
    `Multiple Lines` VARCHAR(5),
    `Internet Service` VARCHAR(5),
    `Internet Type` VARCHAR(30),
    `Avg Monthly GB Download` DECIMAL(10,2),
    `Online Security` VARCHAR(5),
    `Online Backup` VARCHAR(5),
    `Device Protection Plan` VARCHAR(5),
    `Premium Tech Support` VARCHAR(5),
    `Streaming TV` VARCHAR(5),
    `Streaming Movies` VARCHAR(5),
    `Streaming Music` VARCHAR(5),
    `Unlimited Data` VARCHAR(5),
    `Contract` VARCHAR(30),
    `Paperless Billing` VARCHAR(5),
    `Payment Method` VARCHAR(50),
    `Monthly Charge` DECIMAL(10,2),
    `Total Charges` DECIMAL(12,2),
    `Total Refunds` DECIMAL(10,2),
    `Total Extra Data Charges` DECIMAL(10,2),
    `Total Long Distance Charges` DECIMAL(12,2),
    `Total Revenue` DECIMAL(12,2),
    `Customer Status` VARCHAR(30),
    `Churn Category` VARCHAR(50),
    `Churn Reason` VARCHAR(255)
);


USE telecom_db;

CREATE TABLE telecom_customer_churn_staging (
    `Customer ID` VARCHAR(50),
    `Gender` VARCHAR(50),
    `Age` TEXT,
    `Married` VARCHAR(50),
    `Number of Dependents` TEXT,
    `City` TEXT,
    `Zip Code` TEXT,
    `Latitude` TEXT,
    `Longitude` TEXT,
    `Number of Referrals` TEXT,
    `Tenure in Months` TEXT,
    `Offer` TEXT,
    `Phone Service` VARCHAR(50),
    `Avg Monthly Long Distance Charges` TEXT,
    `Multiple Lines` VARCHAR(50),
    `Internet Service` VARCHAR(50),
    `Internet Type` TEXT,
    `Avg Monthly GB Download` TEXT,
    `Online Security` VARCHAR(50),
    `Online Backup` VARCHAR(50),
    `Device Protection Plan` VARCHAR(50),
    `Premium Tech Support` VARCHAR(50),
    `Streaming TV` VARCHAR(50),
    `Streaming Movies` VARCHAR(50),
    `Streaming Music` VARCHAR(50),
    `Unlimited Data` VARCHAR(50),
    `Contract` TEXT,
    `Paperless Billing` VARCHAR(50),
    `Payment Method` TEXT,
    `Monthly Charge` TEXT,
    `Total Charges` TEXT,
    `Total Refunds` TEXT,
    `Total Extra Data Charges` TEXT,
    `Total Long Distance Charges` TEXT,
    `Total Revenue` TEXT,
    `Customer Status` TEXT,
    `Churn Category` TEXT,
    `Churn Reason` TEXT
);
SET GLOBAL local_infile = ON;
SHOW GLOBAL VARIABLES LIKE 'local_infile';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/telecom_customer_churn.csv'
INTO TABLE telecom_customer_churn_staging
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

TRUNCATE TABLE telecom_customer_churn;

INSERT INTO telecom_customer_churn
SELECT
    `Customer ID`,
    `Gender`,
    NULLIF(`Age`, ''),
    `Married`,
    NULLIF(`Number of Dependents`, ''),
    `City`,
    NULLIF(`Zip Code`, ''),
    NULLIF(`Latitude`, ''),
    NULLIF(`Longitude`, ''),
    NULLIF(`Number of Referrals`, ''),
    NULLIF(`Tenure in Months`, ''),
    `Offer`,
    `Phone Service`,
    NULLIF(`Avg Monthly Long Distance Charges`, ''),
    `Multiple Lines`,
    `Internet Service`,
    `Internet Type`,
    NULLIF(`Avg Monthly GB Download`, ''),
    `Online Security`,
    `Online Backup`,
    `Device Protection Plan`,
    `Premium Tech Support`,
    `Streaming TV`,
    `Streaming Movies`,
    `Streaming Music`,
    `Unlimited Data`,
    `Contract`,
    `Paperless Billing`,
    `Payment Method`,
    NULLIF(`Monthly Charge`, ''),
    NULLIF(`Total Charges`, ''),
    NULLIF(`Total Refunds`, ''),
    NULLIF(`Total Extra Data Charges`, ''),
    NULLIF(`Total Long Distance Charges`, ''),
    NULLIF(`Total Revenue`, ''),
    `Customer Status`,
    `Churn Category`,
    `Churn Reason`
FROM telecom_customer_churn_staging;

SELECT COUNT(*) AS total_customers

SELECT
    COUNT(*) AS total_rows,
    SUM(`Avg Monthly Long Distance Charges` IS NULL)
        AS missing_long_distance_charges
FROM telecom_customer_churn;


SELECT `Customer ID`, COUNT(*) AS occurrences
FROM telecom_customer_churn
GROUP BY `Customer ID`
HAVING COUNT(*) > 1;

SELECT `Customer Status`, COUNT(*) AS total_customers
FROM telecom_customer_churn
GROUP BY `Customer Status`;

SELECT
    SUM(`Monthly Charge` IS NULL) AS missing_monthly_charge,
    SUM(`Total Charges` IS NULL) AS missing_total_charges,
    SUM(`Total Revenue` IS NULL) AS missing_total_revenue,
    SUM(`Avg Monthly Long Distance Charges` IS NULL)
        AS missing_long_distance_charges
FROM telecom_customer_churn;

CREATE TABLE IF NOT EXISTS telecom_zipcode_population (
    `Zip Code` INT PRIMARY KEY,
    `Population` INT
);
SET GLOBAL local_infile = 1;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/telecom_zipcode_population.csv'
INTO TABLE telecom_zipcode_population
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT 'Customer Churn' AS dataset, COUNT(*) AS total_rows
FROM telecom_customer_churn

UNION ALL

SELECT 'Data Dictionary', COUNT(*)
FROM telecom_data_dictionary

UNION ALL



SHOW KEYS FROM telecom_customer_churn
WHERE Key_name = 'PRIMARY';

SHOW KEYS FROM telecom_zipcode_population
WHERE Key_name = 'PRIMARY';

ALTER TABLE telecom_data_dictionary
ADD COLUMN dictionary_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY;


SELECT COUNT(*) AS unmatched_zipcodes
FROM telecom_customer_churn c
LEFT JOIN telecom_zipcode_population z
    ON c.`Zip Code` = z.`Zip Code`
WHERE c.`Zip Code` IS NOT NULL
  AND z.`Zip Code` IS NULL;
  

ALTER TABLE telecom_customer_churn
ADD CONSTRAINT fk_customer_zipcode
FOREIGN KEY (`Zip Code`)
REFERENCES telecom_zipcode_population (`Zip Code`);



SHOW CREATE TABLE telecom_customer_churn;



