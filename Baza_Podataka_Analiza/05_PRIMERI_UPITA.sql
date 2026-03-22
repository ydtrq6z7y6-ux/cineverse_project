-- =====================================================
-- CINEVERSE - PRIMERI SQL UPITA
-- =====================================================

-- Napomena: Ovi upiti pretpostavljaju da su tabele kreirane 
-- i da sadrže podatke prema SQL DDL skriptam

USE cineverse_db;

-- =====================================================
-- GRUPA 1: OSNOVNI UPITI ZA BRZU ANALIZU
-- =====================================================

-- 1.1: Svi filmovi sortirani po godini
SELECT movie_id, title, year, duration, imdb_rating
FROM MOVIES
ORDER BY year DESC;

-- 1.2: Pronađi filmove sa najboljom ocenom
SELECT title, year, imdb_rating, imdb_votes
FROM MOVIES
WHERE imdb_rating >= 9.0
ORDER BY imdb_rating DESC;

-- 1.3: Pronađi filmove po godini
SELECT DISTINCT year
FROM MOVIES
ORDER BY year DESC;

-- 1.4: Koliko je filmova iz svake godine?
SELECT year, COUNT(*) as broj_filmova
FROM MOVIES
GROUP BY year
ORDER BY year DESC;

-- =====================================================
-- GRUPA 2: UPITI SAS SPOJENJEM TABELA (JOINS)
-- =====================================================

-- 2.1: Svi filmovi sa imenima redažisera
SELECT 
    m.title,
    m.year,
    m.imdb_rating,
    CONCAT(d.first_name, ' ', d.last_name) as redaže iser,
    c.country_name as zemlja_porekla
FROM MOVIES m
INNER JOIN DIRECTORS d ON m.director_id = d.director_id
INNER JOIN COUNTRIES c ON m.country_id = c.country_id
ORDER BY m.year DESC;

-- 2.2: Pronađi sve filmove redažisera "Christopher Nolan"
SELECT 
    m.title,
    m.year,
    m.imdb_rating,
    m.duration
FROM MOVIES m
INNER JOIN DIRECTORS d ON m.director_id = d.director_id
WHERE d.first_name = 'Christopher' AND d.last_name = 'Nolan'
ORDER BY m.year DESC;

-- 2.3: Pronađi redažisere koji su režirali više od jednog filma
SELECT 
    d.director_id,
    CONCAT(d.first_name, ' ', d.last_name) as redaže iser,
    COUNT(m.movie_id) as broj_filmova,
    AVG(m.imdb_rating) as prosečna_ocena
FROM DIRECTORS d
INNER JOIN MOVIES m ON d.director_id = m.director_id
GROUP BY d.director_id, d.first_name, d.last_name
HAVING COUNT(m.movie_id) > 1
ORDER BY broj_filmova DESC;

-- =====================================================
-- GRUPA 3: UPITI SA ŽANROVIMA
-- =====================================================

-- 3.1: Svi filmovi sa njihovim žanrovima
SELECT 
    m.title,
    m.year,
    GROUP_CONCAT(g.genre_name SEPARATOR ', ') as zanrovi
FROM MOVIES m
LEFT JOIN MOVIE_GENRE mg ON m.movie_id = mg.movie_id
LEFT JOIN GENRES g ON mg.genre_id = g.genre_id
GROUP BY m.movie_id, m.title, m.year
ORDER BY m.year DESC;

-- 3.2: Pronađi sve filmove sa žanrom "Drama"
SELECT 
    m.title,
    m.year,
    m.imdb_rating
FROM MOVIES m
INNER JOIN MOVIE_GENRE mg ON m.movie_id = mg.movie_id
INNER JOIN GENRES g ON mg.genre_id = g.genre_id
WHERE g.genre_name = 'Drama'
ORDER BY m.imdb_rating DESC;

-- 3.3: Koliko filmova je svakog žanra?
SELECT 
    g.genre_name,
    COUNT(m.movie_id) as broj_filmova,
    AVG(m.imdb_rating) as prosečna_ocena
FROM GENRES g
LEFT JOIN MOVIE_GENRE mg ON g.genre_id = mg.genre_id
LEFT JOIN MOVIES m ON mg.movie_id = m.movie_id
GROUP BY g.genre_id, g.genre_name
ORDER BY broj_filmova DESC;

