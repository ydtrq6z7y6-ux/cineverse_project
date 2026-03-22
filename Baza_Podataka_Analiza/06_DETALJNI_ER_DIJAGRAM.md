# CINEVERSE - DETALJNI ER DIJAGRAM I RELACIJE

## KONCEPTUALNI MODEL - ENTITETSKA VEZA (ER) DIJAGRAM

```
┌─────────────────────────────────────────────────────────────────┐
│                      FILMSKA BAZA PODATAKA - CINEVERSE           │
└─────────────────────────────────────────────────────────────────┘

                          ┌──────────────┐
                          │   DIRECTORS  │
                          ├──────────────┤
                          │ director_id  │ PK
                          │ first_name   │
                          │ last_name    │
                          │ birth_year   │
                          └──────┬───────┘
                                 │
                            1:N  │
                                 │
    ┌────────────────────────────┼────────────────────────────┐
    │                            │                            │
    │                            ▼                            │
    │                    ┌──────────────┐                     │
    │                    │    MOVIES    │                     │
    │                    ├──────────────┤                     │
    │                    │ movie_id  PK │                     │
    │          FK ───────┤ director_id  │                     │
    │          FK ───────┤ country_id   │                     │
    │                    │ title        │                     │
    │                    │ year         │                     │
    │                    │ duration     │                     │
    │                    │ imdb_rating  │                     │
    │                    │ budget       │                     │
    │                    │ box_office   │                     │
    │                    └────┬─────┬───┘                     │
    │                         │     │                         │
    │                    M:N  │     │  M:N                    │
    │                         │     │                         │
    │         ┌───────────────┘     └───────────────┐         │
    │         │                                     │         │
    │         ▼                                     ▼         │
    │    ┌──────────────┐                  ┌──────────────┐   │
    │    │ MOVIE_GENRE  │                  │ MOVIE_ACTOR  │   │
    │    ├──────────────┤                  ├──────────────┤   │
    │    │ movie_id PK  │                  │ movie_id PK  │   │
    │    │ genre_id  PK │                  │ actor_id  PK │   │
    │    │   FK (M)     │                  │ role         │   │
    │    │   FK (N)     │                  │   FK (M)     │   │
    │    └──────┬───────┘                  │   FK (N)     │   │
    │           │                          └──────┬───────┘   │
    │           │                                 │           │
    │    1:N    │                          1:N    │           │
    │           │                                 │           │
    │           ▼                                 ▼           │
    │      ┌──────────────┐               ┌──────────────┐    │
    │      │    GENRES    │               │    ACTORS    │    │
    │      ├──────────────┤               ├──────────────┤    │
    │      │  genre_id PK │               │   actor_id PK│    │
    │      │ genre_name   │               │  first_name  │    │
    │      │ description  │               │   last_name  │    │
    │      └──────────────┘               │  birth_year  │    │
    │                                     └──────────────┘    │
    │                                                         │
    │  ┌────────────────────────────────────┐               │
    │  │    COUNTRIES                       │               │
    │  │    ├──────────────────────────┤   │               │
    │  │    │    country_id  PK        │   │               │
    │  │    │    country_name (UNIQUE) │   │               │
    │  │    │    region                │   │               │
    │  │    └──────────────────────────┘   │               │
    │  └────────────┬───────────────────────┘               │
    │               │                                       │
    │          1:N  │                                       │
    └───────────────┼───────────────────────────────────────┘
                    │
                    └─── FK veza sa MOVIES
```

---

## RELACIJE MEĐU ENTITETIMA

### 1. **DIRECTORS (Redaž iseri)**
```
Kardinalnost: 1:N sa MOVIES
Opis: Jedan redažiser može režirati više filmova
       Ali svaki film ima samo jednog redažisera

Veza: MOVIES.director_id → DIRECTORS.director_id

Primeri:
  • Steven Spielberg je režirao "Schindler's List" (1993)
  • Christopher Nolan je režirao "The Dark Knight" (2008)
  • Christopher Nolan je režirao "Inception" (2010)
```

### 2. **COUNTRIES (Zemlje)**
```
Kardinalnost: 1:N sa MOVIES
Opis: Jedna zemlja može proizvoditi više filmova
       Ali svaki film je proizveuden u jednoj zemlji

Veza: MOVIES.country_id → COUNTRIES.country_id

Primeri:
  • USA je proizvedla "The Shawshank Redemption" (1994)
  • USA je proizvedla "The Godfather" (1972)
  • Samo SAD filmovi u primeru
```

