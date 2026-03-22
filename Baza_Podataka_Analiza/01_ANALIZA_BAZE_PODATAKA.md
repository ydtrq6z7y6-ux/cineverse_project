# CINEVERSE - Analiza i Modeliranje Baze Podataka

## 1. UVOD

Cilj ovog zadatka je kreiranje konceptualnog i logičkog modela baze podataka za skladištenje informacija o filmovima, redažiserima, glumcima, žanrovima i zemljama porekla.

### Kontrolni pregled zahteva:
- ✅ Prepoznavanje ključnih entiteta  
- ✅ Definisanje relacija među entitetima  
- ✅ Kreiranje konceptualnog modela (ER dijagram)  
- ✅ Razrada logičkog modela sa tipovima podataka  
- ✅ Normalizacija baze podataka  

---

## 2. ANALIZA IZVORA PODATAKA

### Dostupni CSV fajlovi:
- `movies.csv` - osnovni podaci (Title, Year, Genre, Director, Country, Duration)  
- `movies_extended.csv` - prošireni podaci (+ IMDb Rating, Main Actors, IMDb Votes)

### Identifikovani atributi iz podataka:
1. **Naslov filma** → VARCHAR  
2. **Godina izdanja** → INT  
3. **Žanr** → VARCHAR (može biti više žanrova)  
4. **Režiser** → VARCHAR  
5. **Zemlja porekla** → VARCHAR  
6. **Trajanje** → INT (minuti)  
7. **IMDb ocena** → DECIMAL  
8. **Glavne uloge (glumci)** → VARCHAR (može biti više glumaca)  
9. **IMDb glasovi** → INT  

---

## 3. IDENTIFIKOVANI ENTITETI

### 3.1 MOVIES (Filmovi)
**Opis:** Osnovni entitet koji sadrži informacije o filmovima.

| Atribut | Tip | Opis | Ključ |
|---------|-----|------|-------|
| movie_id | INT | Jedinstveni identifikator filma | **PK** |
| title | VARCHAR(255) | Naslov filma | - |
| year | INT | Godina izdanja | - |
| duration | INT | Trajanje u minutama | - |
| imdb_rating | DECIMAL(3,1) | Ocena na IMDb-u (0-10) | - |
| imdb_votes | INT | Broj glasova na IMDb-u | - |
| director_id | INT | Referenca na režisera | **FK** |
| country_id | INT | Referenca na zemlju porekla | **FK** |

---

### 3.2 DIRECTORS (Režiseri)
**Opis:** Tabela koja skladišti informacije o redažiserima filmova.

| Atribut | Tip | Opis | Ključ |
|---------|-----|------|-------|
| director_id | INT | Jedinstveni identifikator | **PK** |
| first_name | VARCHAR(100) | Ime режисера | - |
| last_name | VARCHAR(100) | Prezime režisera | - |
| country_of_origin | VARCHAR(100) | Zemlja porekla režisera | - |
| birth_year | INT | Godina rođenja (opciono) | - |

**Kardinalnost:** 1:N sa MOVIES (Jedan režiser može režirati više filmova)

---

### 3.3 COUNTRIES (Zemlje)
**Opis:** Referentna tabela sa podacima o zemljama.

| Atribut | Tip | Opis | Ključ |
|---------|-----|------|-------|
| country_id | INT | Jedinstveni identifikator | **PK** |
| country_name | VARCHAR(100) | Naziv zemlje | UNIQUE |
| region | VARCHAR(100) | Regija (Evropa, Azija, itd.) | - |

**Kardinalnost:** 1:N sa MOVIES (Jedna zemlja proizvede više filmova)

---

### 3.4 GENRES (Žanrovi)
**Opis:** Referentna tabela sa filmskim žanrovima.

| Atribut | Tip | Opis | Ključ |
|---------|-----|------|-------|
| genre_id | INT | Jedinstveni identifikator | **PK** |
| genre_name | VARCHAR(50) | Naziv žanra | UNIQUE |
| description | VARCHAR(255) | Opis žanra | - |

**Kardinalnost:** M:N sa MOVIES, preko tabele MOVIE_GENRE

---

### 3.5 ACTORS (Glumci)
**Opis:** Tabela sa informacijama o glumcima.

| Atribut | Tip | Opis | Ključ |
|---------|-----|------|-------|
| actor_id | INT | Jedinstveni identifikator | **PK** |
| first_name | VARCHAR(100) | Ime glumca | - |
| last_name | VARCHAR(100) | Prezime glumca | - |
| country_of_birth | VARCHAR(100) | Zemlja rođenja | - |
| birth_year | INT | Godina rođenja (opciono) | - |

**Kardinalnost:** M:N sa MOVIES, preko tabele MOVIE_ACTOR

---

### 3.6 MOVIE_GENRE (Povezujuća tabela)
**Opis:** Tabela koja mapira M:N relaciju između filmova i žanrova.

| Atribut | Tip | Opis | Ključ |
|---------|-----|------|-------|
| movie_id | INT | Referenca na film | **PK, FK** |
| genre_id | INT | Referenca na žanr | **PK, FK** |

**Primer:** Film "Pulp Fiction" ima žanrove: Crime, Drama, Thriller

---

