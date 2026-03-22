# ⚡ BRZI PREGLED - SAŽETAK

## 📋 Šta je Kreirano?

```
✅ 9 FAJLOVA SA KOMPLETNOM DOKUMENTACIJOM
✅ ER DIJAGRAM (Konceptualni i Logički)
✅ SQL DDL SKRIPTE 
✅ PRIMERI UPITA
✅ DETALJNE SPECIFIKACIJE
```

---

## 🎯 IDENTIFIKOVANI ENTITETI

| # | Entitet | Opis | Relacija |
|---|---------|------|----------|
| 1 | **COUNTRIES** | Zemlje porekla | 1:N → MOVIES |
| 2 | **DIRECTORS** | Redažiseri | 1:N → MOVIES |
| 3 | **GENRES** | Filmski žanrovi | M:N ↔ MOVIES |
| 4 | **ACTORS** | Glumci | M:N ↔ MOVIES |
| 5 | **MOVIES** | Glavni filmovi | Spaja sve |
| 6 | **MOVIE_GENRE** | Povezujuća M:N | MOVIES ↔ GENRES |
| 7 | **MOVIE_ACTOR** | Povezujuća M:N | MOVIES ↔ ACTORS |

---

## 📊 DIJAGRAM STRUKTURE

```
                     ┌───────────────┐
                     │  COUNTRIES    │
                     │  1:N sa       │
                     │  MOVIES       │
                     └───────┬───────┘
                             │
                     ┌───────├─────┐
                     │             │
              ┌──────┴────┐  ┌─────┴─────┐
              │ DIRECTORS │  │  MOVIES   │
              │ 1:N sa    │  │  (Main)   │
              │ MOVIES    │  │           │
              └───────────┘  └─────┬─────┘
                                  │
                  ┌───────────────┼───────────────┐
                  │               │               │
          ┌───────┴────┐  ┌──────┴────┐  ┌──────┴────┐
          │ M:N M.GENRE│  │ M:N M.ACTOR│  │           │
          │  ↓ GENRES  │  │  ↓ ACTORS  │  │ (Foreign  │
          │            │  │            │  │  Keys: FK)│
          └────────────┘  └────────────┘  └───────────┘
```

---

## 🔑 KLJUČNE KARAKTERISTIKE

### Tipovi Podataka
- **INT** - za brojeve, ID-eve
- **VARCHAR(n)** - za tekstualne vrednosti
- **DECIMAL(15,2)** - za novčane vrednosti
- **DECIMAL(3,1)** - za ocene (0.0-10.0)
- **TEXT** - za duge tekstove

### Ključevi
- **PK** (Primary Key) - Jedinstveni identifikator
- **FK** (Foreign Key) - Referenca na drugu tabelu
- **UNIQUE** - Nema duplikata

### Relacije
- **1:N** - Jedan → Više
- **M:N** - Više → Više (preko connecting tabele)

### Normalizacija
- ✅ **1NF** - Atomske vrednosti
- ✅ **2NF** - Nema parcijalne zavisnosti
- ✅ **3NF** - Nema tranzitivne zavisnosti

---

## 📁 FAJLOVI - BRZI PREGLED

| # | Fajl | Formata | Korišćenje | ⏱️ Čitanja |
|---|------|---------|-----------|----------|
| 1 | `01_ANALIZA_BAZE_PODATAKA.md` | 📝 Markdown | Razumevanje modela | 10 min |
| 2 | `02_KONCEPTUALNI_MODEL.mmd` | 🎨 Mermaid | ER dijagram | 2 min |
| 3 | `03_LOGICKI_MODEL.mmd` | 🎨 Mermaid | Tipovi podataka | 2 min |
| 4 | `04_SQL_DDL_SKRIPTE.sql` | 💻 SQL | Kreiranje baze | 5 min |
| 5 | `05_PRIMERI_UPITA.sql` | 💻 SQL | Test upiti | 10 min |
| 6 | `06_DETALJNI_ER_DIJAGRAM.md` | 📝 Markdown | Vizuelni prikaz | 10 min |
| 7 | `07_DETALJNA_SPECIFIKACIJA_TABELA.md` | 📝 Markdown | Specifikacije | 15 min |
| 8 | `README.md` | 📝 Markdown | Uvod i index | 5 min |
| 9 | `UPUTSTVO_KORAK_PO_KORAK.md` | 📝 Markdown | Tutorial | 10 min |

**UKUPNO**: ~70 minuta integralnog razumevanja ✅

---

## 🚀 BRZI START (5 MIN)

### Opcija 1: Pregled Dijagrama
```
1. Odidaj na: https://mermaid.live/
2. Copy → 02_KONCEPTUALNI_MODEL.mmd
3. Vidis: ER dijagram
4. Download PNG
```

### Opcija 2: Razumevanje Tabela
```
1. Otvori: 07_DETALJNA_SPECIFIKACIJA_TABELA.md
2. Vidiš: Svaka tabela sa primerima
3. Učiš: Šta je šta
```

### Opcija 3: Kreiraj Bazu
```
1. MySQL: mysql -u korisnik -p < 04_SQL_DDL_SKRIPTE.sql
2. Rezultat: Baza je sada u vašoj MySQL!
3. Test: SELECT * FROM MOVIES;
```

