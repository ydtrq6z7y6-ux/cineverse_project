# CINEVERSE - DETALJNA SPECIFIKACIJA TABELA

## TABELA 1: COUNTRIES (Zemlje)

### Namena
Referentna tabela koja sadrži sve zemlje koje se pojavljuju u datasetu. Ovo omogućava normalizaciju i izbegavanje duplikaranja naziva zemalja.

### Struktura

| Kolona | Tip | Ključ | Ograničenja | Opis |
|--------|-----|-------|------------|------|
| country_id | INT | PK | NOT NULL, AUTO_INCREMENT | Jedinstveni identifikator |
| country_name | VARCHAR(100) | - | NOT NULL, UNIQUE | Nazv zemlje (npr. "USA", "UK", "Japan") |
| region | VARCHAR(100) | - | - | Geografska regija (Evropa, Azija, Severna Amerika) |
| created_at | TIMESTAMP | - | DEFAULT CURRENT_TIMESTAMP | Vremenska oznaka kreiranja |
| updated_at | TIMESTAMP | - | DEFAULT CURRENT_TIMESTAMP ON UPDATE | Vremenska oznaka poslednje izmene |

### Primeri podataka

```
country_id | country_name | region
-----------|--------------|----------------------
1          | USA          | North America
2          | UK           | Europe
3          | Japan        | Asia
4          | France       | Europe
5          | Germany      | Europe
6          | India        | Asia
7          | Brazil       | South America
```

### SQL za primerom umetanja

```sql
INSERT INTO COUNTRIES (country_name, region) VALUES
('USA', 'North America'),
('UK', 'Europe'),
('Japan', 'Asia'),
('France', 'Europe'),
('Germany', 'Europe'),
('India', 'Asia'),
('Brazil', 'South America');
```

---

## TABELA 2: DIRECTORS (Redaž iseri)

### Namena
Sadrži informacije o redažiserima filmova. Omogućava analizu i pretragu filmova po redažiseru.

### Struktura

| Kolona | Tip | Ključ | Ograničenja | Opis |
|--------|-----|-------|------------|------|
| director_id | INT | PK | NOT NULL, AUTO_INCREMENT | Jedinstveni identifikator |
| first_name | VARCHAR(100) | - | NOT NULL | Ime redažisera |
| last_name | VARCHAR(100) | - | NOT NULL | Prezime redažisera |
| country_of_origin | VARCHAR(100) | - | - | Zemlja porekla |
| birth_year | INT | - | CHECK (1800-CURDATE()) | Godina rođenja |
| biography | TEXT | - | - | Kratka biografija |
| created_at | TIMESTAMP | - | DEFAULT CURRENT_TIMESTAMP | Vremenska oznaka |
| updated_at | TIMESTAMP | - | DEFAULT CURRENT_TIMESTAMP ON UPDATE | Vremenska oznaka |
| INDEX | - | - | (last_name, first_name) | Za brze pretrage |

### Primeri podataka

```
director_id | first_name     | last_name   | country_of_origin | birth_year
------------|----------------|-------------|-------------------|----------
1           | Frank          | Darabont    | USA               | 1959
2           | Francis Ford   | Coppola     | USA               | 1939
3           | Christopher    | Nolan       | UK                | 1970
4           | Quentin        | Tarantino   | USA               | 1963
5           | Robert         | Zemeckis    | USA               | 1952
```

### SQL primer

```sql
INSERT INTO DIRECTORS (first_name, last_name, country_of_origin, birth_year) VALUES
('Frank', 'Darabont', 'USA', 1959),
('Francis Ford', 'Coppola', 'USA', 1939),
('Christopher', 'Nolan', 'UK', 1970),
('Quentin', 'Tarantino', 'USA', 1963),
('Robert', 'Zemeckis', 'USA', 1952);
```

---

## TABELA 3: GENRES (Žanrovi)

### Namena
Referentna tabela sa filmskim žanrovima. Omogućava grupisanje filmova i kros-pretragu po žanru.

### Struktura

| Kolona | Tip | Ključ | Ograničenja | Opis |
|--------|-----|-------|------------|------|
| genre_id | INT | PK | NOT NULL, AUTO_INCREMENT | Jedinstveni identifikator |
| genre_name | VARCHAR(50) | - | NOT NULL, UNIQUE | Naziv žanra (npr. "Drama", "Action") |
| description | VARCHAR(255) | - | - | Opis karakteristika žanra |
| created_at | TIMESTAMP | - | DEFAULT CURRENT_TIMESTAMP | Vremenska oznaka |
| updated_at | TIMESTAMP | - | DEFAULT CURRENT_TIMESTAMP ON UPDATE | Vremenska oznaka |

### Primeri podataka

```
genre_id | genre_name  | description
---------|-------------|-----------------------------------------------
1        | Drama       | Serious stories about human experiences
2        | Action      | High-energy films with thrilling sequences
3        | Sci-Fi      | Science fiction with futuristic elements
4        | Crime       | Stories centered around criminal activity
5        | Thriller    | Suspenseful films designed to excite
6        | Historical  | Films based on historical events
```

### SQL primer

