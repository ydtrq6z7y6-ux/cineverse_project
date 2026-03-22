# 🎯 CINEVERSE - KONAČAN PREGLED

## ✅ ŠTA JE KREIRANO

Kompletan paket od **10 fajlova** sa profesionalnom dokumentacijom:

```
📁 Baza_Podataka_Analiza/
│
├── 📌 README.md                              [INDEX FILE - POČNI OVDE]
├── ⚡ BRZI_PREGLED.md                       [SAŽETAK - 5 MIN ČITANJA]
│
├── 📚 DOKUMENTACIJA
│   ├── 01_ANALIZA_BAZE_PODATAKA.md          [TEMELJNA ANALIZA]
│   ├── 06_DETALJNI_ER_DIJAGRAM.md           [VIZUELNI PRIKAZ]
│   ├── 07_DETALJNA_SPECIFIKACIJA_TABELA.md  [SPECIFIKACIJE PO TABELI]
│   └── UPUTSTVO_KORAK_PO_KORAK.md           [TUTORIAL]
│
├── 🎨 DIJAGRMI (Mermaid Format)
│   ├── 02_KONCEPTUALNI_MODEL.mmd            [ER Dijagram - Konceptualni]
│   └── 03_LOGICKI_MODEL.mmd                 [Logički Model - Sa Tipovima]
│
└── 💻 SQL SKRIPTE
    ├── 04_SQL_DDL_SKRIPTE.sql               [KREIRAJ BAZU]
    └── 05_PRIMERI_UPITA.sql                 [TEST UPITI]
```

---

## 🎯 BRZI PRISTUP

**Ako trebaš samo dijagrame:**
```
1. Otvori: 02_KONCEPTUALNI_MODEL.mmd
2. Kopija kod u: https://mermaid.live/
3. Download PNG/PDF ✅
```

**Ako trebaš bazu:**
```
1. Kopiraj sadržaj iz: 04_SQL_DDL_SKRIPTE.sql
2. Pokreni u MySQL 
3. Baza je sada kreiraea ✅
```

**Ako trebaš razumeti sve:**
```
1. Pročitaj: README.md (5 min)
2. Pogledaj: BRZI_PREGLED.md (5 min)
3. Detaljno: 01_ANALIZA_BAZE_PODATAKA.md (15 min)
4. Detaljno: 07_DETALJNA_SPECIFIKACIJA_TABELA.md (15 min)
```

---

## 📊 STRUKTURA BAZE - VIZUELNO

```
KONCEPTUALNI MODEL:
─────────────────

          ┌─────────────┐
          │ COUNTRIES   │ ← Reference tabela
          └──────┬──────┘
                 │ 1:N
         ┌───────┴───────────────────────┐
         │                               │
    ┌────┴─────┐            ┌───────────┴────────┐
    │DIRECTORS │            │      MOVIES       │ ← GLAVNA TABELA
    │ 1:N      │            │ (Title, Year,     │
    └──────────┘            │  Duration, etc.)  │
                            └─────────┬─────────┘
                                      │
                    ┌─────────────────┼─────────────────┐
                    │                 │                 │
              ┌─────┴────────┐  ┌────┴─────────┐       │
              │ M:N Veza     │  │ M:N Veza      │       │
              │ MOVIE_GENRE  │  │ MOVIE_ACTOR   │       │
              └──────┬───────┘  └────┬──────────┘       │
                     │               │                 │
              ┌──────┴─────┐   ┌─────┴────────┐        │
              │   GENRES   │   │    ACTORS    │        │
              │(Drama,     │   │(Tim Robbins, │        │
              │Action,...) │   │Morgan Freeman)        │
              └────────────┘   └────────────────       │
```

---

## 🔑 7 TABELA - DETALJAN PREGLED

### 1. **COUNTRIES** 🌍
- **PK**: country_id
- **Kolone**: country_name, region
- **Uloga**: Reference za zemlje
- **Veza**: 1:N sa MOVIES

### 2. **DIRECTORS** 🎬
- **PK**: director_id  
- **Kolone**: first_name, last_name, birth_year, country_of_origin
- **Uloga**: Informacije o redažiserima
- **Veza**: 1:N sa MOVIES

### 3. **GENRES** 🎭
- **PK**: genre_id
- **Kolone**: genre_name, description
- **Uloga**: Reference za žanrove
- **Veza**: M:N sa MOVIES (preko MOVIE_GENRE)

### 4. **ACTORS** 👥
- **PK**: actor_id
- **Kolone**: first_name, last_name, birth_year, country_of_birth
- **Uloga**: Informacije o glumcima
- **Veza**: M:N sa MOVIES (preko MOVIE_ACTOR)

### 5. **MOVIES** 🎥 [GLAVNA]
- **PK**: movie_id
- **FK**: director_id, country_id
- **Kolone**: title, year, duration, imdb_rating, imdb_votes, budget, box_office
- **Uloga**: Centralna tabela 
- **Veza**: Spaja sve entitete

### 6. **MOVIE_GENRE** 🔗
- **PK**: (movie_id, genre_id) - kombinovani
- **FK**: oba su strani ključevi
- **Uloga**: Mapira M:N između MOVIES i GENRES
- **Primer**: Film "Pulp Fiction" → Crime, Drama

### 7. **MOVIE_ACTOR** 🔗
- **PK**: (movie_id, actor_id) - kombinovani
- **Kolone**: role, billing_order
- **FK**: oba su strani ključevi
- **Uloga**: Mapira M:N između MOVIES i ACTORS
- **Primer**: Film "Shawshank" → Tim Robbins (Andy), Morgan Freeman (Red)

---

## 📋 TIPOVI RELACIJA - OBJAŠNJENJE