### 3. **GENRES (Žanrovi) - M:N veza**
```
Kardinalnost: M:N sa MOVIES (preko MOVIE_GENRE tabele)
Opis: Jedan film može imati više žanrova
      Jedan žanr može pripadati više filmova

Veza: MOVIES → MOVIE_GENRE ← GENRES

Primeri:
  • "Pulp Fiction" je: Crime, Drama
  • "The Silence of the Lambs" je: Crime, Thriller
  • "Drama" žanr ima filmove: "Shawshank Redemption", "Forrest Gump", itd.
```

### 4. **ACTORS (Glumci) - M:N veza**
```
Kardinalnost: M:N sa MOVIES (preko MOVIE_ACTOR tabele)
Opis: Jedan film može imati više glumaca
      Jedan glumac može biti u više filmova

Veza: MOVIES → MOVIE_ACTOR ← ACTORS

Primeri:
  • "The Shawshank Redemption" ima: Tim Robbins, Morgan Freeman, Bob Gunton
  • Tim Robbins je bio u više filmova
  • Morgan Freeman je bio u više filmova sa drugim glumcima
```

---

## NORMALIZACIJA - 3NF PROVERA

### Normalizovani oblik: Third Normal Form (3NF)

#### ✅ PRVA NORMALNA FORMA (1NF)
Svi atributi sadrže samo atomske (nedelive) vrednosti.

| Tabela | Provera |
|--------|---------|
| MOVIES | ✅ Sve vrednosti su pojedinačne (title, year, duration, itd.) |
| DIRECTORS | ✅ Svaka kolona sadrži samo jednu vrednost |
| GENRES | ✅ Nema multi-vrednosnih atributa |
| ACTORS | ✅ Nema listi ili skupova u jednoj ćeliji |
| MOVIE_GENRE | ✅ Kombinovani PK čini svaki red jedinstvenim |
| MOVIE_ACTOR | ✅ Kombinovani PK čini svaki red jedinstvenim |

**Zaključak**: ✅ Baza je u 1NF

---

#### ✅ DRUGA NORMALNA FORMA (2NF)
Nema parcijalne zavisnosti - svi non-key atributi u potpunosti zavise od celog PK.

| Tabela | Analiza |
|--------|---------|
| MOVIES | ✅ Svi atributi zavise od celog PK (movie_id) |
| DIRECTORS | ✅ first_name i last_name zavise od director_id |
| COUNTRIES | ✅ country_name i region zavise od country_id |
| GENRES | ✅ genre_name zavisi od genre_id |
| ACTORS | ✅ first_name, last_name zavise od actor_id |
| MOVIE_GENRE | ✅ Nema non-key atributa (samo PK se mapira) |
| MOVIE_ACTOR | ✅ role i billing_order zavise od kombinovanog PK |

**Zaključak**: ✅ Baza je u 2NF

---

#### ✅ TREĆA NORMALNA FORMA (3NF)
Nema tranzitivne zavisnosti - svi atributi direktno zavise od PK, ne od drugih atributa.

| Tabela | Analiza |
|--------|---------|
| MOVIES | ✅ title, year, duration, itd. direktno zavise od movie_id, ne od drugih |
| DIRECTORS | ✅ first_name i last_name direktno zavise od director_id |
| COUNTRIES | ✅ country_name direktno zavisi od country_id, ne od drugih atributa |
| GENRES | ✅ genre_name direktno zavisi od genre_id |
| ACTORS | ✅ first_name direktno zavisi od actor_id |

**Zaključak**: ✅ Baza je u 3NF

---

## PRIKAZ KLJUČEVA

### Primarni ključevi (Primary Keys - PK):
```
COUNTRIES:       country_id
DIRECTORS:       director_id
GENRES:          genre_id
ACTORS:          actor_id
MOVIES:          movie_id
MOVIE_GENRE:     (movie_id, genre_id) - kombinovani
MOVIE_ACTOR:     (movie_id, actor_id) - kombinovani
```

