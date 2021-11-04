DROP DATABASE IF EXISTS football;
CREATE DATABASE football;

\c football

DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS team;
DROP TABLE IF EXISTS position;

CREATE TABLE position
(
    name varchar(50) NOT NULL,
    PRIMARY KEY (name)
);

CREATE TABLE team
(
    id      SERIAL PRIMARY KEY,
    name    varchar(150) NOT NULL,
    stadium varchar(100) NOT NULL,
    coach   varchar(200) NOT NULL
);

CREATE TABLE player
(
    id            SERIAL PRIMARY KEY,
    position      varchar(50)  NOT NULL,
    team_id       INT,
    first_name    varchar(255) NOT NULL,
    last_name     varchar(255) NOT NULL,
    country       varchar(255) NOT NULL,
    date_of_birth DATE,
    CONSTRAINT fk_club
        FOREIGN KEY (team_id)
            REFERENCES team (id),
    CONSTRAINT fk_position
        FOREIGN KEY (position)
            REFERENCES position (name)
);

CREATE TABLE matches
(
    id                       SERIAL PRIMARY KEY,
    league_id                INT,
    hosts_team_id            INT NOT NULL,
    guests_team_id           INT NOT NULL,
    goals_of_the_hosts_team  INT       DEFAULT 0,
    goals_of_the_guests_team INT       DEFAULT 0,
    date                     TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_hosts_team
        FOREIGN KEY (hosts_team_id)
            REFERENCES team (id),
    CONSTRAINT fk_guests_team
        FOREIGN KEY (guests_team_id)
            REFERENCES team (id),
    CONSTRAINT fk_league
        FOREIGN KEY (league_id)
            REFERENCES league (id)
);

CREATE TABLE league
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    description TEXT         NOT NULL
);

CREATE TABLE team_league
(
    league_id    INT NOT NULL,
    team_id      INT NOT NULL,
    points       INT DEFAULT 0,
    goals_lost   INT DEFAULT 0,
    goals_scored INT DEFAULT 0,
    CONSTRAINT fk_league
        FOREIGN KEY (league_id)
            REFERENCES league (id),
    CONSTRAINT fk_team
        FOREIGN KEY (team_id)
            REFERENCES team (id)

);


INSERT INTO position
VALUES ('Goalkeeper'),
       ('Defender'),
       ('Midfielder'),
       ('Forward');

INSERT INTO team (name, stadium, coach)
VALUES ('AS Roma', 'Stadium Olimpico', 'Jose Mourinho'),
       ('FC Barcelona', 'Camp Nou', 'Ronald Koeman'),
       ('Real Madrid', 'Santiago Bernabeu', 'Carlo Ancelotti'),
       ('Chelsea London', 'Stamford Bridge', 'Thomas Tuchel');

INSERT INTO player (position, team_id, first_name, last_name, country, date_of_birth)
VALUES ('Goalkeeper', 2, 'Andre', 'ter Stagen', 'germany', '1992-04-30'),
       ('Midfielder', 2, 'Sergio', 'Busquets', 'spain', '1988-07-16'),
       ('Goalkeeper', 1, 'Rui', 'Patricio', 'portugal', '1988-02-15'),
       ('Defender', 1, 'Leonardo', 'Spinazzola', 'italy', '1993-03-25'),
       ('Forward', 3, 'Karim', 'Benzena', 'france', '1987-12-19'),
       ('Midfielder', 3, 'Luka', 'Modric', 'coratia', '1985-09-09'),
       ('Goalkeeper', 4, 'Kepa', 'Arrizabalaga', 'spain', '1994-10-03'),
       ('Midfielder', 4, 'Mason', 'Mount', 'england', '1999-01-10');


INSERT INTO league(name, description)
VALUES ('Friendly Cup', 'European friendly club for  italian, spanish and english clubs');

INSERT INTO team_league(league_id, team_id)
VALUES (1, 1),
       (1, 2),
       (1, 3),
       (1, 4);

INSERT INTO matches (hosts_team_id, guests_team_id, goals_of_the_hosts_team, goals_of_the_guests_team, league_id)
VALUES (1, 2, 3, 0, 1),
       (3, 4, 2, 2, 1),
       (2, 3, 2, 1, 1),
       (4, 1, 1, 1, 1),
       (2, 3, 0, 0, NULL);



SELECT *
FROM position;
SELECT *
FROM team;
SELECT *
FROM player;
SELECT *
FROM matches;
SELECT *
FROM league;
SELECT *
FROM team_league;