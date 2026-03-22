# 📊 CINEVERSE - ANALIZA I MODELIRANJE BAZE PODATAKA

## 🎯 Pregled Projekta

Ovaj direktorijum sadrži kompletnu analizu, konceptualni i logički model baze podataka za **Cineverse** - sistem za upravljanje filmskim podacima.

---

## 📁 Struktura Direktorijuma

```
Baza_Podataka_Analiza/
├── README.md                              ← Ovaj fajl
├── 01_ANALIZA_BAZE_PODATAKA.md           ✅ Detaljne analize i opis modela
├── 02_KONCEPTUALNI_MODEL.mmd             ✅ ER dijagram (Mermaid format)
├── 03_LOGICKI_MODEL.mmd                  ✅ Logički model sa tipovima (Mermaid)
├── 04_SQL_DDL_SKRIPTE.sql                ✅ SQL za kreiranje baze
├── 05_PRIMERI_UPITA.sql                  ✅ Primeri SQL upita
├── 06_DETALJNI_ER_DIJAGRAM.md            ✅ Grafički ER dijagram sa detaljima
└── 07_DETALJNA_SPECIFIKACIJA_TABELA.md   ✅ Detaljne specifikacije svake tabele
```

---

## 📚 Sadržaj Fajlova

### 1️⃣ **01_ANALIZA_BAZE_PODATAKA.md**
- 📝 Uvod u zadatak i ciljeve
- 📊 Analiza izvora podataka (CSV fajlovi)
- 🔍 Identifikovani entiteti
- 🔗 Definisane relacije među entitetima
- ✅ Provera normalizacije (1NF, 2NF, 3NF)
- 💡 Primeri SQL upita
- 🎯 Zaključak

**Korišćenje**: Pročitaj prvo za uvod i razumevanje modela

---

### 2️⃣ **02_KONCEPTUALNI_MODEL.mmd**
- 🎨 ER dijagram u Mermaid formatu (konceptualni nivo)
- 📌 Entiteti i njihovi atributi
- 🔄 Relacije između entiteta
- 📊 Kardinalnosti (1:N, M:N)

**Korišćenje**: 
1. Poseti https://mermaid.live/
2. Kopiraj sadržaj fajla u editor
3. Preuzmi kao PNG, SVG ili PDF

---

### 3️⃣ **03_LOGICKI_MODEL.mmd**
- 🏗️ Detaljni logički model sa tipovima podataka
- 🔑 Primarni i strani ključevi
- 📋 Sve tabele sa kolonama
- 🔗 Detaljne relacije

**Korišćenje**: 
1. Poseti https://mermaid.live/
2. Kopiraj sadržaj fajla u editor
3. Preuzmi kao PNG, SVG ili PDF

---

### 4️⃣ **04_SQL_DDL_SKRIPTE.sql**
- 📋 CREATE DATABASE iskaz
- 🏢 CREATE TABLE iskazi za sve tabele
- 🔑 Primarne i strani ključevi
- ⚠️ CHECK ograničenja
- 📇 Indeksi za performansu

**Korišćenje**: 
```bash
# Učitaj u MySQL:
mysql -u korisnik -p < 04_SQL_DDL_SKRIPTE.sql

# Ili iskaz po iskaz u MySQL Workbenchu
```

---

### 5️⃣ **05_PRIMERI_UPITA.sql**
- 🔍 9 grupa sa primere SQL upita
- 📊 Od osnovnih do kompleksnih upita
- 💰 Analitički upiti
- 🔎 Pretrage i tekstualni upiti

**Korišćenje**: Otvori u SQL klijent i isprobaj različite upite

---

### 6️⃣ **06_DETALJNI_ER_DIJAGRAM.md**
- 📐 ASCII Art ER dijagram
- 🔄 Detaljne relacije sa primerima
- ✅ 3NF normalizacijska provera
- 🔑 Detaljne informacije o ključevima
- 📋 Tipovi podataka sa objašnjenjima
- 📇 Indeksi i performansa
- ⚠️ Ograničenja integrnosti

**Korišćenje**: Referentni dokument za detaljne informacije

