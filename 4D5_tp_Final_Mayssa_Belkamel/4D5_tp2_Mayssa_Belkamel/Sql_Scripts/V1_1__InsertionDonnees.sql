USE BD4D5_Pays_Monde
GO

-- D'abord, insérer les continents
INSERT INTO Geographie.Continent (Nom, Superficie) VALUES
('Afrique', 30370000),
('Amérique du Nord', 24709000),
('Amérique du Sud', 17840000),
('Asie', 44579000),
('Europe', 10180000),
('Océanie', 8525989);
GO

-- Insérer les climats
INSERT INTO Caracteristique.Climat (Type, TempMoyenne) VALUES
('Équatorial', 26),
('Tropical', 25),
('Aride', 20),
('Méditerranéen', 18),
('Océanique', 12),
('Continental', 8),
('Polaire', -5),
('Montagne', 10);
GO

-- Insérer 40 pays
INSERT INTO Geographie.Pays (ContinentID, Nom, Superficie, DateIndependance) VALUES
-- Afrique (ContinentID = 1)
(1, 'Algérie', 2381741, '1962-07-05'),
(1, 'Égypte', 1001449, '1922-02-28'),
(1, 'Maroc', 446550, '1956-03-02'),
(1, 'Tunisie', 163610, '1956-03-20'),
(1, 'Nigeria', 923768, '1960-10-01'),
(1, 'Afrique du Sud', 1219090, '1961-05-31'),
(1, 'Kenya', 580367, '1963-12-12'),
(1, 'Éthiopie', 1104300, NULL),
(1, 'Ghana', 238533, '1957-03-06'),
(1, 'Sénégal', 196722, '1960-04-04'),

-- Amérique du Nord (ContinentID = 2)
(2, 'États-Unis', 9833517, '1776-07-04'),
(2, 'Canada', 9984670, '1867-07-01'),
(2, 'Mexique', 1964375, '1810-09-16'),
(2, 'Cuba', 109884, '1902-05-20'),
(2, 'Costa Rica', 51100, '1821-09-15'),

-- Amérique du Sud (ContinentID = 3)
(3, 'Brésil', 8515767, '1822-09-07'),
(3, 'Argentine', 2780400, '1816-07-09'),
(3, 'Colombie', 1141748, '1810-07-20'),
(3, 'Pérou', 1285216, '1821-07-28'),
(3, 'Chili', 756102, '1818-02-12'),
(3, 'Venezuela', 916445, '1811-07-05'),

-- Asie (ContinentID = 4)
(4, 'Chine', 9596961, '1949-10-01'),
(4, 'Inde', 3287263, '1947-08-15'),
(4, 'Japon', 377975, NULL),
(4, 'Corée du Sud', 100210, '1948-08-15'),
(4, 'Thaïlande', 513120, NULL),
(4, 'Vietnam', 331212, '1945-09-02'),
(4, 'Indonésie', 1904569, '1945-08-17'),
(4, 'Pakistan', 881913, '1947-08-14'),
(4, 'Bangladesh', 147570, '1971-03-26'),
(4, 'Arabie Saoudite', 2149690, '1932-09-23'),

-- Europe (ContinentID = 5)
(5, 'France', 643801, NULL),
(5, 'Allemagne', 357022, NULL),
(5, 'Royaume-Uni', 242495, NULL),
(5, 'Italie', 301340, NULL),
(5, 'Espagne', 505990, NULL),
(5, 'Pologne', 312696, '1918-11-11'),
(5, 'Suède', 450295, NULL),
(5, 'Norvège', 323802, '1905-06-07'),
(5, 'Grèce', 131957, '1821-03-25'),

-- Océanie (ContinentID = 6)
(6, 'Australie', 7692024, '1901-01-01');
GO

-- Insérer les langues principales
INSERT INTO Caracteristique.Langue (Nom) VALUES
('Arabe'),
('Français'),
('Anglais'),
('Espagnol'),
('Portugais'),
('Chinois Mandarin'),
('Hindi'),
('Japonais'),
('Coréen'),
('Thaï'),
('Vietnamien'),
('Indonésien'),
('Ourdou'),
('Bengali'),
('Allemand'),
('Italien'),
('Polonais'),
('Suédois'),
('Norvégien'),
('Grec'),
('Yoruba'),
('Swahili'),
('Amharique'),
('Wolof'),
('Néerlandais'),
('Afrikaans');
GO

