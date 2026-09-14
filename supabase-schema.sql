-- Ejecuta esto una vez en Supabase Dashboard > SQL Editor.
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  avatar_url text,
  banner_url text,
  banner_scale numeric default 1,
  banner_x integer default 50,
  banner_y integer default 50,
  updated_at timestamptz default now()
);

alter table public.profiles enable row level security;

create policy "Users can view their own Eclipse profile"
on public.profiles for select to authenticated
using ((select auth.uid()) = id);

create policy "Users can create their own Eclipse profile"
on public.profiles for insert to authenticated
with check ((select auth.uid()) = id);

create policy "Users can update their own Eclipse profile"
on public.profiles for update to authenticated
using ((select auth.uid()) = id)
with check ((select auth.uid()) = id);
