-- Insert sample users
INSERT INTO User (username, email, join_date, skill_level)
VALUES 
    ('PlayerOne', 'player1@example.com', '2025-01-01', 'Advanced'),
    ('ProGamer', 'progamer@example.com', '2025-01-10', 'Pro'),
    ('NoobMaster', 'noobmaster@example.com', '2025-01-15', 'Beginner');

-- Insert sample teams
INSERT INTO Team (team_name, created_date, captain_id)
VALUES 
    ('Warriors', '2025-01-20', 1),
    ('Legends', '2025-01-22', 2);

-- Insert sample games
INSERT INTO Game (game_name, genre, release_year)
VALUES 
    ('Battle Royale X', 'Shooter', 2020),
    ('Fantasy Quest', 'RPG', 2018);

-- Insert sample tournaments
INSERT INTO Tournament (game_id, tournament_name, start_date, end_date, prize_pool)
VALUES 
    (1, 'Battle Royale Championship', '2025-02-01', '2025-02-10', 5000.00),
    (2, 'Fantasy Quest Finals', '2025-03-01', '2025-03-05', 3000.00);

-- Insert team memberships
INSERT INTO TeamMembership (team_id, user_id, joined_date)
VALUES 
    (1, 1, '2025-01-21'),
    (1, 2, '2025-01-22'),
    (2, 3, '2025-01-23');

-- Insert tournament results
INSERT INTO TournamentResults (tournament_id, team_id, placement, prize_money)
VALUES 
    (1, 1, 1, 5000.00),
    (2, 2, 1, 3000.00);

-- Insert sample matches
INSERT INTO Match (tournament_id, team1_id, team2_id, match_date, winner_team_id)
VALUES 
    (1, 1, 2, '2025-02-03 15:00:00', 1),
    (2, 2, 1, '2025-03-02 16:00:00', 2);

-- Insert messages
INSERT INTO Message (team_id, user_id, message_content)
VALUES 
    (1, 1, 'Let’s win this tournament!'),
    (2, 3, 'Ready for the finals?');