-- Insérer les villes principales (2-3 villes par pays dont la capitale)
INSERT INTO Geographie.Ville (PaysID, Nom, EstCapital) VALUES
-- Algérie (PaysID = 1)
(1, 'Alger', 1),
(1, 'Oran', 0),
(1, 'Constantine', 0),

-- Égypte (PaysID = 2)
(2, 'Le Caire', 1),
(2, 'Alexandrie', 0),
(2, 'Gizeh', 0),

-- Maroc (PaysID = 3)
(3, 'Rabat', 1),
(3, 'Casablanca', 0),
(3, 'Marrakech', 0),

-- Tunisie (PaysID = 4)
(4, 'Tunis', 1),
(4, 'Sfax', 0),

-- Nigeria (PaysID = 5)
(5, 'Abuja', 1),
(5, 'Lagos', 0),
(5, 'Ibadan', 0),

-- Afrique du Sud (PaysID = 6)
(6, 'Pretoria', 1),
(6, 'Le Cap', 0),
(6, 'Johannesburg', 0),

-- Kenya (PaysID = 7)
(7, 'Nairobi', 1),
(7, 'Mombasa', 0),

-- Éthiopie (PaysID = 8)
(8, 'Addis-Abeba', 1),

-- Ghana (PaysID = 9)
(9, 'Accra', 1),
(9, 'Kumasi', 0),

-- Sénégal (PaysID = 10)
(10, 'Dakar', 1),

-- États-Unis (PaysID = 11)
(11, 'Washington', 1),
(11, 'New York', 0),
(11, 'Los Angeles', 0),

-- Canada (PaysID = 12)
(12, 'Ottawa', 1),
(12, 'Toronto', 0),
(12, 'Montréal', 0),

-- Mexique (PaysID = 13)
(13, 'Mexico', 1),
(13, 'Guadalajara', 0),
(13, 'Monterrey', 0),

-- Cuba (PaysID = 14)
(14, 'La Havane', 1),

-- Costa Rica (PaysID = 15)
(15, 'San José', 1),

-- Brésil (PaysID = 16)
(16, 'Brasilia', 1),
(16, 'São Paulo', 0),
(16, 'Rio de Janeiro', 0),

-- Argentine (PaysID = 17)
(17, 'Buenos Aires', 1),
(17, 'Córdoba', 0),

-- Colombie (PaysID = 18)
(18, 'Bogotá', 1),
(18, 'Medellín', 0),

-- Pérou (PaysID = 19)
(19, 'Lima', 1),
(19, 'Cusco', 0),

-- Chili (PaysID = 20)
(20, 'Santiago', 1),
(20, 'Valparaíso', 0),

-- Venezuela (PaysID = 21)
(21, 'Caracas', 1),
(21, 'Maracaibo', 0),

-- Chine (PaysID = 22)
(22, 'Pékin', 1),
(22, 'Shanghai', 0),
(22, 'Canton', 0),

-- Inde (PaysID = 23)
(23, 'New Delhi', 1),
(23, 'Mumbai', 0),
(23, 'Bangalore', 0),

-- Japon (PaysID = 24)
(24, 'Tokyo', 1),
(24, 'Osaka', 0),
(24, 'Kyoto', 0),

-- Corée du Sud (PaysID = 25)
(25, 'Séoul', 1),
(25, 'Busan', 0),

-- Thaïlande (PaysID = 26)
(26, 'Bangkok', 1),
(26, 'Chiang Mai', 0),

-- Vietnam (PaysID = 27)
(27, 'Hanoï', 1),
(27, 'Hô Chi Minh-Ville', 0),

-- Indonésie (PaysID = 28)
(28, 'Jakarta', 1),
(28, 'Surabaya', 0),

-- Pakistan (PaysID = 29)
(29, 'Islamabad', 1),
(29, 'Karachi', 0),
(29, 'Lahore', 0),

-- Bangladesh (PaysID = 30)
(30, 'Dacca', 1),
(30, 'Chittagong', 0),

-- Arabie Saoudite (PaysID = 31)
(31, 'Riyad', 1),
(31, 'Djeddah', 0),
(31, 'La Mecque', 0),

