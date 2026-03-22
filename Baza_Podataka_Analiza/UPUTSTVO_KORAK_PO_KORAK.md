# CINEVERSE - KORAK PO KORAK UPUTSTVO

## 🚀 BRZI START - 5 MINUTA

### Korak 1: Pregled Modela
Otidaj na https://mermaid.live/ i:
1. Kopija tekst iz **`02_KONCEPTUALNI_MODEL.mmd`**
2. Preuzmi kao PNG - **GOTOVO!** ✅

### Korak 2: Pregled Logičkog Modela  
Na istoj stranici:
1. Kopija tekst iz **`03_LOGICKI_MODEL.mmd`**
2. Preuzmi kao PNG - **GOTOVO!** ✅

### Korak 3: Razume Tabele
Pročitaj **`07_DETALJNA_SPECIFIKACIJA_TABELA.md`** - ceo proces je objasnjen sa primerima!

---

## 📚 DETALJNO - KORAK PO KORAK

### 📖 FAZA 1: RAZUMEVANJE MODELA (30 min)

#### 1.1 Čitaj Analizu
```
Fajl: 01_ANALIZA_BAZE_PODATAKA.md
│
├─ Odeljak: "ANALIZA IZVORA PODATAKA"
│  └─ Saznaj šta su ulazni podaci
│
├─ Odeljak: "IDENTIFIKOVANI ENTITETI"  
│  └─ Razume svaki entitet i atribute
│
├─ Odeljak: "RELACIJE IZMEĐU ENTITETA"
│  └─ Saznaj 1:N i M:N veze
│
└─ Odeljak: "NORMALIZACIJA"
   └─ Razume zašto je struktura optimalna
```

#### 1.2 Pogledaj Vizuelne Dijagrame
```
Odidaj na: https://mermaid.live/
│
└─ Konceptualni Model:
   Kopija → 02_KONCEPTUALNI_MODEL.mmd
   │
   └─ Vidiš: Entiteti, atributi, relacije
   
└─ Logički Model:
   Kopija → 03_LOGICKI_MODEL.mmd
   │
   └─ Vidiš: Tipovi podataka, ključevi, veze
```

#### 1.3 Detalje o Tabelama
```
Fajl: 07_DETALJNA_SPECIFIKACIJA_TABELA.md
│
├─ COUNTRIES - informacije o zemljama
├─ DIRECTORS - redažiseri
├─ GENRES - žanrovi
├─ ACTORS - glumci
├─ MOVIES - filmovi
├─ MOVIE_GENRE - veza filmova i žanrova
└─ MOVIE_ACTOR - veza filmova i glumaca
```

---

### 🏗️ FAZA 2: KREIRANJE BAZE PODATAKA (20 min)

#### 2.1 Korišćenje MySQL

**Opcija A: Sa komandne linije**
```bash
# Otvori terminal
cd /putanja/do/fajla

# Kreiraj bazu
mysql -u korisnik -p < 04_SQL_DDL_SKRIPTE.sql

# Rezultat: Baza je sada kreirana!
```

**Opcija B: Sa MySQL Workbenchu**
```
1. Otvori MySQL Workbench
2. Pravi novu konekciju ili otvori postojeću
3. File → Open SQL Script
4. Odaberi: 04_SQL_DDL_SKRIPTE.sql
5. Klikni: Execute (Ctrl+Enter)
6. ✅ Baza je sada kreirana!
```

**Opcija C: Sa phpMyAdmin**
```
1. Otvori phpMyAdmin (localhost/phpmyadmin)
2. New → SQL
3. Kopija ceo sadržaj iz 04_SQL_DDL_SKRIPTE.sql
4. Klikni: Go/Execute
5. ✅ Baza je sada kreirana!
```

#### 2.2 Dodaj Test Podatke