```sql
INSERT INTO GENRES (genre_name, description) VALUES
('Drama', 'Serious stories about human experiences'),
('Action', 'High-energy films with thrilling sequences'),
('Sci-Fi', 'Science fiction with futuristic elements'),
('Crime', 'Stories centered around criminal activity'),
('Thriller', 'Suspenseful films designed to excite'),
('Historical', 'Films based on historical events');
```

---

## TABELA 4: ACTORS (Glumci)

### Namena
Sadrži informacije o glumcima. Omogućava pretragu i analizu filmova prema glumcima.

### Struktura

| Kolona | Tip | Ključ | Ograničenja | Opis |
|--------|-----|-------|------------|------|
| actor_id | INT | PK | NOT NULL, AUTO_INCREMENT | Jedinstveni identifikator |
| first_name | VARCHAR(100) | - | NOT NULL | Ime glumca |
| last_name | VARCHAR(100) | - | NOT NULL | Prezime glumca |
| country_of_birth | VARCHAR(100) | - | - | Zemlja rođenja |
| birth_year | INT | - | CHECK (1850-CURDATE()) | Godina rođenja |
| biography | TEXT | - | - | Kratka biografija |
| created_at | TIMESTAMP | - | DEFAULT CURRENT_TIMESTAMP | Vremenska oznaka |
| updated_at | TIMESTAMP | - | DEFAULT CURRENT_TIMESTAMP ON UPDATE | Vremenska oznaka |
| INDEX | - | - | (last_name, first_name) | Za brze pretrage |

### Primeri podataka

```
actor_id | first_name | last_name  | country_of_birth | birth_year
---------|-----------|------------|------------------|----------
1        | Tim       | Robbins    | USA              | 1958
2        | Morgan    | Freeman    | USA              | 1937
3        | Bob       | Gunton     | USA              | 1941
4        | Marlon    | Brando     | USA              | 1924
5        | Al        | Pacino     | USA              | 1940
```

### SQL primer

```sql
INSERT INTO ACTORS (first_name, last_name, country_of_birth, birth_year) VALUES
('Tim', 'Robbins', 'USA', 1958),
('Morgan', 'Freeman', 'USA', 1937),
('Bob', 'Gunton', 'USA', 1941),
('Marlon', 'Brando', 'USA', 1924),
('Al', 'Pacino', 'USA', 1940);
```

---

## TABELA 5: MOVIES (Filmovi)

### Namena
Glavna tabela sa detaljima filmova. Sadrži spoljne ključeve na redažisere i zemlje.

### Struktura

| Kolona | Tip | Ključ | Ograničenja | Opis |
|--------|-----|-------|------------|------|
| movie_id | INT | PK | NOT NULL, AUTO_INCREMENT | Jedinstveni identifikator |
| title | VARCHAR(255) | - | NOT NULL | Naslov filma |
| year | INT | - | NOT NULL, CHECK (1895+) | Godina izdanja |
| duration | INT | - | NOT NULL, CHECK (> 0) | Trajanje u minutama |
| imdb_rating | DECIMAL(3,1) | - | CHECK (0-10) | IMDb ocena |
| imdb_votes | INT | - | CHECK (>= 0) | Broj glasova |
| synopsis | TEXT | - | - | Kratak opis filma |
| budget | DECIMAL(15,2) | - | CHECK (>= 0) | Budžet u dolarima |
| box_office | DECIMAL(15,2) | - | CHECK (>= 0) | Prihod od bioskopa |
| director_id | INT | FK | NOT NULL | ID redažisera |
| country_id | INT | FK | NOT NULL | ID zemlje |
| created_at | TIMESTAMP | - | DEFAULT CURRENT_TIMESTAMP | Vremenska oznaka |
| updated_at | TIMESTAMP | - | DEFAULT CURRENT_TIMESTAMP ON UPDATE | Vremenska oznaka |

### Primeri podataka

```
movie_id | title                    | year | duration | imdb_rating | director_id | country_id
---------|--------------------------|------|----------|-------------|-------------|----------
1        | The Shawshank Redemption | 1994 | 142      | 9.3         | 1           | 1
2        | The Godfather            | 1972 | 175      | 9.2         | 2           | 1
3        | The Dark Knight          | 2008 | 152      | 9.1         | 3           | 1
4        | Pulp Fiction             | 1994 | 154      | 8.8         | 4           | 1
5        | Inception                | 2010 | 148      | 8.8         | 3           | 1
```

### SQL primer

```sql
INSERT INTO MOVIES (title, year, duration, imdb_rating, imdb_votes, director_id, country_id) VALUES
('The Shawshank Redemption', 1994, 142, 9.3, 3164324, 1, 1),
('The Godfather', 1972, 175, 9.2, 2205717, 2, 1),
('The Dark Knight', 2008, 152, 9.1, 3135889, 3, 1),
('Pulp Fiction', 1994, 154, 8.8, 2410498, 4, 1),
('Inception', 2010, 148, 8.8, 3211332, 3, 1);
```

---

## TABELA 6: MOVIE_GENRE (Povezujuća tabela - M:N)

