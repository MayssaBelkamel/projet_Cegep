USE BD4D5_Pays_Monde
GO
--creation de la vue pour aller chercher le nombre de climat et langue pour chaque pays


CREATE VIEW Geographie.vw_PaysInfo
AS
WITH 
nbrLangue AS (
SELECT PaysID,
COUNT(LangueID) AS nbrLangue
FROM Caracteristique.LanguePays
GROUP BY PaysID
),

nbrClimat AS (
SELECT PaysID,
COUNT(ClimatID) AS nbrClimat
FROM Caracteristique.ClimatPays
GROUP BY PaysID
)

SELECT
p.PaysID as PaysId,
p.nom AS Pays,
c.nom AS Continent,
v.nom AS Capitale,
nbr.nbrLangue,
climat.nbrClimat

FROM Geographie.Pays p

INNER JOIN nbrClimat climat
ON climat.PaysID = p.PaysID

INNER JOIN nbrLangue nbr
ON nbr.PaysID = p.PaysID

INNER JOIN Geographie.Continent c
ON p.ContinentID = c.ContinentID

INNER JOIN Geographie.Ville v
ON v.PaysID = p.PaysID

WHERE v.EstCapital = 1;
GO