Pročitaj `07_DETALJNA_SPECIFIKACIJA_TABELA.md` i:
```sql
-- Kopiraj INSERT iskaze
INSERT INTO COUNTRIES (country_name, region) VALUES ...
INSERT INTO DIRECTORS (first_name, last_name, ...) VALUES ...
-- itd.
```

---

### 🔍 FAZA 3: TESTIRANJE UPITA (15 min)

#### 3.1 Osnovni Upiti
Otidaj u `05_PRIMERI_UPITA.sql`:
```
GRUPA 1: OSNOVNI UPITI ZA BRZU ANALIZU
└─ Kopiraj i testiraj:
   ├─ Svi filmovi sortirani po godini
   ├─ Pronađi filmove sa najboljom ocenom
   ├─ Koliko je filmova iz svake godine?
   └─ itd.
```

#### 3.2 Kompleksni Upiti  
```
GRUPA 2: UPITI SAS SPOJENJEM TABELA (JOINS)
└─ Svi filmovi sa imenima redažisera
GRUPA 3: UPITI SA ŽANROVIMA
└─ Pronađi sve filmove sa određenim žanrom
GRUPA 4: UPITI SA GLUMCIMA
└─ Pronađi najčešće glumce
```

#### 3.3 Analitički Upiti
```
GRUPA 5: ANALITIČKI UPITI - PERFORMANSA
└─ Pronađi filmove sa  najvećim zaradom
GRUPA 7: UPITI ZA AGREGACIJU PODATAKA
└─ Top 10 najbolje ocenjenih filmova
```

---

## 🎨 PRAVLJENJE DIJAGRAMA ZA PREDAJU

### Konceptualni Model (ER Dijagram)

**Korak 1: Otvori Mermaid Live**
```
1. Odidaj na: https://mermaid.live/
2. Vidis editor sa leve strane i preview sa desne
```

**Korak 2: Kopija kod**
```
1. Otvori: 02_KONCEPTUALNI_MODEL.mmd
2. Kopija sve (Ctrl+A, Ctrl+C)
3. U Mermaid editoru: Select all i paste
4. Vidis dijagram se generiše automatski
```

**Korak 3: Preuzmi sliku**
```
1. Desni klik na dijagram → Copy image
   ALIDE:
   - Klikni ikona sa kopijom (📋) 
   - Klikni ikona sa kamerom (📸)
   
2. Adobi format: PNG (za brže učitavanje)

3. Čuvaj u: "konceptualni_model.png"
```

**Alternativa: Generisanje PDF-a**
```
1. U chrome: Ctrl+P (Print)
2. Ispis u: Save as PDF
3. Čuvaj kao: "konceptualni_model.pdf"
```

---

### Logički Model (Sa Tipovima Podataka)

**Isto kao konceptualni, Ali:**
```
1. Koristi: 03_LOGICKI_MODEL.mmd
2. Vidis: Tipove podataka, ključeve, veze
3. Preuzmi kao: "logicki_model.png"
```

---

### Oba Diagramma kao SVG (Best Quality)

**Korišćenje SVG Editor-a:**
```
1. U Mermaid Live na ikonici 📋 (Copy SVG)
2. Otvori: https://www.svgviewer.dev/
3. Paste SVG kod
4. Download kao SVG ili konvertij u PNG/PDF
```

---

## 📦 ORGANIZOVANJE ZA PREDAJU

### Struktura Foldera

```
Tinarako_Task2/
├── konceptualni_model.png
├── logicki_model.png
├── baza_podataka_specifikacija.pdf
├── SQL_DDL_skripte.sql
├── primeri_upita.sql
├── ANALIZA.md
├── README.md
└── (opciono) baza_podataka_model.mwb  [ako koristiš MySQL Workbench]
```

### Kreiranje Foldera