---

## 💡 KLJUČNE FUNKCIJE MODELA

✨ **Fleksibilnost** - Dinamički dodaj nove filmove, glumce, žanrove  
⚡ **Performansa** - Indeksi na najčešće kolone  
🔒 **Integritet** - FK constraints i CHECK ograničenja  
📊 **Analitika** - Omogućava kompleksne upite  
🎯 **Normalizacija** - 3NF bez duplikatnih podataka  
🔍 **Pretraga** - Brze pretrage sa indeksima  

---

## 📊 PRIMER KOMPLEKSNE ANALIZE

**Pitanje**: "*Pronađi sve filmove sa žanrom Drama iz 2010 godinu, sortirane po IMDb oceni, sa imenima redažisera*"

**SQL Rešenje** (iz `05_PRIMERI_UPITA.sql`):
```sql
SELECT 
    m.title,
    m.year,
    m.imdb_rating,
    CONCAT(d.first_name, ' ', d.last_name) as redaže iser
FROM MOVIES m
INNER JOIN DIRECTORS d ON m.director_id = d.director_id
INNER JOIN MOVIE_GENRE mg ON m.movie_id = mg.movie_id
INNER JOIN GENRES g ON mg.genre_id = g.genre_id
WHERE g.genre_name = 'Drama' AND m.year = 2010
ORDER BY m.imdb_rating DESC;
```

**Ovaj upit radi jer:**
- ✅ MOVIES je normalizovana - direktno povezana sa DIRECTORS
- ✅ MOVIE_GENRE omogućava M:N pretragu po žanru
- ✅ Indeksi na foreign keys čine pretragu brom
- ✅ Nema duplikonog podataka

---

## ⚠️ VAŽNE NAPOMENE

### Tipske greške koje se izbegavaju:**

❌ **NIKADA**: Čuvaj sve u jednoj tabeli  
✅ Rešenje: Normaliz - izdvoji entitete

❌ **NIKADA**: Koristi FLOAT za novčane vrednosti  
✅ Rešenje: Koristi DECIMAL(15,2)

❌ **NIKADA**: Postavi FK bez ograničenja  
✅ Rešenje: ON DELETE RESTRICT, ON UPDATE CASCADE

❌ **NIKADA**: Nemoj indeksirati sve kolone  
✅ Rešenje: Indeksiraj samo ključne kolone

---

## 🎓 ŠTAGODIŠETE NAUČILI?

Kroz ovaj model:

1. **Analiza Podataka** - Kako analyzirati CSV u entitete
2. **ER Modeliranje** - Kako crtati ER dijagrame
3. **SQL DDL** - Kako pisati CREATE TABLE iskaze
4. **Normalizacija** - Kako primeniti 3NF
5. **Relacijski Integritet** - Kako koristiti FK i constraintse
6. **SQL Upiti** - Kako pisati JOINS i agregacijske upite
7. **Indeksiranje** - Kako optimizovati performanse
8. **Baze Napred** - Kompletan proces od podataka do baze

---

## 🔍 VALIDACIJA MODELA

### Provera Pitanja:

✅ "Mogu li dodati novi film bez primetnog uticaja?"  
→ DA - Tabela MOVIES je optimizovana

✅ "Koji redažiser je režirao Inception?"
→ EASY - 1:N relacija MOVIES→DIRECTORS

✅ "Koja je kombinacija žanrova u Pulp Fiction?"
→ EASY - M:N relacija preko MOVIE_GENRE

✅ "Koji glumci su radili zajedno?"
→ EASY - M:N relacija preko MOVIE_ACTOR

✅ "Kolika je prosečna ocena po godini?"
→ EASY - GROUP BY year, AVG(imdb_rating)

---

## 📞 FINAL CHECKLIST

```
PRIJE PREDAJE:

☐ Svi Markdown fajlovi su čitljivi
☐ SQL skripte su testirane i rade
☐ Dijagrmi su generisvani i sačuvani
☐ Sve je najjednostavnije organizovano
☐ Struktura foldera je jasna
☐ ZIP fajl je spreman
☐ Readme.txt sa instrukcijama je uključen
☐ Nema grešaka u formatiranju
☐ Imena fajlova su jasna i profesionalna
☐ GOTOVO! 🎉
```

---

## 📚 REFERENCE

| Tema | Fajl |
|------|------|
| Kompletan Uvod | `README.md` |
| Detaljne Specifikacije | `07_DETALJNA_SPECIFIKACIJA_TABELA.md` |
| ER Dijagram | `02_KONCEPTUALNI_MODEL.mmd` |
| SQL za Kreiranje | `04_SQL_DDL_SKRIPTE.sql` |
| Primeri Upita | `05_PRIMERI_UPITA.sql` |
| Uputstvo | `UPUTSTVO_KORAK_PO_KORAK.md` |
| Analiza | `01_ANALIZA_BAZE_PODATAKA.md` |

---

**Sve potrebne informacije nalaze se u ovim fajlovima.**

**Vreme za predauu**: ⏰ Spremno!

---
