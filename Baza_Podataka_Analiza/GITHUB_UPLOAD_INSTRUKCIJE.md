# 📤 UPLOAD NA GITHUB - KORAK PO KORAK

## ⚠️ VAŽNO: Ja ne mogu direktno uploadovati na GitHub
Ja sam AI asistent u VS Code-u i mogu samo pomoći sa instrukcijama. Ti moraš sam uraditi upload.

---

## 📋 ŠTA TREBAŠ URADITI

### KORAK 1: Kreiraj GitHub Repository
```
1. Otvori: https://github.com/
2. Klikni: "New repository"
3. Ime: "cineverse-database-model" ili "tinarako-task2"
4. Opis: "Cineverse - Database Model for Movies"
5. Postavi na PUBLIC ili PRIVATE (po želji)
6. NE dodaj README, .gitignore, license (mi ćemo to dodati)
7. Klikni: "Create repository"
```

### KORAK 2: Pripremi Lokalni Folder
```
1. Otvori Terminal
2. Idi u folder sa projektom:
   cd /Users/tinarako/Desktop/Tinarako_Task2

3. Inicijalizuj Git:
   git init

4. Dodaj sve fajlove:
   git add .

5. Kreiraj commit:
   git commit -m "Initial commit: Cineverse database model and analysis"
```

### KORAK 3: Poveži sa GitHub
```
1. Kopiraj URL iz GitHub repository (npr: https://github.com/tvoje-ime/cineverse-database-model.git)

2. Dodaj remote:
   git remote add origin https://github.com/tvoje-ime/cineverse-database-model.git

3. Push na GitHub:
   git push -u origin main
```

---

## 🔒 SIGURNOSNE INFORMACIJE

### ŠTA TREBA SAKRITI?
U ovom projektu **NEMA sigurnosnih informacija** koje treba sakriti:
- ❌ Nema lozinki
- ❌ Nema API ključeva
- ❌ Nema privatnih podataka
- ❌ Nema baze podataka sa realnim podacima

### ALI AKO IMAŠ .ENV FAJL ILI NEŠTO SLIČNO:
```
1. Kreiraj .gitignore fajl:
   echo ".env" > .gitignore
   echo "*.log" >> .gitignore
   echo "node_modules/" >> .gitignore

2. Dodaj u Git:
   git add .gitignore
   git commit -m "Add .gitignore for security"
```

---

## ✅ PROVERA DA JE UPLOAD USPJEŠAN

```
1. Otvori GitHub repository u browser-u
2. Trebalo bi da vidiš sve fajlove:
   - konceptualni_model.png
   - logički_model.png
   - 01_ANALIZA_BAZE_PODATAKA.md
   - 04_SQL_DDL_SKRIPTE.sql
   - itd.
```

---

## 🎯 ALTERNATIVA: MANUAL UPLOAD

Ako ne želiš koristiti Git:

```
1. Idi na GitHub repository
2. Klikni: "Add file" → "Upload files"
3. Prevuci sve fajlove iz Tinarako_Task2 foldera
4. Commit sa porukom: "Upload Cineverse database project"
```

---

## 📝 README ZA GITHUB

Kreiraj README.md u repository-u:

```markdown
# Cineverse Database Model

## Opis
Kompletan konceptualni i logički model baze podataka za filmski sistem Cineverse.

## Sadržaj
- Konceptualni ER dijagram
- Logički model sa tipovima podataka
- SQL DDL skripte za kreiranje baze
- Primeri SQL upita
- Detaljna analiza i specifikacije

## Autor
[Tvoje ime] - [Datum]
```

---

## 🚀 GOTOVO!

Nakon push-a, tvoj projekat će biti na GitHub-u i možeš podijeliti link sa instruktorom.

**Link će biti:** `https://github.com/tvoje-ime/ime-repository-a`
