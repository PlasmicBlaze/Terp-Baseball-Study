USE BUDT703_Project_0506_03

--What years exhibit the highest winning rate, calculated as the total number of games won divided by the total number of games played within that specific year? Show by descending order.


SELECT
    gp.year AS "Year",
    --SUM(CASE WHEN p.gameTeamScore > p.gameOpponentScore THEN 1 ELSE 0 END) AS "Total Wins",
    --COUNT(*) AS "Total Games",
    FORMAT(SUM(CASE WHEN p.gameTeamScore > p.gameOpponentScore THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 'N2') + '%' AS "Winning Rate"
FROM
    [Game.Play] p
JOIN
    [Game.Year] gp ON p.year = gp.year
GROUP BY
    gp.year
ORDER BY
    "Winning Rate" DESC;

-- Which teams have played the most games against the Maryland team? Show by descending order.

SELECT
    opnt.opntId AS "Opponent ID",
    opnt.opntName AS "Opponent Name",
    COUNT(*) AS "Total Games Played"
FROM
    [Game.Play] p
JOIN
    [Game.Opponent] opnt ON p.opntId = opnt.opntId
WHERE
    p.gameTeamScore IS NOT NULL
    AND p.gameOpponentScore IS NOT NULL
    AND p.opntId <> (SELECT teamId FROM [Game.Team] WHERE teamName = 'Maryland')
GROUP BY
    opnt.opntId, opnt.opntName
HAVING
    COUNT(*) > 10
ORDER BY
    "Total Games Played" DESC;



-- Which non-home stadium has the best record in terms of winning rate for the Maryland team? How many total games have been played in each of those stadiums?

WITH StadiumRecords AS (
    SELECT
        p.locnId,
        l.locnName,
        COUNT(*) AS total_games,
        SUM(CASE WHEN p.gameTeamScore > p.gameOpponentScore THEN 1 ELSE 0 END) AS total_wins,
        COUNT(*) - SUM(CASE WHEN p.gameTeamScore > p.gameOpponentScore THEN 1 ELSE 0 END) AS total_losses,
        ROUND(SUM(CASE WHEN p.gameTeamScore > p.gameOpponentScore THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS winning_rate
    FROM
        [Game.Play] p
    JOIN
        [Game.Location] l ON p.locnId = l.locnId
    GROUP BY
        p.locnId, l.locnName
)

-- ...

SELECT
    locnId AS "Location ID",
    locnName AS "Location Name",
    total_wins AS "Total Wins",
    "Win Rate",
    rnk AS "Rank"
FROM (
    SELECT
        locnId,
        locnName,
        total_games,
        total_wins,
        total_losses,
        ROUND(winning_rate, 2) AS "Win Rate",
        ROW_NUMBER() OVER (ORDER BY winning_rate DESC) AS rnk
    FROM
        StadiumRecords
) ranked
WHERE
	rnk <=20
ORDER BY
    "Win Rate" DESC;



--How do home, away, and neutral matches differ in each conference regarding the total number of games played, total number of wins, and the winning rate (calculated as the ratio of wins to total games)?

SELECT
    c.confName AS "Conference Name",
    p.gameType AS "Game Type",
    COUNT(*) AS "Total Games",
    FORMAT(SUM(CASE WHEN p.gameTeamScore > p.gameOpponentScore THEN 1 ELSE 0 END) * 100 / COUNT(*), 'N2') + '%' AS "Winning Rate"
FROM
    [Game.Conference] c
JOIN
    [Game.Perform] f ON f.confId = c.confId
JOIN
    [Game.Play] p ON p.opntId = f.opntId
GROUP BY
    c.confName,
    p.gameType