---

### 7️⃣ **07_DETALJNA_SPECIFIKACIJA_TABELA.md**
- 📑 Specifikacija svake tabele
- 📋 Tabelarni pregled kolona
- 💾 Primeri podataka za svaku tabelu
- 🔧 SQL INSERT iskazi
- 💡 Mogući upiti za svaku tabelu

**Korišćenje**: Detaljni pregled kako se svaka tabela koristi

---

## 🛠️ KAK KORISTITI FAJLOVE

### Za Razumevanje Modela:
1. Pročitaj [`01_ANALIZA_BAZE_PODATAKA.md`](01_ANALIZA_BAZE_PODATAKA.md)
2. Pogledaj [`06_DETALJNI_ER_DIJAGRAM.md`](06_DETALJNI_ER_DIJAGRAM.md) za vizuelni prikaz
3. Detaljno prouči [`07_DETALJNA_SPECIFIKACIJA_TABELA.md`](07_DETALJNA_SPECIFIKACIJA_TABELA.md)

### Za Pravljenje Diagramima:
1. Kopija sadržaj iz [`02_KONCEPTUALNI_MODEL.mmd`](02_KONCEPTUALNI_MODEL.mmd)
2. Poseti https://mermaid.live/
3. Zalepi kod i preuzmi kao PNG/SVG
4. Ponoviti za [`03_LOGICKI_MODEL.mmd`](03_LOGICKI_MODEL.mmd)

### Za Kreiranje Baze Podataka:
1. Otvori [`04_SQL_DDL_SKRIPTE.sql`](04_SQL_DDL_SKRIPTE.sql)
2. Otvori MySQL/MariaDB klijent
3. Dodaj primere podataka iz [`07_DETALJNA_SPECIFIKACIJA_TABELA.md`](07_DETALJNA_SPECIFIKACIJA_TABELA.md)

### Za Testiranje Upita:
1. Kreiraj bazu sa [`04_SQL_DDL_SKRIPTE.sql`](04_SQL_DDL_SKRIPTE.sql)
2. Dodaj test podatke
3. Kopira upite iz [`05_PRIMERI_UPITA.sql`](05_PRIMERI_UPITA.sql)
4. Isprobaj u SQL klijent

---

## 📊 Identifikovani Entiteti

| Entitet | Opis | Relacija |
|---------|------|----------|
| **COUNTRIES** | Zemlje podenkla | 1:N sa MOVIES |
| **DIRECTORS** | Redažiseri | 1:N sa MOVIES |
| **GENRES** | Žanrovi | M:N sa MOVIES |
| **ACTORS** | Glumci | M:N sa MOVIES |
| **MOVIES** | Filmovi (glavna tabela) | - |
| **MOVIE_GENRE** | Povezujuća (M:N) | - |
| **MOVIE_ACTOR** | Povezujuća (M:N) | - |

---

## 🔑 Tipovi Relacija

```
┌─────────────────────────────────────────────────┐
│           TIPOVI RELACIJA (Kardinalnosti)       │
├─────────────────────────────────────────────────┤
│ 1:N  → Jedan režiser → Više filmova             │
│ 1:N  → Jedna zemlja → Više filmova              │
│ M:N  → Više filmova ↔ Više žanrova              │
│ M:N  → Više filmova ↔ Više glumaca              │
└─────────────────────────────────────────────────┘
```

---

## ✨ Karakteristike Modela

✅ **3NF Normalizovana** - Bez duplikoranog i redudantnnih podataka  
✅ **Referentni Integritet** - Strani ključevi sprečavaju nekonzistentnost  
✅ **Optimizovani Indeksi** - Brze pretrage i spajanja  
✅ **Ograničenja Validnosti** - CHECK constraints za integritet  
✅ **Fleksibilna Struktura** - Lako se dodaju novi filmovi, glumci, žanrovi  
✅ **Skalabilna** - Može primiti milione filmova bez problema  

---

## 💾 Tipovi Podataka Korišćeni

