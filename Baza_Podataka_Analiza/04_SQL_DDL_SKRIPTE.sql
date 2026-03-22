-- =====================================================
-- CINEVERSE - SQL DDL SKRIPTE
-- Kreiranje baze podataka i tabela
-- =====================================================

-- Opciono: Obrisi postojeću bazu (ako postoji)
-- DROP DATABASE IF EXISTS cineverse_db;

-- Kreiraj novu bazu podataka
CREATE DATABASE IF NOT EXISTS cineverse_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE cineverse_db;

-- =====================================================
-- TABELA: COUNTRIES (Zemlje)
-- =====================================================
CREATE TABLE COUNTRIES (
    country_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Jedinstveni identifikator zemlje',
    country_name VARCHAR(100) NOT NULL UNIQUE COMMENT 'Naziv zemlje',
    region VARCHAR(100) COMMENT 'Regija (Evropa, Azija, Severna Amerika, itd.)',
    population INT COMMENT 'Broj stanovnika',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Vreme kreiranja reda',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Vreme ažuriranja reda'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Referentna tabela sa informacijama o zemljama';

-- =====================================================
-- TABELA: DIRECTORS (Režiseri)
-- =====================================================
CREATE TABLE DIRECTORS (
    director_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Jedinstveni identifikator režisera',
    first_name VARCHAR(100) NOT NULL COMMENT 'Ime režisera',
    last_name VARCHAR(100) NOT NULL COMMENT 'Prezime režisera',
    country_of_origin VARCHAR(100) COMMENT 'Zemlja porekla',
    birth_year INT COMMENT 'Godina rođenja',
    biography TEXT COMMENT 'Kratka biografija',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Indeks za brže pretrage
    INDEX idx_full_name (last_name, first_name),
    
    CONSTRAINT check_birth_year CHECK (birth_year >= 1800 AND birth_year <= YEAR(CURDATE()))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Informacije o režiserima filmova';

-- =====================================================
-- TABELA: GENRES (Žanrovi)
-- =====================================================
CREATE TABLE GENRES (
    genre_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Jedinstveni identifikator žanra',
    genre_name VARCHAR(50) NOT NULL UNIQUE COMMENT 'Naziv žanra (Drama, Action, Sci-Fi, itd.)',
    description VARCHAR(255) COMMENT 'Opis žanra',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Referentna tabela sa filmskim žanrovima';

-- =====================================================
-- TABELA: ACTORS (Glumci)
-- =====================================================
CREATE TABLE ACTORS (
    actor_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Jedinstveni identifikator glumca',
    first_name VARCHAR(100) NOT NULL COMMENT 'Ime glumca',
    last_name VARCHAR(100) NOT NULL COMMENT 'Prezime glumca',
    country_of_birth VARCHAR(100) COMMENT 'Zemlja rođenja',
    birth_year INT COMMENT 'Godina rođenja',
    biography TEXT COMMENT 'Kratka biografija',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Indeks za brže pretrage
    INDEX idx_full_name (last_name, first_name),
    
    CONSTRAINT check_actor_birth_year CHECK (birth_year >= 1850 AND birth_year <= YEAR(CURDATE()))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Informacije o glumcima';

-- =====================================================
-- TABELA: MOVIES (Filmovi)
-- GLAVNA TABELA SA FILMIMA
-- =====================================================
CREATE TABLE MOVIES (
    movie_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Jedinstveni identifikator filma',
    title VARCHAR(255) NOT NULL COMMENT 'Naslov filma',
    year INT NOT NULL COMMENT 'Godina izdanja',
    duration INT NOT NULL COMMENT 'Trajanje filma u minutama',
    imdb_rating DECIMAL(3,1) COMMENT 'IMDb ocena (0.0-10.0)',
    imdb_votes INT COMMENT 'Broj glasova na IMDb-u',
    synopsis TEXT COMMENT 'Kratak opis filma',
    budget DECIMAL(15,2) COMMENT 'Budžet filma u dolarima',
    box_office DECIMAL(15,2) COMMENT 'Prihod od bioskopa u dolarima',
    
    -- Strani ključevi
    director_id INT NOT NULL COMMENT 'ID redaže isera',
    country_id INT NOT NULL COMMENT 'ID zemlje porekla',
    
    -- Metadata
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Indeksi za brže pretrage
    INDEX idx_title (title),
    INDEX idx_year (year),
    INDEX idx_rating (imdb_rating),
    INDEX idx_director (director_id),
    INDEX idx_country (country_id),
    
    -- Ograničenja
    CONSTRAINT check_year CHECK (year >= 1895 AND year <= YEAR(CURDATE())),
    CONSTRAINT check_duration CHECK (duration > 0),
    CONSTRAINT check_rating CHECK (imdb_rating >= 0 AND imdb_rating <= 10),
    CONSTRAINT check_votes CHECK (imdb_votes >= 0),
    CONSTRAINT check_budget CHECK (budget >= 0),
    CONSTRAINT check_box_office CHECK (box_office >= 0),
    
    -- Strani ključevi
    CONSTRAINT fk_movies_director FOREIGN KEY (director_id) 
        REFERENCES DIRECTORS(director_id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_movies_country FOREIGN KEY (country_id) 
        REFERENCES COUNTRIES(country_id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
        
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Glavna tabela sa informacijama o filmovima';

-- =====================================================
-- TABELA: MOVIE_GENRE (Povezujuća tabela - M:N)
-- Mapira relaciju između MOVIES i GENRES
-- =====================================================
CREATE TABLE MOVIE_GENRE (
    movie_id INT NOT NULL COMMENT 'ID filma',
    genre_id INT NOT NULL COMMENT 'ID žanra',
    
    -- Primarni ključ kombinovan iz dva stranih ključa
    PRIMARY KEY (movie_id, genre_id),
    
    -- Indeksi
    INDEX idx_genre (genre_id),
    
    -- Strani ključevi
    CONSTRAINT fk_mg_movie FOREIGN KEY (movie_id) 
        REFERENCES MOVIES(movie_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_mg_genre FOREIGN KEY (genre_id) 
        REFERENCES GENRES(genre_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
        
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Povezujuća tabela između filmova i žanrova (M:N relacija)';

-- =====================================================
-- TABELA: MOVIE_ACTOR (Povezujuća tabela - M:N)
-- Mapira relaciju između MOVIES i ACTORS
-- =====================================================
CREATE TABLE MOVIE_ACTOR (
    movie_id INT NOT NULL COMMENT 'ID filma',
    actor_id INT NOT NULL COMMENT 'ID glumca',
    role VARCHAR(100) COMMENT 'Uloga glumca u filmu',
    billing_order INT COMMENT 'Redosled glumca na filmskom plakatu',
    
    -- Primarni ključ kombinovan iz dva stranih ključa
    PRIMARY KEY (movie_id, actor_id),
    
    -- Indeksi
    INDEX idx_actor (actor_id),
    INDEX idx_billing (billing_order),
    
    -- Strani ključevi
    CONSTRAINT fk_ma_movie FOREIGN KEY (movie_id) 
        REFERENCES MOVIES(movie_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_ma_actor FOREIGN KEY (actor_id) 
        REFERENCES ACTORS(actor_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
        
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Povezujuća tabela između filmova i glumaca (M:N relacija)';

-- =====================================================
-- KREIRAJ INDEKSE ZA BOLJU PERFORMANSU
-- =====================================================

-- Indeks za često korišćene kolone
CREATE INDEX idx_movies_title_year ON MOVIES(title, year);
CREATE INDEX idx_movies_rating_year ON MOVIES(imdb_rating DESC, year DESC);

-- =====================================================
-- PRIMENA OGRANIČENJA I NORMALIZACIJE
-- =====================================================
-- Baza je normalizovana do 3NF nivoa

-- 1NF: Sve vrednosti su atomske (nema ponavljajućih grupa)
-- ✓ Nema multi-vrednosnih atributa
-- ✓ Žanrovi i glumci su u odvojenim tabelama

-- 2NF: Nema parcijalne zavisnosti
-- ✓ M:N relacije su rešene kroz povezujuće tabele
-- ✓ Svi non-key atributi u potpunosti zavise od PK

-- 3NF: Nema tranzitivne zavisnosti
-- ✓ Country, Director i Actor su u odvojenim tabelama
-- ✓ Nema atributa koji zavise od drugih non-key atributa

-- =====================================================
-- PRIKAZ NAPRAVENIH TABELA
-- =====================================================

-- Prikaži sve tabele
SHOW TABLES;

-- Prikaži detaljnu strukturu tabela
DESCRIBE COUNTRIES;
DESCRIBE DIRECTORS;
DESCRIBE GENRES;
DESCRIBE ACTORS;
DESCRIBE MOVIES;
DESCRIBE MOVIE_GENRE;
DESCRIBE MOVIE_ACTOR;

-- =====================================================