### 1:N (Jedan prema Više)
**DIRECTORS → MOVIES**
```
Jedan redažiser može režirati VIŠE filmova
Ali svaki film ima SAMO JEDNOG redažisera

Primer:
Christopher Nolan je režirao:
  • The Dark Knight (2008)
  • Inception (2010)
  • Interstellar (2014)
  [i više filmova]
```

### M:N (Više prema Više)
**MOVIES ↔ GENRES** (preko MOVIE_GENRE)
```
Jedan film može imati VIŠE žanrova
Jedan žanr može biti u VIŠE filmova

Primer:
Pulp Fiction je:
  • Crime (žanr)
  • Drama (žanr)
  • Thriller (žanr)

Drama žanr ima:
  • The Shawshank Redemption
  • Pulp Fiction
  • Forrest Gump
  [i više filmova]
```

---

## 📊 NORMALIZACIJA - 3NF PROVERA

### ✅ 1NF (Atomske Vrednosti)
```
❌ LOŠE: Film sa više žanrova u jednoj ćeliji
   title="Pulp Fiction" | genres="Crime, Drama, Thriller"

✅ DOBRO: Odvojeni redovi za svaki žanr
   movie_id=4, genre_id=4  [Crime]
   movie_id=4, genre_id=1  [Drama]
   movie_id=4, genre_id=5  [Thriller]
```

### ✅ 2NF (Nema Parcijalne Zavisnosti)
```
✅ DOBRO: 
   - DIRECTORS ima director_id kao PK
   - first_name zavisi od director_id (celog PK)
   - last_name zavisi od director_id (celog PK)
   - Nema parcijalne zavisnosti
```

### ✅ 3NF (Nema Tranzitivne Zavisnosti)
```
❌ LOŠE:
   MOVIES → { title, year, director_name, country }
   director_name → director_country (tranzitivna!)

✅ DOBRO:
   MOVIES → { title, year, director_id, country_id }
   DIRECTORS → { director_id, director_name, ... }
   COUNTRIES → { country_id, country_name, ... }
```

---

## 💡 PRIMERI UPITA - MOGU ODGOVORITI NA

### Jednostavni Upiti
- "Svi filmovi iz 2010 godline"
- "Top 10 najbolje ocenjenih filmova"
- "Koliko filmova ima iz svake godine?"

### Kompleksni JOINS
- "Svi filmovi redažisera Christopher Nolan"
- "Filmovi sa žanrom Drama iz USA"
- "Glumci koji su radili sa Tim Robbins"

### Analitički Upiti
- "Prosečna ocena po godini"
- "Redažiseri sa najvećim brojem filmova"
- "Najčešće kombinacije žanrova"

---

## 🛠️ KORIŠĆENJE SQL DDL SKRIPTE

### MySQL Terminal
```bash
mysql -u korisnik -p < 04_SQL_DDL_SKRIPTE.sql
```

### MySQL Workbench
```
File → Open SQL Script → 04_SQL_DDL_SKRIPTE.sql
Execute (Ctrl+Enter)
```

### PHPMyAdmin
```
New → SQL → Paste 04_SQL_DDL_SKRIPTE.sql 
Execute → Done!
```

---

## 🎨 GENERISANJE DIJAGRAMA

### Mermaid Live (Preporučeno)
```
1. https://mermaid.live/
2. Copy → 02_KONCEPTUALNI_MODEL.mmd
3. 📸 Copy Image / Download PNG / Convert to PDF
```

### Alternative
- Draw.io (https://app.diagrams.net/)
- Lucidchart (https://www.lucidchart.com/)
- MySQL Workbench (Reverse Engineer iz baze)

---

## 📦 ZA PREDAJU - FAJLOVI ZA ZIPEOVANJE

```
Tinarako_Task2.zip
├── konceptualni_model.png
├── konceptualni_model.pdf
├── logicki_model.png  
├── logicki_model.pdf
├── database_specifications.pdf
├── 01_ANALIZA_BAZE_PODATAKA.md
├── 04_SQL_DDL_SKRIPTE.sql
├── 05_PRIMERI_UPITA.sql
├── README.txt  [Uputstva]
└── [Sve ostalo što je u Baza_Podataka_Analiza/ foldera]
```

---

## ✨ PREDNOSTI OVOG MODELA

| Karakteristika | Korišćenje |
|---|---|
| **Normalizovana** | Bez redundancije podataka |
| **Sa Indeksima** | Brze pretrage |
| **Sa FK** | Referentni integritet |
| **Sa CHECK** | Validnost podataka |
| **Skalabilna** | Lako dodaj nove podatke |
| **Fleksibilna** | M:N relacije omogućavaju dodatne kombinacije |
| **Dokumentovana** | 10 fajlova sa detaljima |

---

## 🎓 UČENJE

Kroz ovaj model si naučio:

```
✅ Analiza podataka         → Kako iz CSV-a doći do entiteta
✅ ER Modeliranje          → Kako crtati relacije  
✅ SQL DDL                 → Kako pisati CREATE TABLE
✅ Normalizacija           → 1NF, 2NF, 3NF principi
✅ FK & Constraints        → Kako čuvati integritet
✅ SQL Upiti               → JOINS, GROUP BY, agregacije
✅ Indeksiranje            → Optimizacija performansi
✅ Baze Podataka Napred    → Kompletan proces
```

---

## 🚀 SLEDEĆI KORACI

1. **Pročitaj README.md** za uvod
2. **Pogledaj dijagrame** na mermaid.live
3. **Kreiraj bazu** sa SQL skriptama
4. **Testiraj upite** sa primerima
5. **Spakovaj sve** za predaju
6. **Predaj zadatak** 🎉

---

**Svi zadaci su završeni. Dokumentacija je kompletna i profesionalna.**

**Spreman za predaju! ✅**

---
