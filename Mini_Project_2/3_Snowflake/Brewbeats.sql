CREATE DATABASE IF NOT EXISTS brewbeats_db;
USE DATABASE brewbeats_db;
USE SCHEMA public;

CREATE OR REPLACE FILE FORMAT csv_format
  TYPE = 'CSV'
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  SKIP_HEADER = 1;

CREATE OR REPLACE STAGE brewbeats_stage
  FILE_FORMAT = csv_format;

  LIST @brewbeats_stage; 

  -- Q1. Create table and load coffee_sales.csv
CREATE OR REPLACE TABLE coffee_sales (
    date DATE,
    datetime TIMESTAMP,
    cash_type VARCHAR(20),
    card VARCHAR(50),
    money FLOAT,
    coffee_name VARCHAR(100)
);

COPY INTO coffee_sales
FROM @brewbeats_stage/coffee_sales.csv
FILE_FORMAT = (FORMAT_NAME = csv_format);


-- Q2. Top 3 coffee types by revenue
SELECT coffee_name, ROUND(SUM(money), 2) AS revenue
FROM coffee_sales
GROUP BY coffee_name
ORDER BY revenue DESC
LIMIT 3;

-- Q3. Create table and load Spotify_data.csv
CREATE OR REPLACE TABLE spotify_data (
    id INT,
    acousticness FLOAT, danceability FLOAT, duration_ms INT, energy FLOAT,
    instrumentalness FLOAT, key INT, liveness FLOAT, loudness FLOAT,
    mode INT, speechiness FLOAT, tempo FLOAT, time_signature INT,
    valence FLOAT, target INT, song_title VARCHAR(255), artist VARCHAR(255)
);

COPY INTO spotify_data
FROM '@brewbeats_stage/Spotify data.csv'
FILE_FORMAT = (FORMAT_NAME = csv_format);

-- Q4. Top 3 songs by Drake
CREATE OR REPLACE TABLE spotify_data (
    id INT,
    acousticness FLOAT, danceability FLOAT, duration_ms INT, energy FLOAT,
    instrumentalness FLOAT, key INT, liveness FLOAT, loudness FLOAT,
    mode INT, speechiness FLOAT, tempo FLOAT, time_signature INT,
    valence FLOAT, target INT, song_title VARCHAR(255), artist VARCHAR(255)
);

COPY INTO spotify_data
FROM '@brewbeats_stage/Spotify data.csv'
FILE_FORMAT = (FORMAT_NAME = csv_format);

SELECT song_title, artist, danceability, energy
FROM spotify_data
WHERE LOWER(artist) = 'drake'
ORDER BY danceability DESC, energy DESC
LIMIT 3;