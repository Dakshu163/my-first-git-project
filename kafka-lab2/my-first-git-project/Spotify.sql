CREATE DATABASE IF NOT EXISTS spotify_db;
CREATE SCHEMA IF NOT EXISTS spotify_db.analytics;

CREATE WAREHOUSE IF NOT EXISTS spotify_wh
  WAREHOUSE_SIZE = 'XSMALL'
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE;

USE WAREHOUSE spotify_wh;
USE DATABASE spotify_db;
USE SCHEMA analytics;

CREATE OR REPLACE FILE FORMAT spotify_csv_ff
  TYPE = CSV
  PARSE_HEADER = TRUE
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  NULL_IF = ('', 'NULL', 'N/A');

CREATE OR REPLACE STAGE spotify_stage
  FILE_FORMAT = spotify_csv_ff;

USE WAREHOUSE spotify_wh;
USE DATABASE spotify_db;
USE SCHEMA analytics;

-- 1. Create file format that skips the header row
CREATE OR REPLACE FILE FORMAT spotify_csv_ff
  TYPE = CSV
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  NULL_IF = ('', 'NULL', 'N/A');

-- 2. Create table matching the exact 17 columns in Spotify data.csv
CREATE OR REPLACE TABLE tracks (
  row_id INT,
  acousticness FLOAT,
  danceability FLOAT,
  duration_ms INT,
  energy FLOAT,
  instrumentalness FLOAT,
  key INT,
  liveness FLOAT,
  loudness FLOAT,
  mode INT,
  speechiness FLOAT,
  tempo FLOAT,
  time_signature INT,
  valence FLOAT,
  target INT,
  song_title STRING,
  artist STRING
);

-- 3. Load the data from your stage
COPY INTO tracks
  FROM @spotify_stage
  FILE_FORMAT = spotify_csv_ff;

-- 4. Verify the 2,017 rows loaded properly
SELECT COUNT(*) AS total_rows FROM tracks;
SELECT * FROM tracks LIMIT 10;

LIST @spotify_stage; 

COPY INTO tracks
  FROM @spotify_stage
  FILE_FORMAT = spotify_csv_ff;

SELECT COUNT(*) AS total_rows FROM tracks;

-- Q1.
SELECT song_title, 
       artist, 
       duration_ms,
       ROUND(duration_ms / 60000.0, 2) AS duration_minutes
FROM tracks
ORDER BY duration_ms DESC
LIMIT 1;


-- Q2. Top 10 most danceable tracks
SELECT song_title, 
       artist, 
       danceability, 
       energy, 
       tempo
FROM tracks
ORDER BY danceability DESC
LIMIT 10;


-- Q3. Top 10 artists by total number of tracks in the dataset
SELECT artist, 
       COUNT(*) AS total_tracks,
       ROUND(AVG(danceability), 3) AS avg_danceability,
       ROUND(AVG(energy), 3) AS avg_energy
FROM tracks
GROUP BY artist
ORDER BY total_tracks DESC
LIMIT 10;

-- Q4. Average audio features comparing Liked (target = 1) vs. Disliked (target = 0) tracks
SELECT target,
       COUNT(*) AS track_count,
       ROUND(AVG(danceability), 3) AS avg_danceability,
       ROUND(AVG(energy), 3) AS avg_energy,
       ROUND(AVG(valence), 3) AS avg_valence,
       ROUND(AVG(acousticness), 3) AS avg_acousticness,
       ROUND(AVG(tempo), 1) AS avg_tempo
FROM tracks
GROUP BY target
ORDER BY target DESC;

-- Q5. Distribution of tracks by Musical Key and Mode (Major = 1, Minor = 0)
SELECT key,
       CASE WHEN mode = 1 THEN 'Major' ELSE 'Minor' END AS modality,
       COUNT(*) AS track_count,
       ROUND(AVG(valence), 3) AS avg_valence
FROM tracks
GROUP BY key, mode
ORDER BY track_count DESC;  

-- Q6. High-energy workout tracks (energy > 0.85, danceability > 0.75, tempo > 120)
SELECT song_title, 
       artist, 
       energy, 
       danceability, 
       ROUND(tempo, 1) AS tempo_bpm
FROM tracks
WHERE energy > 0.85 
  AND danceability > 0.75 
  AND tempo > 120
ORDER BY energy DESC, danceability DESC;
-- Q7. Categorizing tracks by mood/vibe using Valence and Energy
SELECT CASE 
           WHEN valence >= 0.5 AND energy >= 0.5 THEN 'Happy / Energetic'
           WHEN valence >= 0.5 AND energy < 0.5  THEN 'Chill / Peaceful'
           WHEN valence < 0.5  AND energy >= 0.5 THEN 'Intense / Turbulent'
           ELSE 'Sad / Melancholic'
       END AS mood_category,
       COUNT(*) AS track_count,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct_of_total
FROM tracks
GROUP BY mood_category
ORDER BY track_count DESC;


-- Q8. Custom Liked Playlist Generator (Top 15 upbeat liked tracks)
SELECT song_title, 
       artist, 
       ROUND(duration_ms / 60000.0, 2) AS duration_min,
       danceability, 
       energy, 
       valence
FROM tracks
WHERE target = 1
  AND danceability >= 0.70
  AND valence >= 0.60
ORDER BY (danceability + energy + valence) DESC
LIMIT 15;