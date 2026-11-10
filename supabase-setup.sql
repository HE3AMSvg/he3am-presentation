-- Run this in Supabase Dashboard > SQL Editor.
-- Public PowerPoint library: anyone can read and upload; nobody can overwrite/delete via this policy.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'presentations',
  'presentations',
  true,
  20971520,
  array['application/vnd.openxmlformats-officedocument.presentationml.presentation']
)
on conflict (id) do update
set public = true,
    file_size_limit = 20971520,
    allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists "Public can view presentations" on storage.objects;
create policy "Public can view presentations"
on storage.objects for select
to public
using (bucket_id = 'presentations');

drop policy if exists "Anyone can upload presentations" on storage.objects;
create policy "Anyone can upload presentations"
on storage.objects for insert
to public
with check (bucket_id = 'presentations');