### Namena
Mapira M:N relaciju između filmova i žanrova. Svaki film može imati više žanrova, i svaki žanr kan biti povezan sa više filmova.

### Struktura

| Kolona | Tip | Ključ | Ograničenja | Opis |
|--------|-----|-------|------------|------|
| movie_id | INT | PK, FK | NOT NULL | ID filma (referenca na MOVIES) |
| genre_id | INT | PK, FK | NOT NULL | ID žanra (referenca na GENRES) |

### Primeri podataka

```
movie_id | genre_id | Filmski opis
---------|----------|-------------------------------------
1        | 1        | The Shawshank Redemption - Drama
2        | 4        | The Godfather - Crime
3        | 2        | The Dark Knight - Action
4        | 4        | Pulp Fiction - Crime
4        | 1        | Pulp Fiction - Drama (M:N veza!)
```

### SQL primer

```sql
INSERT INTO MOVIE_GENRE (movie_id, genre_id) VALUES
(1, 1),  -- The Shawshank Redemption: Drama
(2, 4),  -- The Godfather: Crime
(3, 2),  -- The Dark Knight: Action
(4, 4),  -- Pulp Fiction: Crime
(4, 1),  -- Pulp Fiction: Drama (M:N!)
(5, 3);  -- Inception: Sci-Fi
```

### Mogući upiti

```sql
-- Pronađi sve žanrove filma
SELECT g.genre_name
FROM GENRES g
INNER JOIN MOVIE_GENRE mg ON g.genre_id = mg.genre_id
WHERE mg.movie_id = 4;

-- Rezultat: Crime, Drama

-- Pronađi sve filmove comedy žanra
SELECT m.title
FROM MOVIES m
INNER JOIN MOVIE_GENRE mg ON m.movie_id = mg.movie_id
INNER JOIN GENRES g ON mg.genre_id = g.genre_id
WHERE g.genre_name = 'Comedy';
```

---

## TABELA 7: MOVIE_ACTOR (Povezujuća tabela - M:N)

### Namena
Mapira M:N relaciju između filmova i glumaca. Sadrži dodatne informacije kao što su uloga i redosled.

### Struktura

| Kolona | Tip | Ključ | Ograničenja | Opis |
|--------|-----|-------|------------|------|
| movie_id | INT | PK, FK | NOT NULL | ID filma (referenca na MOVIES) |
| actor_id | INT | PK, FK | NOT NULL | ID glumca (referenca na ACTORS) |
| role | VARCHAR(100) | - | - | Uloga glumca u filmu |
| billing_order | INT | - | - | Redosled na filmskom plakatu |

### Primeri podataka

```
movie_id | actor_id | role            | billing_order
---------|----------|-----------------|---------------
1        | 1        | Andy Dufresne   | 1
1        | 2        | Red             | 2
1        | 3        | Samuel Norton   | 3
2        | 4        | Vito Corleone   | 1
2        | 5        | Michael Corleone| 2
```

### SQL primer

```sql
INSERT INTO MOVIE_ACTOR (movie_id, actor_id, role, billing_order) VALUES
(1, 1, 'Andy Dufresne', 1),
(1, 2, 'Red', 2),
(1, 3, 'Samuel Norton', 3),
(2, 4, 'Vito Corleone', 1),
(2, 5, 'Michael Corleone', 2);
```

### Mogući upiti

```sql
-- Pronađi sve glumce u određenom filmu
SELECT a.first_name, a.last_name, ma.role
FROM ACTORS a
INNER JOIN MOVIE_ACTOR ma ON a.actor_id = ma.actor_id
WHERE ma.movie_id = 1
ORDER BY ma.billing_order;

-- Pronađi sve filmove određenog glumca
SELECT m.title, ma.role
FROM MOVIES m
INNER JOIN MOVIE_ACTOR ma ON m.movie_id = ma.movie_id
WHERE ma.actor_id = 1
ORDER BY m.year;

-- Pronađi glume sa kojim je glumac radio
SELECT DISTINCT a2.first_name, a2.last_name
FROM MOVIE_ACTOR ma1
INNER JOIN MOVIES m ON ma1.movie_id = m.movie_id
INNER JOIN MOVIE_ACTOR ma2 ON m.movie_id = ma2.movie_id
INNER JOIN ACTORS a1 ON ma1.actor_id = a1.actor_id
INNER JOIN ACTORS a2 ON ma2.actor_id = a2.actor_id
WHERE a1.actor_id = 1 AND a2.actor_id != a1.actor_id;
```

---

## SAŽETAK RELACIJA

```
┌──────────────────────────────────────────────────────────┐
│              RELACIJSKE VEZE - SUMIRANI PREGLED          │
├──────────────────────────────────────────────────────────┤
│ COUNTRIES ─────────1:N────→ MOVIES                      │
│ DIRECTORS ─────────1:N────→ MOVIES                      │
│ GENRES   ←────────M:N─────→ MOVIES (preko MOVIE_GENRE) │
│ ACTORS   ←────────M:N─────→ MOVIES (preko MOVIE_ACTOR) │
└──────────────────────────────────────────────────────────┘
```

---

