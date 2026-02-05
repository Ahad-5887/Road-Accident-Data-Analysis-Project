
-- SQL QUERIES FOR VALIDATION OF ROAD ACCIDENT ANALYSIS PROJECT

USE road_accident;

SELECT * FROM road_accident;

-- CY & PY Accidents

-- Year = '2022'
SELECT COUNT(DISTINCT accident_index) AS CY_Accidents
FROM road_accident
WHERE YEAR(accident_date) = '2022';

-- Year = '2021'
SELECT SUM(number_of_casualties) AS PY_Casualties
FROM road_accident
WHERE YEAR(accident_date) = '2021';

-- CY & PY Casualties

-- Year = '2022'
SELECT SUM(number_of_casualties) AS CY_Casualties
FROM road_accident
WHERE YEAR(accident_date) = '2022';

-- Year = '2021'
SELECT SUM(number_of_casualties) AS PY_Casualties
FROM road_accident
WHERE YEAR(accident_date) = '2021';


-- Casualties by Road Surface Condition

SELECT 
    Road_Conditions,
    SUM(number_of_casualties) AS Total_Casualties
FROM (
    SELECT
        CASE 
            WHEN road_surface_conditions IN ('Frost or ice','Snow') THEN 'Snow / Ice'
            WHEN road_surface_conditions IN ('Flood over 3cm. deep','Wet or damp') THEN 'Wet'
            ELSE 'Dry'
        END AS Road_Conditions,
        number_of_casualties
    FROM road_accident
) t1
GROUP BY Road_Conditions
ORDER BY Total_Casualties DESC;

-- Year = '2022'
SELECT 
    Road_Conditions,
    SUM(number_of_casualties) AS CY_Casualties
FROM (
    SELECT
        CASE 
            WHEN road_surface_conditions IN ('Frost or ice','Snow') THEN 'Snow / Ice'
            WHEN road_surface_conditions IN ('Flood over 3cm. deep','Wet or damp') THEN 'Wet'
            ELSE 'Dry'
        END AS Road_Conditions,
        number_of_casualties
    FROM road_accident
    WHERE YEAR(accident_date) = 2022
) t1
GROUP BY Road_Conditions
ORDER BY CY_Casualties DESC;

-- Year = '2021'
SELECT 
    Road_Conditions,
    SUM(number_of_casualties) AS PY_Casualties
FROM (
    SELECT
        CASE 
            WHEN road_surface_conditions IN ('Frost or ice','Snow') THEN 'Snow / Ice'
            WHEN road_surface_conditions IN ('Flood over 3cm. deep','Wet or damp') THEN 'Wet'
            ELSE 'Dry'
        END AS Road_Conditions,
        number_of_casualties
    FROM road_accident
    WHERE YEAR(accident_date) = 2021
) t1
GROUP BY Road_Conditions
ORDER BY PY_Casualties DESC;

-- Total Casualties by Severity

SELECT SUM(number_of_casualties) AS CY_Casualties_by_severity_Fatal
FROM road_accident
WHERE accident_severity = 'Fatal';

SELECT SUM(number_of_casualties) AS CY_Casualties_by_severity_Serious
FROM road_accident
WHERE accident_severity = 'Serious';

SELECT SUM(number_of_casualties) AS CY_Casualties_by_severity_Slight
FROM road_accident
WHERE accident_severity = 'Slight';

--	CY Casualties by Severity
SELECT SUM(number_of_casualties) AS CY_Casualties_by_severity_fatal
FROM road_accident
WHERE YEAR(accident_date) = '2022' AND accident_severity = 'Fatal';

SELECT SUM(number_of_casualties) AS CY_Casualties_by_severity_serious
FROM road_accident
WHERE YEAR(accident_date) = '2022' AND accident_severity = 'Serious';

SELECT SUM(number_of_casualties) AS CY_Casualties_by_severity_Slight
FROM road_accident
WHERE YEAR(accident_date) = '2022' AND accident_severity = 'Slight';

--	PY Casualties by Severity
SELECT SUM(number_of_casualties) AS PY_Casualties_by_severity_fatal
FROM road_accident
WHERE YEAR(accident_date) = '2022' AND accident_severity = 'Fatal';