-- 3.4: Pronađi filmove sa više od jednog žanra
SELECT 
    m.title,
    m.year,
    COUNT(g.genre_id) as broj_zanrova,
    GROUP_CONCAT(g.genre_name SEPARATOR ', ') as zanrovi
FROM MOVIES m
LEFT JOIN MOVIE_GENRE mg ON m.movie_id = mg.movie_id
LEFT JOIN GENRES g ON mg.genre_id = g.genre_id
GROUP BY m.movie_id
HAVING COUNT(g.genre_id) > 1
ORDER BY broj_zanrova DESC;

-- =====================================================
-- GRUPA 4: UPITI SA GLUMCIMA
-- =====================================================

-- 4.1: Svi filmovi sa glavnim glumcima
SELECT 
    m.title,
    m.year,
    GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name) SEPARATOR ', ') as glumci
FROM MOVIES m
LEFT JOIN MOVIE_ACTOR ma ON m.movie_id = ma.movie_id
LEFT JOIN ACTORS a ON ma.actor_id = a.actor_id
GROUP BY m.movie_id, m.title, m.year
ORDER BY m.year DESC;

-- 4.2: Koliko je filmova snimio određeni glumac?
SELECT 
    a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) as glumac,
    COUNT(m.movie_id) as broj_filmova,
    AVG(m.imdb_rating) as prosečna_ocena
FROM ACTORS a
LEFT JOIN MOVIE_ACTOR ma ON a.actor_id = ma.actor_id
LEFT JOIN MOVIES m ON ma.movie_id = m.movie_id
WHERE a.first_name = 'Tim' AND a.last_name = 'Robbins'
GROUP BY a.actor_id;

-- 4.3: Glumci koji su istovremeno bili u filmovima
SELECT DISTINCT
    a2.first_name,
    a2.last_name,
    COUNT(DISTINCT m.movie_id) as broj_zajednickih_filmova
FROM MOVIE_ACTOR ma1
INNER JOIN MOVIES m ON ma1.movie_id = m.movie_id
INNER JOIN MOVIE_ACTOR ma2 ON m.movie_id = ma2.movie_id
INNER JOIN ACTORS a1 ON ma1.actor_id = a1.actor_id
INNER JOIN ACTORS a2 ON ma2.actor_id = a2.actor_id
WHERE a1.first_name = 'Tim' AND a1.last_name = 'Robbins'
  AND a2.actor_id != a1.actor_id
GROUP BY a2.actor_id, a2.first_name, a2.last_name
ORDER BY broj_zajednickih_filmova DESC;

-- =====================================================
-- GRUPA 5: ANALITIČKI UPITI - PERFORMANSA
-- =====================================================

-- 5.1: Prosečni budžet i prihod po godini
SELECT 
    year,
    COUNT(*) as broj_filmova,
    AVG(budget) as prosečan_budžet,
    AVG(box_office) as prosečan_prihod,
    SUM(box_office) - SUM(budget) as ukupna_dobit
FROM MOVIES
WHERE budget IS NOT NULL AND box_office IS NOT NULL
GROUP BY year
ORDER BY year DESC;

-- 5.2: Najrentabilniji filmovi (profit marža)
SELECT 
    title,
    year,
    budget,
    box_office,
    (box_office - budget) as dobit,
    ROUND(((box_office - budget) / budget * 100), 2) as marza_procenata
FROM MOVIES
WHERE budget > 0 AND box_office IS NOT NULL
ORDER BY marza_procenata DESC
LIMIT 10;

-- 5.3: Redažiseri sa najvećim prosečnim budžetima
SELECT 
    d.director_id,
    CONCAT(d.first_name, ' ', d.last_name) as redaže iser,
    COUNT(m.movie_id) as broj_filmova,
    AVG(m.budget) as prosečan_budžet,
    AVG(m.box_office) as prosečan_prihod
FROM DIRECTORS d
LEFT JOIN MOVIES m ON d.director_id = m.director_id
WHERE m.budget IS NOT NULL
GROUP BY d.director_id, d.first_name, d.last_name
ORDER BY prosečan_budžet DESC
LIMIT 10;

-- =====================================================
-- GRUPA 6: UPITI ZA PRETRAGU - TEXT SEARCH
-- =====================================================

