-- Pawny — vartotojų paskyrų migracija
-- Paleisk šį failą Supabase SQL Editor'iuje PO to, kai jau paleidai supabase-schema.sql

-- 1) Pridedam savininko lauką prie gyvūnų lentelės
alter table public.animals
  add column if not exists owner_id uuid references auth.users(id) on delete set null;

-- 2) Atnaujinam RLS taisykles: dabar kelti skelbimą gali tik prisijungęs vartotojas,
--    ir tik su savo owner_id
drop policy if exists "Public insert access" on public.animals;

create policy "Logged in users can insert own listings"
  on public.animals for insert
  with check (auth.uid() = owner_id);

-- 3) Vartotojas gali redaguoti/ištrinti tik savo skelbimus
create policy "Users can update own listings"
  on public.animals for update
  using (auth.uid() = owner_id);

create policy "Users can delete own listings"
  on public.animals for delete
  using (auth.uid() = owner_id);

-- Pastaba: "Public read access" politika (visi gali matyti skelbimus) lieka nepakitusi.