**Na Mac-u:**
```bash
# Terminal
mkdir ~/Desktop/Tinarako_Task2
cd ~/Desktop/Tinarako_Task2

# Kopiraj fajlove
cp ~/Desktop/konceptualni_model.png .
cp ~/Desktop/logicki_model.png .
# itd.

# Kreiraj ZIP
cd ~/Desktop
zip -r Tinarako_Task2.zip Tinarako_Task2/

# Rezultat: Tinarako_Task2.zip je spreman za predaju!
```

**Na Windows-u:**
```
1. Pravi novi folder: Tinarako_Task2
2. Kopira sve fajlove
3. Desni klik na folder
4. Send to → Compressed (zipped) folder
5. Rezultat: Tinarako_Task2.zip
```

---

## ✅ CHECKLIST ZA PREDAJU

```
FAZA 1: DOKUMENTACIJA
☐ 01_ANALIZA_BAZE_PODATAKA.md - SAČUVAN
☐ 06_DETALJNI_ER_DIJAGRAM.md - SAČUVAN
☐ 07_DETALJNA_SPECIFIKACIJA_TABELA.md - SAČUVAN

FAZA 2: DIJAGRMI
☐ konceptualni_model.png - GENERISVANO I SAČUVANO
☐ konceptualni_model.pdf - GENERISVANO I SAČUVANO
☐ logicki_model.png - GENERISVANO I SAČUVANO
☐ logicki_model.pdf - GENERISVANO I SAČUVANO

FAZA 3: SQL
☐ 04_SQL_DDL_SKRIPTE.sql - SAČUVAN
☐ 05_PRIMERI_UPITA.sql - SAČUVAN
☐ Baza je kreiraea i testirana ✅

FAZA 4: FINALNO
☐ Svi fajlovi su u foleru: Tinarako_Task2/
☐ Folder je zipeovan: Tinarako_Task2.zip
☐ Fajlovi su jasno nazivani
☐ README.txt sa opisom je uključen
```

---

## 🐛 TROUBLESHOOTING

### Mermaid dijagram se ne prikazuje

**Problem**: Kod se ne prikazuje kao dijagram
```
Rešenje:
1. Prefrešuj stranicu (F5)
2. Proverio da li je ceo kod kopiran (bez # komentar)
3. Pokušaj u drugom browser-u (Chrome, Firefox)
4. Koristi: https://www.mermaidchart.com/ umesto live
```

### SQL greške pri kriranju baze

**Problem**: "Syntax error" ili "Unknown column"
```
Rešenje:
1. Proverio da li je MySQL start-ovan
2. Čitaj kompletnu grešku u konzoli
3. Proverio dali su svi znakovi ispravni (UTF-8)
4. Koristi komandu: SET NAMES 'utf8mb4';
```

### Upiti ne vraćaju rezultate

**Problem**: "0 rows returned"
```
Rešenje:
1. Proverio dali su test podaci dodati
2. Koristi: SELECT COUNT(*) FROM MOVIES;
3. Ako je 0, dodaj podatke iz 07_DETALJNA_SPECIFIKACIJA_TABELA.md
```

---

## 📚 DODATNI RESURSI

- **MySQL Documentation**: https://dev.mysql.com/doc/
- **Mermaid Docs**: https://mermaid.js.org/
- **SQL Tutorial**: https://www.w3schools.com/sql/
- **Database Design**: https://www.coursera.org/

---

## 🎓 UČNA ISKUSTVA

Nakon ovog zadatka bi trebalo da razumeš:

✅ Kako identificirati entitete iz podataka  
✅ Kako definisati relacije između entiteta  
✅ Kako kreirati konceptualni i logički model  
✅ Kako pisati SQL za kreiranje baze  
✅ Kako pisati kompleksne SQL upite  
✅ Kako normalizovati bazu podataka  
✅ Kako optimizovati performansu sa indeksima  
✅ Kako upravljati integritenom podataka  

---

**Srećno sa zadatkom!** 🎉

Ako imaš pitanja, proverio dokumentaciju ili kreni sa FAZA 1!

---