| Tip | Korišćenje | Primeri |
|-----|-----------|---------|
| INT | ID-evi, brojevi, godine | movie_id, year, duration |
| VARCHAR(n) | Tekst sa fiksnom dužinom | title, name, country |
| DECIMAL(15,2) | Novčane vrednosti | budget, box_office |
| DECIMAL(3,1) | Ocene 0.0-10.0 | imdb_rating |
| TEXT | Dugi tekstualni sadržaj | synopsis, biography |
| TIMESTAMP | Vremenske oznake | created_at, updated_at |

---

## 🔍 Primeri Upita

### Pronađi sve filmove redažisera:
```sql
SELECT m.title, m.year
FROM MOVIES m
INNER JOIN DIRECTORS d ON m.director_id = d.director_id
WHERE d.last_name = 'Nolan';
```

### Pronađi filmove sa određenim žanrom:
```sql
SELECT m.title, m.imdb_rating
FROM MOVIES m
INNER JOIN MOVIE_GENRE mg ON m.movie_id = mg.movie_id
INNER JOIN GENRES g ON mg.genre_id = g.genre_id
WHERE g.genre_name = 'Drama'
ORDER BY m.imdb_rating DESC;
```

### Analiza po godinama:
```sql
SELECT year, COUNT(*) as broj_filmova, AVG(imdb_rating) as prosečna_ocena
FROM MOVIES
GROUP BY year
ORDER BY year DESC;
```

---

## 📋 Normalizacijska Provera

### ✅ First Normal Form (1NF)
- Sve vrednosti su atomske
- Nema repeating groups
- Nema multi-vrednosnih atributa

### ✅ Second Normal Form (2NF)  
- U 1NF
- Nema parcijalne zavisnosti
- M:N relacije rešene kroz connecting tabele

### ✅ Third Normal Form (3NF)
- U 2NF
- Nema tranzitivne zavisnosti
- Svaki atribut zavisi direktno od PK

---

## 📡 Kako Proveriti Model sa MySQL Workbenchu

1. **Instalacija**: Preuzmi MySQL Workbench sa mysql.com
2. **Kreiraj novu konekciju** na MySQL server
3. **File → Open SQL Script** i otvori `04_SQL_DDL_SKRIPTE.sql`
4. **Execute** (Ctrl+Enter) da kreirate bazu
5. **Dodaj test podatke** iz `07_DETALJNA_SPECIFIKACIJA_TABELA.md`
6. **Database → Reverse Engineer** da generiše "ER Diagram iz baze
7. **Testiraj upite** iz `05_PRIMERI_UPITA.sql`

---

## 🎓 Kratak Tutorial za Dijagrame

### Korišćenje Mermaid.live za Diagramme:

1. **Otidaj na https://mermaid.live/**

2. **Kopija sadržaj iz** `02_KONCEPTUALNI_MODEL.mmd`:
   ```
   erDiagram
       MOVIES ||--|| DIRECTORS : "directed_by"
       ...
   ```

3. **Levo vidis dijagram automatski**

4. **Preuzmi kao PNG:**
   - Klikni ikona camera (📸)
   - Odaberi format: PNG, SVG, ili PDF
   - Klikni Download

5. **IzvezI kao SVG** za bolja kvalitete

---

## 📞 Kontakt i Q&A

**Česte Greške:**
- ❌ Duplikorani podaci - Koristi normalizaciju
- ❌ Zaobijeni upiti - Koristi indekse
- ❌ Neispravan integritet - Koristi FK sa CHECK constraints

**Preporuke:**
- Koristi VARCHAR za fleksibilnost
- DECIMAL za novčane vrednosti (nikada FLOAT/DOUBLE)
- Kreiraj indekse na foreign keys  
- Koristi TIMESTAMP za audit trail

---

## 🎯 Zaključak

Ovaj model baze podataka omogućava:
- 📊 Strukturisano skladištenje filmskih podataka
- 🔍 Brze pretrage i analize
- 🔄 Fleksibilne relacije između entiteta
- 💪 Skalabilnost za velike količine podataka
- ⚖️ Integritet i konzistentnost podataka

---

**Verzija**: 1.0  
**Kreirano**: 22 Mart 2026  
**Format**: UTF-8

---