-- France (PaysID = 32)
(32, 'Paris', 1),
(32, 'Marseille', 0),
(32, 'Lyon', 0),

-- Allemagne (PaysID = 33)
(33, 'Berlin', 1),
(33, 'Munich', 0),
(33, 'Hambourg', 0),

-- Royaume-Uni (PaysID = 34)
(34, 'Londres', 1),
(34, 'Manchester', 0),
(34, 'Birmingham', 0),

-- Italie (PaysID = 35)
(35, 'Rome', 1),
(35, 'Milan', 0),
(35, 'Naples', 0),

-- Espagne (PaysID = 36)
(36, 'Madrid', 1),
(36, 'Barcelone', 0),
(36, 'Séville', 0),

-- Pologne (PaysID = 37)
(37, 'Varsovie', 1),
(37, 'Cracovie', 0),

-- Suède (PaysID = 38)
(38, 'Stockholm', 1),
(38, 'Göteborg', 0),

-- Norvège (PaysID = 39)
(39, 'Oslo', 1),
(39, 'Bergen', 0),

-- Grèce (PaysID = 40)
(40, 'Athènes', 1),
(40, 'Thessalonique', 0),

-- Australie (PaysID = 41)
(41, 'Canberra', 1),
(41, 'Sydney', 0),
(41, 'Melbourne', 0);
GO

-- Associer les langues aux pays avec le pourcentage de locuteurs
INSERT INTO Caracteristique.LanguePays (LangueID, PaysID, PourcentageLocuteur) VALUES
-- Algérie
(1, 1, 80),  -- Arabe
(2, 1, 20),  -- Français

-- Égypte
(1, 2, 95),  -- Arabe

-- Maroc
(1, 3, 65),  -- Arabe
(2, 3, 35),  -- Français

-- Tunisie
(1, 4, 70),  -- Arabe
(2, 4, 30),  -- Français

-- Nigeria
(3, 5, 60),  -- Anglais
(21, 5, 40), -- Yoruba

-- Afrique du Sud
(3, 6, 60),  -- Anglais
(26, 6, 15), -- Afrikaans
(25, 6, 15), -- Néerlandais

-- Kenya
(3, 7, 70),  -- Anglais
(22, 7, 30), -- Swahili

-- Éthiopie
(23, 8, 90), -- Amharique
(3, 8, 10),  -- Anglais

-- Ghana
(3, 9, 100), -- Anglais

-- Sénégal
(2, 10, 40), -- Français
(24, 10, 60), -- Wolof

-- États-Unis
(3, 11, 80), -- Anglais
(4, 11, 20), -- Espagnol

-- Canada
(3, 12, 60), -- Anglais
(2, 12, 40), -- Français

-- Mexique
(4, 13, 100), -- Espagnol

-- Cuba
(4, 14, 100), -- Espagnol

-- Costa Rica
(4, 15, 100), -- Espagnol

-- Brésil
(5, 16, 100), -- Portugais

-- Argentine
(4, 17, 100), -- Espagnol

-- Colombie
(4, 18, 100), -- Espagnol

-- Pérou
(4, 19, 85), -- Espagnol

-- Chili
(4, 20, 100), -- Espagnol

-- Venezuela
(4, 21, 100), -- Espagnol

-- Chine
(6, 22, 95), -- Chinois Mandarin

-- Inde
(7, 23, 45), -- Hindi
(3, 23, 15), -- Anglais

-- Japon
(8, 24, 100), -- Japonais

-- Corée du Sud
(9, 25, 100), -- Coréen

-- Thaïlande
(10, 26, 100), -- Thaï

-- Vietnam
(11, 27, 100), -- Vietnamien

-- Indonésie
(12, 28, 90), -- Indonésien

-- Pakistan
(13, 29, 75), -- Ourdou
(3, 29, 25),  -- Anglais

-- Bangladesh
(14, 30, 98), -- Bengali

-- Arabie Saoudite
(1, 31, 100), -- Arabe

-- France
(2, 32, 100), -- Français

-- Allemagne
(15, 33, 95), -- Allemand

-- Royaume-Uni
(3, 34, 98), -- Anglais

-- Italie
(16, 35, 95), -- Italien

-- Espagne
(4, 36, 90), -- Espagnol

-- Pologne
(17, 37, 98), -- Polonais

-- Suède
(18, 38, 90), -- Suédois

