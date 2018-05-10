## Creates the database schema

## Account Table
DROP TABLE IF EXISTS account; # Drops the table if it already exists
CREATE TABLE account (    
    id INT NOT NULL AUTO_INCREMENT,
    plan_level VARCHAR(25),
    fee DECIMAL(6,2),
    date_joined DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

## User Table
DROP TABLE IF EXISTS user;
CREATE TABLE user (    
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(255) UNIQUE,
    account_id INT,
    data_created DATETIME DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN,
    PRIMARY KEY (id),
    FOREIGN KEY (account_id) REFERENCES account (id)
);

## Financial Table * NOTE, will likely use a 3rd party payment system instead
DROP TABLE IF EXISTS financial;
CREATE TABLE financial (
	id INT NOT NULL AUTO_INCREMENT,
    account_id INT,
    card_type VARCHAR(10),
    last_digits VARCHAR(4),
    expiration_month INT,
    expiration_year INT,
    active BOOLEAN,
    PRIMARY KEY (id),
    FOREIGN KEY (account_id) REFERENCES account (id)
);


## Login Table
DROP TABLE IF EXISTS login;
CREATE TABLE login (
	id INT NOT NULL AUTO_INCREMENT,
    user_id INT,
    password_salt BINARY(64),
    password_hash BINARY(64),
    last_login DATETIME,
    total_logins INT,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES user (id)
);


## Sports League Table
DROP TABLE IF EXISTS league;
CREATE TABLE league (
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100),
    country_code VARCHAR(3),
    PRIMARY KEY (id)
);

## Sports Team Table
DROP TABLE IF EXISTS team;
CREATE TABLE team (
	id INT NOT NULL AUTO_INCREMENT,
    league_id INT,
    name VARCHAR(100),
    division VARCHAR(25),
    conference VARCHAR(25),
    home_city VARCHAR(100),
    home_state VARCHAR(100),
    stadium_name VARCHAR(255),
    PRIMARY KEY (id),
    FOREIGN KEY (league_id) REFERENCES league (id)
);

## NFL Game Table
DROP TABLE IF EXISTS nfl_game;
CREATE TABLE nfl_game (
	id INT NOT NULL AUTO_INCREMENT,
    league_id INT,
    home_id INT,
    away_id INT,
    winner INT,
    home_score INT,
    home_offensive_yards INT,
    home_defensive_yards INT,
    home_turnovers INT,
	away_score INT,
	away_offensive_yards INT,
    away_defensive_yards INT,
    away_turnovers INT,
    event_date DATETIME,
    event_season VARCHAR(10),
    PRIMARY KEY (id),
    FOREIGN KEY (league_id) REFERENCES league (id),
    FOREIGN KEY (home_id) REFERENCES team (id),
    FOREIGN KEY (away_id) REFERENCES team (id)
);


# NBA Game Table
DROP TABLE IF EXISTS nba_game;
CREATE TABLE nba_game (
	id INT NOT NULL AUTO_INCREMENT,
    league_id INT,
    home_id INT,
    away_id INT,
    winner INT,
    home_score INT,
    home_assists INT,
    home_rebounds INT,
    home_blocks INT,
    home_turnovers INT,
	away_score INT,
    away_assists INT,
    away_rebounds INT,
    away_blocks INT,
    away_turnovers INT,
    event_date DATETIME,
    event_season VARCHAR(10),
    PRIMARY KEY (id),
    FOREIGN KEY (league_id) REFERENCES league (id),
    FOREIGN KEY (home_id) REFERENCES team (id),
    FOREIGN KEY (away_id) REFERENCES team (id)
);
    