SELECT SUM(number_of_casualties) AS PY_Casualties_by_severity_serious
FROM road_accident
WHERE YEAR(accident_date) = '2022' AND accident_severity = 'Serious';

SELECT SUM(number_of_casualties) AS PY_Casualties_by_severity_Slight
FROM road_accident
WHERE YEAR(accident_date) = '2022' AND accident_severity = 'Slight';

-- Total Severity  Percentage

SELECT CAST(CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) * 100 / 
(SELECT CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) FROM road_accident) AS DECIMAL(10,2)) AS Fatal_Percentage
FROM road_accident
WHERE accident_severity = 'Fatal';

SELECT CAST(CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) * 100 / 
(SELECT CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) FROM road_accident) AS DECIMAL(10,2)) AS Serious_Percentage
FROM road_accident
WHERE accident_severity = 'Serious';

SELECT CAST(CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) * 100 / 
(SELECT CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) FROM road_accident) AS DECIMAL(10,2)) AS Slight_Percentage
FROM road_accident
WHERE accident_severity = 'Slight';

-- Casualities w.r.t Weather_Conditions

SELECT 
    Weather_Condition,
    SUM(number_of_casualties) AS Total_Casualties
FROM (
    SELECT
        CASE 
            WHEN weather_conditions IN ('Fine + high winds','Fine no high winds') THEN 'Fine'
            WHEN weather_conditions IN (
                'Fog or mist',
                'Snowing + high winds',
                'Snowing no high winds'
            ) THEN 'Snow / Fog'
            WHEN weather_conditions IN (
                'Raining + high winds',
                'Raining no high winds'
            ) THEN 'Rain'
            ELSE 'Other'
        END AS Weather_Condition,
        number_of_casualties
    FROM road_accident
) t1
GROUP BY Weather_Condition
ORDER BY Total_Casualties DESC;

-- Year = '2022'
SELECT 
    Weather_Condition,
    SUM(number_of_casualties) AS CY_Casualties
FROM (
    SELECT
        CASE 
            WHEN weather_conditions IN ('Fine + high winds','Fine no high winds') THEN 'Fine'
            WHEN weather_conditions IN (
                'Fog or mist',
                'Snowing + high winds',
                'Snowing no high winds'
            ) THEN 'Snow / Fog'
            WHEN weather_conditions IN (
                'Raining + high winds',
                'Raining no high winds'
            ) THEN 'Rain'
            ELSE 'Other'
        END AS Weather_Condition,
        number_of_casualties
    FROM road_accident
    WHERE YEAR(accident_date) = 2022
) t1
GROUP BY Weather_Condition
ORDER BY CY_Casualties DESC;

-- Year = '2021'
SELECT 
    Weather_Condition,
    SUM(number_of_casualties) AS PY_Casualties
FROM (
    SELECT
        CASE 
            WHEN weather_conditions IN ('Fine + high winds','Fine no high winds') THEN 'Fine'
            WHEN weather_conditions IN (
                'Fog or mist',
                'Snowing + high winds',
                'Snowing no high winds'
            ) THEN 'Snow / Fog'
            WHEN weather_conditions IN (
                'Raining + high winds',
                'Raining no high winds'
            ) THEN 'Rain'
            ELSE 'Other'
        END AS Weather_Condition,
        number_of_casualties
    FROM road_accident
    WHERE YEAR(accident_date) = 2021
) t1
GROUP BY Weather_Condition
ORDER BY PY_Casualties DESC;

-- Casualties w.r.t vehicles

-- Total Casualties
SELECT 
    vehicle_group Vehicle_Group,
    SUM(number_of_casualties) AS Total_Casualties
