-- Heavy Hitter

Select 
    teams.name AS teamName, 
    batting.yearID AS year, 
    ROUND(AVG(people.weight),2) AS weight
FROM teams
JOIN batting 
    ON teams.teamID = batting.teamID
JOIN people 
    ON people.playerID = batting.playerID
GROUP BY 
    teams.name, 
    batting.yearID
ORDER BY 
    AVG(people.weight) 
    DESC
LIMIT 5;

-- Short Hitter

Select 
    teams.name AS teamName, 
    batting.yearID AS year, 
    ROUND(AVG(people.height),2) AS height
FROM teams
JOIN batting 
    ON teams.teamID = batting.teamID
JOIN people 
    ON people.playerID = batting.playerID
GROUP BY 
    teams.name, 
    batting.yearID
ORDER BY 
    AVG(people.height) 
    ASC
LIMIT 5;

-- Bang for your buck 2010

SELECT 
    teams.name AS team_name,
    teams.W AS wins, 
    SUM(salaries.salary) AS total_salary, 
    ROUND((SUM(salaries.salary)::numeric / teams.W),2) AS salary_per_win
FROM teams
JOIN salaries 
    ON teams.teamID = salaries.teamID 
    AND teams.yearID = salaries.yearID
WHERE 
    salaries.yearID = 2010
GROUP BY 
    team_name, 
    wins
ORDER BY 
    salary_per_win 
    ASC
LIMIT 5;

-- pricy starter

SELECT
    people.nameFirst    AS first_name,
    people.nameLast     AS last_name,
    pitching.yearID     AS year,
    pitching.GS         AS games_started,
    salaries.salary     AS salary,
    ROUND((salaries.salary::numeric / pitching.GS),2) AS salary_per_start
FROM pitching
JOIN salaries 
    ON pitching.playerID = salaries.playerID 
    AND pitching.yearID = salaries.yearID 
    AND pitching.teamID = salaries.teamID
JOIN people ON
    pitching.playerID = people.playerID
WHERE 
    pitching.GS >= 10
GROUP BY 
    pitching.playerID, 
    pitching.yearID, 
    pitching.teamID, 
    people.nameFirst, 
    people.nameLast, 
    pitching.GS, 
    salaries.salary
ORDER BY 
    salary_per_start 
    DESC
LIMIT 5;
