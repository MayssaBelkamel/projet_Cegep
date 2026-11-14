use BD4D5_Pays_Monde

-- Index pour accélérer les filtres par continent (procédure stockée)
CREATE NONCLUSTERED INDEX IX_Pays_ContinentId
ON Geographie.Pays(ContinentId);

-- Index pour accélérer les recherches des langues d’un pays
CREATE NONCLUSTERED INDEX IX_LanguePays_PaysId
ON Caracteristique.LanguePays(PaysId);