FROM (
    SELECT
        CASE 
            WHEN vehicle_type = 'Agricultural vehicle' THEN 'Agricultural'
            WHEN vehicle_type IN (
                'Motorcycle 125cc and under',
                'Motorcycle 50cc and under',
                'Motorcycle over 125cc and up to 500cc',
                'Motorcycle over 500cc',
                'Pedal cycle'
            ) THEN 'Bike'
            WHEN vehicle_type IN (
                'Bus or coach (17 or more pass seats)',
                'Minibus (8 – 16 passenger seats)'
            ) THEN 'Bus'
            WHEN vehicle_type IN ('Car', 'Taxi/Private hire car') THEN 'Car'
            WHEN vehicle_type IN (
                'Goods 7.5 tonnes mgw and over',
                'Goods over 3.5t. and under 7.5t',
                'Van / Goods 3.5 tonnes mgw or under'
            ) THEN 'Van'
            ELSE 'Other'
        END AS vehicle_group,
        number_of_casualties
    FROM road_accident
) t1
GROUP BY vehicle_group
ORDER BY Total_Casualties DESC;

-- Year = '2022'
SELECT 
    vehicle_group Vehicle_Group,
    SUM(number_of_casualties) AS CY_Casualties
FROM (
    SELECT
        CASE 
            WHEN vehicle_type = 'Agricultural vehicle' THEN 'Agricultural'
            WHEN vehicle_type IN (
                'Motorcycle 125cc and under',
                'Motorcycle 50cc and under',
                'Motorcycle over 125cc and up to 500cc',
                'Motorcycle over 500cc',
                'Pedal cycle'
            ) THEN 'Bike'
            WHEN vehicle_type IN (
                'Bus or coach (17 or more pass seats)',
                'Minibus (8 – 16 passenger seats)'
            ) THEN 'Bus'
            WHEN vehicle_type IN ('Car', 'Taxi/Private hire car') THEN 'Car'
            WHEN vehicle_type IN (
                'Goods 7.5 tonnes mgw and over',
                'Goods over 3.5t. and under 7.5t',
                'Van / Goods 3.5 tonnes mgw or under'
            ) THEN 'Van'
            ELSE 'Other'
        END AS vehicle_group,
        number_of_casualties
    FROM road_accident
    WHERE YEAR(accident_date) = 2022
) t1
GROUP BY vehicle_group
ORDER BY CY_Casualties DESC;

-- Year = '2021'
SELECT 
    vehicle_group Vehicle_Group,
    SUM(number_of_casualties) AS PY_Casualties
FROM (
    SELECT
        CASE 
            WHEN vehicle_type = 'Agricultural vehicle' THEN 'Agricultural'
            WHEN vehicle_type IN (
                'Motorcycle 125cc and under',
                'Motorcycle 50cc and under',
                'Motorcycle over 125cc and up to 500cc',
                'Motorcycle over 500cc',
                'Pedal cycle'
            ) THEN 'Bike'
            WHEN vehicle_type IN (
                'Bus or coach (17 or more pass seats)',
                'Minibus (8 – 16 passenger seats)'
            ) THEN 'Bus'
            WHEN vehicle_type IN ('Car', 'Taxi/Private hire car') THEN 'Car'
            WHEN vehicle_type IN (
                'Goods 7.5 tonnes mgw and over',
                'Goods over 3.5t. and under 7.5t',
                'Van / Goods 3.5 tonnes mgw or under'
            ) THEN 'Van'
            ELSE 'Other'
        END AS vehicle_group,
        number_of_casualties
    FROM road_accident
    WHERE YEAR(accident_date) = 2021
) t1
GROUP BY vehicle_group
ORDER BY PY_Casualties DESC;

-- Casualties w.r.t. Month

-- Year = '2022'
SELECT DATENAME(MONTH, accident_date) Month_Name, SUM(number_of_casualties) CY_Casualties
FROM road_accident
WHERE YEAR(accident_date) = '2022'
GROUP BY DATENAME(MONTH, accident_date), MONTH(accident_date)
ORDER BY MONTH(accident_date);

-- Year = '2021'
SELECT DATENAME(MONTH, accident_date) Month_Name, SUM(number_of_casualties) PY_Casualties
FROM road_accident
WHERE YEAR(accident_date) = '2021'
GROUP BY DATENAME(MONTH, accident_date), MONTH(accident_date)
ORDER BY MONTH(accident_date);

-- Casualties w.r.t. Road_Type