-- Norvège
(19, 39, 95), -- Norvégien

-- Grèce
(20, 40, 98), -- Grec

-- Australie
(3, 41, 95); -- Anglais
GO

INSERT INTO Caracteristique.ClimatPays (ClimatID, PaysID)
VALUES
-- ===== Afrique =====
(3, 1), (4, 1),                 -- Algérie : Aride + Méditerranéen
(3, 2), (2, 2),                 -- Égypte : Aride + Tropical
(4, 3), (3, 3),                 -- Maroc : Méditerranéen + Aride
(4, 4), (3, 4),                 -- Tunisie : Méditerranéen + Aride
(2, 5), (1, 5),                 -- Nigeria : Tropical + Équatorial (sud)
(4, 6), (3, 6), (5, 6),         -- Afrique du Sud : Méditerranéen + Aride + Océanique
(2, 7), (8, 7),                 -- Kenya : Tropical + Montagne (hauts plateaux)
(2, 8), (8, 8),                 -- Éthiopie : Tropical + Montagne
(2, 9), (1, 9),                 -- Ghana : Tropical + Équatorial
(2, 10), (3, 10),               -- Sénégal : Tropical + Aride (nord)

-- ===== Amérique du Nord =====
(6, 11), (3, 11), (2, 11),      -- États-Unis : Continental + Aride + Tropical (ex: Floride/Hawaï)
(6, 12), (7, 12), (5, 12),      -- Canada : Continental + Polaire + Océanique (côte pacifique)
(2, 13), (3, 13),               -- Mexique : Tropical + Aride
(2, 14),                        -- Cuba : Tropical
(2, 15), (1, 15),               -- Costa Rica : Tropical + Équatorial (zones très humides)

-- ===== Amérique du Sud =====
(2, 16), (1, 16), (3, 16),      -- Brésil : Tropical + Équatorial (Amazonie) + Aride (Nordeste)
(4, 17), (3, 17), (8, 17),      -- Argentine : Méditerranéen + Aride + Montagne (Andes)
(1, 18), (2, 18), (8, 18),      -- Colombie : Équatorial + Tropical + Montagne (Andes)
(8, 19), (3, 19),               -- Pérou : Montagne + Aride (côte)
(4, 20), (3, 20), (8, 20),      -- Chili : Méditerranéen + Aride (Atacama) + Montagne
(2, 21), (1, 21),               -- Venezuela : Tropical + Équatorial

-- ===== Asie =====
(6, 22), (3, 22), (8, 22),      -- Chine : Continental + Aride (ouest) + Montagne (Tibet)
(2, 23), (8, 23), (3, 23),      -- Inde : Tropical + Montagne (Himalaya) + Aride (Rajasthan)
(5, 24), (6, 24),               -- Japon : Océanique + Continental (nord)
(5, 25), (6, 25),               -- Corée du Sud : Océanique + Continental
(2, 26),                        -- Thaïlande : Tropical
(2, 27),                        -- Vietnam : Tropical
(2, 28), (1, 28),               -- Indonésie : Tropical + Équatorial
(3, 29), (8, 29),               -- Pakistan : Aride + Montagne
(2, 30),                        -- Bangladesh : Tropical
(3, 31),                        -- Arabie Saoudite : Aride

-- ===== Europe =====
(5, 32), (4, 32), (6, 32),      -- France : Océanique + Méditerranéen + Continental
(6, 33), (5, 33),               -- Allemagne : Continental + Océanique
(5, 34),                        -- Royaume-Uni : Océanique
(4, 35), (8, 35),               -- Italie : Méditerranéen + Montagne (Alpes)
(4, 36), (3, 36), (8, 36),      -- Espagne : Méditerranéen + Aride + Montagne
(6, 37),                        -- Pologne : Continental
(6, 38), (7, 38),               -- Suède : Continental + Polaire (extrême nord)
(5, 39), (6, 39), (7, 39),      -- Norvège : Océanique (côtes) + Continental + Polaire
(4, 40), (8, 40);               -- Grèce : Méditerranéen + Montagne
GO

-- ===== Océanie =====
INSERT INTO Caracteristique.ClimatPays (ClimatID, PaysID)
VALUES
(5, 41), (3, 41), (2, 41);      -- Australie : Océanique (côtes) + Aride (centre) + Tropical (nord)
GO