-- Drop existing tables to avoid conflicts
DROP TABLE IF EXISTS Message;
DROP TABLE IF EXISTS Match;
DROP TABLE IF EXISTS TournamentResults;
DROP TABLE IF EXISTS TeamMembership;
DROP TABLE IF EXISTS Tournament;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Team;
DROP TABLE IF EXISTS User;

-- Create User table
CREATE TABLE User (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    email TEXT UNIQUE NOT NULL,
    join_date DATE NOT NULL,
    skill_level TEXT NOT NULL
);

-- Create Team table
CREATE TABLE Team (
    team_id INTEGER PRIMARY KEY AUTOINCREMENT,
    team_name TEXT UNIQUE NOT NULL,
    created_date DATE NOT NULL,
    captain_id INTEGER NOT NULL,
    FOREIGN KEY (captain_id) REFERENCES User(user_id)
);

-- Create Game table
CREATE TABLE Game (
    game_id INTEGER PRIMARY KEY AUTOINCREMENT,
    game_name TEXT UNIQUE NOT NULL,
    genre TEXT NOT NULL,
    release_year INTEGER NOT NULL
);

-- Create Tournament table
CREATE TABLE Tournament (
    tournament_id INTEGER PRIMARY KEY AUTOINCREMENT,
    game_id INTEGER NOT NULL,
    tournament_name TEXT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    prize_pool DECIMAL(10, 2),
    FOREIGN KEY (game_id) REFERENCES Game(game_id)
);

-- Create TeamMembership table
CREATE TABLE TeamMembership (
    team_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    joined_date DATE NOT NULL,
    PRIMARY KEY (team_id, user_id),
    FOREIGN KEY (team_id) REFERENCES Team(team_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Create TournamentResults table
CREATE TABLE TournamentResults (
    tournament_id INTEGER NOT NULL,
    team_id INTEGER NOT NULL,
    placement INTEGER NOT NULL,
    prize_money DECIMAL(10, 2),
    PRIMARY KEY (tournament_id, team_id),
    FOREIGN KEY (tournament_id) REFERENCES Tournament(tournament_id),
    FOREIGN KEY (team_id) REFERENCES Team(team_id)
);

-- Create Match table
CREATE TABLE Match (
    match_id INTEGER PRIMARY KEY AUTOINCREMENT,
    tournament_id INTEGER NOT NULL,
    team1_id INTEGER NOT NULL,
    team2_id INTEGER NOT NULL,
    match_date DATETIME NOT NULL,
    winner_team_id INTEGER,
    FOREIGN KEY (tournament_id) REFERENCES Tournament(tournament_id),
    FOREIGN KEY (team1_id) REFERENCES Team(team_id),
    FOREIGN KEY (team2_id) REFERENCES Team(team_id),
    FOREIGN KEY (winner_team_id) REFERENCES Team(team_id)
);

-- Create Message table
CREATE TABLE Message (
    message_id INTEGER PRIMARY KEY AUTOINCREMENT,
    team_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    message_content TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (team_id) REFERENCES Team(team_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);