### 3.7 MOVIE_ACTOR (Povezujuća tabela)
**Opis:** Tabela koja mapira M:N relaciju između filmova i glumaca.

| Atribut | Tip | Opis | Ključ |
|---------|-----|------|-------|
| movie_id | INT | Referenca na film | **PK, FK** |
| actor_id | INT | Referenca na glumca | **PK, FK** |
| role | VARCHAR(100) | Uloga glumca (opciono) | - |

**Primer:** Film sadrži flera glumaca u glavnim ulogama

---

## 4. RELACIJE IZMEĐU ENTITETA

### 4.1 MOVIES → DIRECTORS (1:N)
```
Jedan režiser može režirati više filmova
Jedan film ima tačno jednog režisera
Veza: MOVIES.director_id → DIRECTORS.director_id
```

### 4.2 MOVIES → COUNTRIES (1:N)
```
Jedna zemlja može proizvoditi više filmova
Jedan film je proizveден u jednoj zemlji
Veza: MOVIES.country_id → COUNTRIES.country_id
```

### 4.3 MOVIES ↔ GENRES (M:N)
```
Jedan film može imati više žanrova
Jedan žanr može imati više filmova
Veza: MOVIES → MOVIE_GENRE ← GENRES
```

### 4.4 MOVIES ↔ ACTORS (M:N)
```
Jedan film može imati više glumaca
Jedan glumac može biti u više filmova
Veza: MOVIES → MOVIE_ACTOR ← ACTORS
```

---

## 5. KONCEPTUALNI MODEL

Konceptualni model prikazuje entitete i relacije bez specifičnih detalja o implementaciji.

**Dijagram ce biti sačuvan kao: `02_KONCEPTUALNI_MODEL.png`**

---

## 6. LOGIČKI MODEL

Logički model implementira konceptualni model sa:
- Specifičnim tipovima podataka
- Primarnim ključevima (PK)
- Stranim ključevima (FK)
- Ograničenjima (CONSTRAINTS)

**Dijagram ce biti sačuvan kao: `03_LOGICKI_MODEL.png`**

---

## 7. NORMALIZACIJA

### Normalizovani oblik: **3NF (Third Normal Form)**

#### Provera 1NF (First Normal Form):
- ✅ Sve vrednosti su atomske (ne-složene)  
- ✅ Nema ponavljajućih grupa atributa  

#### Provera 2NF (Second Normal Form):
- ✅ U 1NF
- ✅ Nema parcijalne zavisnosti (svi NonKey atributi u potpunosti zavise od PK)  
- ✅ M:N relacije rešene kroz povezujuće tabele  

#### Provera 3NF (Third Normal Form):
- ✅ U 2NF
- ✅ Nema tranzitivne zavisnosti  
- ✅ Svaki atribut direktno zavisi od PK  

---

## 8. PRIMERI UPITA

### Primer 1: Pronađi sve filmove režisera "Christopher Nolan"
```sql
SELECT m.title, m.year, m.imdb_rating
FROM MOVIES m
INNER JOIN DIRECTORS d ON m.director_id = d.director_id
WHERE d.first_name = 'Christopher' AND d.last_name = 'Nolan'
ORDER BY m.year DESC;
```

### Primer 2: Pronađi filmove sa više žanrova
```sql
SELECT m.title, COUNT(g.genre_id) as broj_zanrova
FROM MOVIES m
LEFT JOIN MOVIE_GENRE mg ON m.movie_id = mg.movie_id
LEFT JOIN GENRES g ON mg.genre_id = g.genre_id
GROUP BY m.movie_id
HAVING COUNT(g.genre_id) > 1;
```

### Primer 3: Pronađi glumce koji su igrali sa određenim glumcem
```sql
SELECT DISTINCT a2.first_name, a2.last_name
FROM MOVIE_ACTOR ma1
INNER JOIN MOVIES m ON ma1.movie_id = m.movie_id
INNER JOIN MOVIE_ACTOR ma2 ON m.movie_id = ma2.movie_id
INNER JOIN ACTORS a1 ON ma1.actor_id = a1.actor_id
INNER JOIN ACTORS a2 ON ma2.actor_id = a2.actor_id
WHERE a1.first_name = 'Tim' AND a1.last_name = 'Robbins'
AND a2.actor_id != a1.actor_id;
```

---

## 9. ZAKLJUČAK

Ovaj model baze podataka omogućava:

✅ **Fleksibilnost** - jednostavno dodavanje novih žanrova i glumaca  
✅ **Normalizaciju** - izbegavanje duplikaranja podataka  
✅ **Integritet podataka** - kroz strane ključeve i ograničenja  
✅ **Skalabilnost** - možnost dodavanja novih filmova, režisera i glumaca bez problema  
✅ **Performanse** - optimizovana struktura za upite  

---

## Datoteke u proprezentaciji:

1. **01_ANALIZA_BAZE_PODATAKA.md** - Ovaj dokument  
2. **02_KONCEPTUALNI_MODEL.mmd** - Mermaid ER dijagram  
3. **03_LOGICKI_MODEL.mmd** - Detaljni logički model  
4. **04_SQL_DDL_SKRIPTE.sql** - SQL DDL iskazi za kreiranje baze  
5. **05_PRIMERI_UPITA.sql** - Primeri SQL upita  

---