### Strani ključevi (Foreign Keys - FK):
```
MOVIES.director_id       → DIRECTORS.director_id       [1:N]
MOVIES.country_id        → COUNTRIES.country_id        [1:N]
MOVIE_GENRE.movie_id     → MOVIES.movie_id             [M:N]
MOVIE_GENRE.genre_id     → GENRES.genre_id             [M:N]
MOVIE_ACTOR.movie_id     → MOVIES.movie_id             [M:N]
MOVIE_ACTOR.actor_id     → ACTORS.actor_id             [M:N]
```

### UNIQUE ograničenja:
```
COUNTRIES.country_name   (nema duplikata)
GENRES.genre_name        (nema duplikata)
```

---

## TIPOVI PODATAKA - OPRAVDANJE

```
┌──────────────────────────────────────────────────────────┐
│                   TIPOVI PODATAKA                        │
├──────────────────┬──────────────────────────────────────┤
│ INT              │ Za ID-eve, године, trajanje, glasove │
│                  │ • movie_id, director_id, year        │
│                  │ • duration, imdb_votes              │
├──────────────────┼──────────────────────────────────────┤
│ VARCHAR(n)       │ Za tekstualne vrednosti              │
│                  │ • title VARCHAR(255) - naslov       │
│                  │ • genre_name VARCHAR(50) - žanr    │
│                  │ • first_name VARCHAR(100) - ime    │
├──────────────────┼──────────────────────────────────────┤
│ DECIMAL(15,2)    │ Za novčane vrednosti (budžet, prihod)│
│                  │ • Čuva tačnost do 2 decimale       │
│                  │ • Primer: $1,234,567.89            │
├──────────────────┼──────────────────────────────────────┤
│ DECIMAL(3,1)     │ Za ocene (0.0 do 10.0)             │
│                  │ • imdb_rating DECIMAL(3,1)        │
│                  │ • Dozvoljava: 0.0, 5.5, 9.3, 10.0 │
├──────────────────┼──────────────────────────────────────┤
│ TEXT             │ Za duže tekstualne vrednosti        │
│                  │ • synopsis - opis filma            │
│                  │ • biography - biografija            │
│                  │ • description - opis žanra        │
└──────────────────┴──────────────────────────────────────┘
```

---

## INDEKSI ZA PERFORMANSU

```sql
-- Indeksi kreirani za brže pretrage i spajanja:

INDEX idx_title           ON MOVIES(title)
INDEX idx_year            ON MOVIES(year)
INDEX idx_rating          ON MOVIES(imdb_rating)
INDEX idx_director        ON MOVIES(director_id)
INDEX idx_country         ON MOVIES(country_id)
INDEX idx_full_name       ON DIRECTORS(last_name, first_name)
INDEX idx_full_name       ON ACTORS(last_name, first_name)
INDEX idx_billing         ON MOVIE_ACTOR(billing_order)

-- Kombinovani indeksi za često korišćene kombinacije:
INDEX idx_title_year      ON MOVIES(title, year)
INDEX idx_rating_year     ON MOVIES(imdb_rating DESC, year DESC)
```

---

## INTEGRITET PODATAKA - CONSTRAINTS

```sql
-- CHECK constraints:
CHECK (year >= 1895 AND year <= YEAR(CURDATE()))
CHECK (duration > 0)
CHECK (imdb_rating >= 0 AND imdb_rating <= 10)
CHECK (imdb_votes >= 0)
CHECK (budget >= 0)
CHECK (box_office >= 0)
CHECK (birth_year >= 1800 AND birth_year <= YEAR(CURDATE()))

-- UNIQUE constraints:
UNIQUE (country_name)
UNIQUE (genre_name)

-- FOREIGN KEY constraints sa akcijama:
ON DELETE RESTRICT      - Sprečava brisanje redažisera ako ima filmova
ON UPDATE CASCADE       - Automatski ažurira ID-eve ako se promene
ON DELETE CASCADE       - Briše filmove ako se obriše žanr ili glumac
```

---

## PRIMENA U PRAKSI

Ovaj model omogućava:
- ✅ Pretragu filmova po različitim kriterijumima
- ✅ Analizu podataka o filmima i redažiserima
- ✅ Upravljanje kompleksnim vezama između entiteta
- ✅ Bez nepotrebnih duplikaranja podataka
- ✅ Brze upite zahvaljujući indeksima
- ✅ Integritet podataka kroz ograničenja

---