-- Year = '2022'
SELECT road_type Road_Type, SUM(number_of_casualties) CY_Casualties
FROM road_accident
WHERE YEAR(accident_date) = '2022'
Group By road_type
ORDER BY CY_Casualties DESC;

-- Year = '2021'
SELECT road_type Road_Type, SUM(number_of_casualties) PY_Casualties
FROM road_accident
WHERE YEAR(accident_date) = '2021'
Group By road_type
ORDER BY PY_Casualties DESC;

-- Casualties w.r.t. Area

-- Year = '2022'
SELECT urban_or_rural_area Area,SUM(number_of_casualties) CY_Casualties,
    CAST(CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) * 100 / 
        CAST((SELECT SUM(number_of_casualties) 
          FROM road_accident 
          WHERE YEAR(accident_date) = '2022') AS DECIMAL(10,2)) AS DECIMAL(10,2)) Percentage
FROM road_accident
WHERE YEAR(accident_date) = '2022'
Group By urban_or_rural_area
ORDER BY CY_Casualties DESC;

-- Year = '2021'
SELECT urban_or_rural_area Area,SUM(number_of_casualties) PY_Casualties,
    CAST(CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) * 100 / 
        CAST((SELECT SUM(number_of_casualties) 
        FROM road_accident 
        WHERE YEAR(accident_date) = '2021') AS DECIMAL(10,2)) AS DECIMAL(10,2)) Percentage
FROM road_accident
WHERE YEAR(accident_date) = '2021'
Group By urban_or_rural_area
ORDER BY PY_Casualties DESC;

-- Casualties w.r.t. Light Conditions

-- Year = '2022'
SELECT 
    Light_Conditions,
    SUM(number_of_casualties) AS CY_Casualties,
    CAST(CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) * 100 / 
            CAST((SELECT SUM(number_of_casualties) 
            FROM road_accident 
            WHERE YEAR(accident_date) = '2022') AS DECIMAL(10,2)) AS DECIMAL(10,2)) Percentage
FROM (
    SELECT
        CASE 
            WHEN light_conditions IN (
                'Darkness - lighting unknown',
                'Darkness - lights lit',
                'Darkness - lights unlit',
                'Darkness - no lighting'
            ) THEN 'Night'
            ELSE 'Day'
        END AS Light_Conditions,
        number_of_casualties
    FROM road_accident
    WHERE YEAR(accident_date) = '2022'
) t1
GROUP BY Light_Conditions
ORDER BY CY_Casualties DESC;

-- Year = '2021'
SELECT 
    Light_Conditions,
    SUM(number_of_casualties) AS CY_Casualties,
    CAST(CAST(SUM(number_of_casualties) AS DECIMAL(10,2)) * 100 / 
            CAST((SELECT SUM(number_of_casualties) 
            FROM road_accident 
            WHERE YEAR(accident_date) = '2021') AS DECIMAL(10,2)) AS DECIMAL(10,2)) Percentage
FROM (
    SELECT
        CASE 
            WHEN light_conditions IN (
                'Darkness - lighting unknown',
                'Darkness - lights lit',
                'Darkness - lights unlit',
                'Darkness - no lighting'
            ) THEN 'Night'
            ELSE 'Day'
        END AS Light_Conditions,
        number_of_casualties
    FROM road_accident
    WHERE YEAR(accident_date) = '2021'
) t1
GROUP BY Light_Conditions
ORDER BY CY_Casualties DESC;

-- Top 10 Locations Casualities

SELECT TOP 10 local_authority Locations, SUM(number_of_casualties) Total_Casualities
FROM road_accident
GROUP BY local_authority
ORDER BY Total_Casualities DESC;

-- Year = '2022'
SELECT TOP 10 local_authority Locations, SUM(number_of_casualties) CY_Casualities
FROM road_accident
WHERE YEAR(accident_date) = '2022'
GROUP BY local_authority
ORDER BY CY_Casualities DESC;

-- Year = '2021'
SELECT TOP 10 local_authority Locations, SUM(number_of_casualties) PY_Casualities
FROM road_accident
WHERE YEAR(accident_date) = '2021'
GROUP BY local_authority
ORDER BY PY_Casualities DESC;