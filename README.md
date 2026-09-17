# Pawny — paleidimo instrukcija

Šitas aplankas — pilnai savarankiškas statinis puslapis (vienas `index.html` failas). Jokio build žingsnio nereikia.

## 1. Supabase — duomenų bazė

1. Eik į [supabase.com](https://supabase.com), susikurk paskyrą (arba prisijunk) ir sukurk naują projektą.
2. Kai projektas sukurtas, eik į **SQL Editor** (kairėje meniu) → **New query**.
3. Atsidaryk šiame aplanke esantį failą `supabase-schema.sql`, nukopijuok visą jo turinį, įklijuok į SQL Editor ir paspausk **Run**.
   - Tai sukurs lentelę `animals`, įjungs saugumo taisykles (RLS) ir įkels visus 8 pradinius gyvūnus (su nuotraukomis).
4. Eik į **Project Settings** (krumpliaratis apačioje kairėje) → **API**.
   - Nukopijuok **Project URL** ir **anon public** raktą (ne `service_role` — tas turi likti paslaptyje).

## 2. Įrašyk Supabase duomenis į `index.html`

Atsidaryk `index.html`, susirask šias eilutes (netoli failo apačios, prieš `</body>`):

```js
var SUPABASE_URL = "YOUR_SUPABASE_URL";
var SUPABASE_ANON_KEY = "YOUR_SUPABASE_ANON_KEY";
```

Pakeisk į savo tikras reikšmes iš 1 žingsnio, pvz.:

```js
var SUPABASE_URL = "https://abcdefghijk.supabase.co";
var SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...";
```

`anon` raktas skirtas naudoti viešai (naršyklėje) — tai normalu, jį apsaugo RLS taisyklės, kurias jau įjungei SQL faile.

## 3. GitHub

1. Susikurk naują repozitoriją GitHub'e (pvz. `pawny-app`).
2. Įkelk šio aplanko failus (`index.html`, `supabase-schema.sql`, šitą `README.md`) į repozitoriją:

```bash
git init
git add .
git commit -m "Pawny — pirma versija"
git branch -M main
git remote add origin https://github.com/TAVO-VARDAS/pawny-app.git
git push -u origin main
```

(Arba tiesiog nusivilk failus į GitHub svetainę per naršyklę, jei nenori naudoti terminalo — "Add file" → "Upload files".)

## 4. Vercel

1. Eik į [vercel.com](https://vercel.com) ir prisijunk su GitHub paskyra.
2. **Add New** → **Project** → pasirink ką tik sukurtą `pawny-app` repozitoriją → **Import**.
3. Vercel automatiškai atpažins, kad tai statinis puslapis (Framework Preset: "Other"). Jokių papildomų nustatymų keisti nereikia — spausk **Deploy**.
4. Po kelių sekundžių gausi tikrą, viešą nuorodą (pvz. `pawny-app.vercel.app`), kurią gali siųsti bet kam.

## Ką daryti toliau

- **Savas domenas**: Vercel projekto **Settings → Domains** gali prijungti savo domeną (pvz. `pawny.lt`), jei jį turi.
- **Nuotraukų įkėlimas iš formos**: šiuo metu "Kelti gyvūną" forma neišsaugo įkeltos nuotraukos (laukelis kol kas dekoratyvinis). Kai būsi pasiruošęs, galima įjungti Supabase Storage (Dashboard → Storage → New bucket, pvz. `animal-photos`, viešas), ir susieti su forma — parašyk, jei nori, kad tuo užsiimčiau.
- **Apsauga nuo šiukšlių**: dabar bet kas gali sukurti skelbimą be jokios registracijos (paprasta pradžiai, bet reiškia, kad bet kas gali „užpildyti" lentelę). Vėliau verta pridėti Supabase Auth (el. paštu/telefonu) ir apriboti `insert` taisyklę tik prisijungusiems vartotojams.
- **Peržiūra ir redagavimas**: visus skelbimus (įskaitant naujus, atėjusius per formą) matysi ir galėsi redaguoti tiesiogiai Supabase Dashboard → **Table Editor** → `animals`.