-- 6.1: Pronađi filmove po naslovu (LIKE pretraga)
SELECT 
    movie_id,
    title,
    year,
    imdb_rating
FROM MOVIES
WHERE title LIKE '%Matrix%'
ORDER BY year DESC;

-- 6.2: Pronađi filmove koji sadrže reč u opisu
SELECT 
    movie_id,
    title,
    year,
    synopsis
FROM MOVIES
WHERE synopsis LIKE '%prison%' OR synopsis LIKE '%escape%'
ORDER BY year DESC;

-- =====================================================
-- GRUPA 7: UPITI ZA AGREGACIJU PODATAKA
-- =====================================================

-- 7.1: Top 10 najbolje ocenjenih filmova
SELECT 
    title,
    year,
    imdb_rating,
    imdb_votes,
    duration
FROM MOVIES
ORDER BY imdb_rating DESC, imdb_votes DESC
LIMIT 10;

-- 7.2: Zemljopis filmske produkcije
SELECT 
    c.country_name,
    COUNT(m.movie_id) as broj_filmova,
    AVG(m.imdb_rating) as prosečna_ocena
FROM COUNTRIES c
LEFT JOIN MOVIES m ON c.country_id = m.country_id
GROUP BY c.country_id, c.country_name
ORDER BY broj_filmova DESC;

-- 7.3: Filmovi po deceniji
SELECT 
    (year DIV 10) * 10 as decenija,
    COUNT(*) as broj_filmova,
    AVG(imdb_rating) as prosečna_ocena,
    MIN(imdb_rating) as najniza_ocena,
    MAX(imdb_rating) as najviša_ocena
FROM MOVIES
GROUP BY decenija
ORDER BY decenija DESC;

-- =====================================================
-- GRUPA 8: KOMPLEKSNI UPITI
-- =====================================================

-- 8.1: Kompletan pregled filma sa svim detaljima
SELECT 
    m.movie_id,
    m.title,
    m.year,
    m.duration,
    m.imdb_rating,
    m.imdb_votes,
    CONCAT(d.first_name, ' ', d.last_name) as redaže iser,
    c.country_name,
    GROUP_CONCAT(DISTINCT g.genre_name SEPARATOR ', ') as zanrovi,
    GROUP_CONCAT(DISTINCT CONCAT(a.first_name, ' ', a.last_name) SEPARATOR ', ') as glumci
FROM MOVIES m
LEFT JOIN DIRECTORS d ON m.director_id = d.director_id
LEFT JOIN COUNTRIES c ON m.country_id = c.country_id
LEFT JOIN MOVIE_GENRE mg ON m.movie_id = mg.movie_id
LEFT JOIN GENRES g ON mg.genre_id = g.genre_id
LEFT JOIN MOVIE_ACTOR ma ON m.movie_id = ma.movie_id
LEFT JOIN ACTORS a ON ma.actor_id = a.actor_id
WHERE m.title LIKE '%Godfather%'
GROUP BY m.movie_id;

-- =====================================================
-- GRUPA 9: UPITI ZA ODRŽAVANJE I MONITORING
-- =====================================================

-- 9.1: Redažiseri bez filmova (ako postoje)
SELECT 
    d.director_id,
    CONCAT(d.first_name, ' ', d.last_name) as redaže iser
FROM DIRECTORS d
LEFT JOIN MOVIES m ON d.director_id = m.director_id
WHERE m.movie_id IS NULL;

-- 9.2: Filmovi bez redažisera (ako postoje)
SELECT 
    movie_id,
    title,
    year
FROM MOVIES
WHERE director_id IS NULL;

-- 9.3: Nepotpuni zapisi (nedostaju ključni podaci)
SELECT 
    movie_id,
    title,
    CASE WHEN synopsis IS NULL THEN 'Nedostaje opis' ELSE 'OK' END as opis,
    CASE WHEN budget IS NULL THEN 'Nedostaje budžet' ELSE 'OK' END as budžet,
    CASE WHEN box_office IS NULL THEN 'Nedostaje prihod' ELSE 'OK' END as prihod
FROM MOVIES
WHERE synopsis IS NULL OR budget IS NULL OR box_office IS NULL;

-- =====================================================
