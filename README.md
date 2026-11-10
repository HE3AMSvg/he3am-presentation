# HE3AM Presentation

صفحه ارائه کلاسی درس «ما هم می‌توانیم» — تفکر و سواد رسانه‌ای پایه دهم.

## راه‌اندازی آپلود امن پاورپوینت

این سایت روی GitHub Pages اجرا می‌شود؛ برای ذخیره فایل‌های آپلودی از Supabase Storage استفاده می‌کند.

1. در Supabase یک پروژه بسازید.
2. از بخش **Storage** یک bucket با نام دقیق `presentations` بسازید و گزینه **Public bucket** را روشن کنید.
3. در بخش **Authentication → Users** فقط حساب مدیر را ایجاد کنید. در تنظیمات Auth، ثبت‌نام عمومی کاربران را غیرفعال کنید تا فقط مدیر مجاز به ورود باشد.
4. در بخش **SQL Editor** این دستورات را اجرا کنید:

```sql
create policy "Public can read presentation"
on storage.objects for select
to public
using (bucket_id = 'presentations');

create policy "Authenticated admins can upload presentation"
on storage.objects for insert
to authenticated
with check (bucket_id = 'presentations');

create policy "Authenticated admins can replace presentation"
on storage.objects for update
to authenticated
using (bucket_id = 'presentations')
with check (bucket_id = 'presentations');
```

5. فایل `config.example.js` را کپی کنید و نام نسخه کپی‌شده را `config.js` بگذارید. مقدار Project URL و anon/publishable key را از بخش **Project Settings → API** در Supabase وارد کنید.
6. فایل `config.js` را در ریشه همین مخزن قرار دهید. این کلید عمومی (anon/publishable) است؛ هرگز service_role key را در سایت قرار ندهید.
7. سایت را باز کنید، با ایمیل و رمز مدیر وارد شوید، فایل PPTX تا سقف ۳۰ مگابایت انتخاب و بارگذاری کنید.

فایل با نام ثابت `presentation.pptx` ذخیره می‌شود و لینک دانلود عمومی آن در صفحه فعال خواهد شد. فقط حساب‌های احراز هویت‌شده می‌توانند فایل را بارگذاری یا جایگزین کنند.

## انتشار GitHub Pages

از مسیر **Settings → Pages**، گزینه **Deploy from a branch** را انتخاب کنید؛ Branch: `main` و Folder: `/ (root)` و سپس Save را بزنید.
