-- Ensure the schemas exist
CREATE SCHEMA IF NOT EXISTS hog;
CREATE SCHEMA IF NOT EXISTS li;

-- Drop existing tables with CASCADE
DROP TABLE IF EXISTS hog.player CASCADE;
DROP TABLE IF EXISTS li.war CASCADE;
DROP TABLE IF EXISTS li.player_war_performance CASCADE;



-- Creation of hog.player table
CREATE TABLE hog.player (
    player_id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    country VARCHAR NOT NULL,
    time_zone VARCHAR NOT NULL,
    queen_level INT NOT NULL,
    hog_rank INT NOT NULL,
    main_troop_type VARCHAR NOT NULL,
    highest_troop_tier INT NOT NULL,
    kill_count INT NOT NULL,
    is_p2w BOOLEAN NOT NULL,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now()
);

-- Indices for hog.player
CREATE INDEX idx_player_country ON hog.player(country);
CREATE INDEX idx_player_hog_rank ON hog.player(hog_rank);

-- Creation of li.war table
CREATE TABLE li.war (
    id SERIAL PRIMARY KEY,
    war_day DATE UNIQUE NOT NULL,
    alliances VARCHAR NOT NULL,
    zone VARCHAR NOT NULL,
    duration INT NOT NULL,
    winner VARCHAR NOT NULL
);

-- Indices for li.war
CREATE INDEX idx_war_zone ON li.war(zone);
CREATE INDEX idx_war_winner ON li.war(winner);

-- Creation of li.player_war_performance table
CREATE TABLE li.player_war_performance (
    player_war_id VARCHAR(255) PRIMARY KEY,
    player_id INT NOT NULL REFERENCES hog.player(player_id),
    war_day DATE NOT NULL REFERENCES li.war(war_day),
    kill_count INT NOT NULL
);

-- Indices for li.player_war_performance
CREATE INDEX idx_player_war_performance_player_id ON li.player_war_performance(player_id);
CREATE INDEX idx_player_war_performance_war_day ON li.player_war_performance(war_day);

-- Add any additional indices as needed based on query patterns
