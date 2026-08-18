# AirLoad Station — Free Offline Aircraft Weight and Balance & Loadsheet Software

**Free load control software for airline stations.** Calculate aircraft weight
and balance, plot the CG envelope, and produce an IATA AHM 560 loadsheet — on
one Windows PC, with no internet connection, no database, and no licence fee.

[**⬇ Download the installer**](station/releases) · [Current version and checksum](station/latest.json)

---

<div align="center">

**[English](#english)** · **[العربية](#العربية)** · **[Türkçe](#türkçe)** ·
**[Русский](#русский)** · **[فارسی](#فارسی)**

</div>

---

## English

### What it does

AirLoad Station is **free weight and balance (W&B) software** for airline
ground handling and load control at outstations, small carriers, and charter
operators.

- **Aircraft weight and balance** — zero fuel weight, ramp, take-off and
  landing weights, moments, index, %MAC and the stabiliser trim setting,
  checked against the aircraft's certified CG envelope and structural limits.
- **CG envelope plotted on the printed loadsheet** — ZFW, TOW and LAW shown as
  points inside the envelope, so the captain can check the flight at a glance
  before signing rather than trusting a number.
- **IATA AHM 560 loadsheet** as a printable PDF and an AHM 565 Type B message.
- **Passenger counts, not kilograms** — enter adults, children and infants and
  IATA RP 1720 standard weights are applied, with the arithmetic shown so it
  can be checked.
- **Last minute change (LMC)** recorded against a released loadsheet, capped by
  your operations manual.
- **AHM 514 fuel index table** — ramp, take-off and landing each use the fuel
  arm for the quantity actually on board.
- **METAR and TAF** for the briefing when a connection happens to be available.
- **47 operational form templates** — dispatch, ground handling, dangerous
  goods, border, maintenance, safety and reporting.

### Why it is offline

A station has to dispatch the flight whether or not the network is up. Nothing
here calls out, nothing is stored in a cloud, and the app listens on this
computer only. Your aircraft configurations and released loadsheets are plain
JSON files in your user folder — back them up by copying the folder.

### What it deliberately does not do

- **It ships with no aircraft data.** Nothing is calculated until you load your
  own AHM 514 configuration. It will not guess an aircraft's weights, arms,
  envelope or trim table.
- **It will not release a loadsheet outside the CG envelope**, and it refuses a
  last minute change that breaches your cap, a structural limit, or the
  envelope — it requires a new loadsheet instead.
- **The forms are implementation templates, not official ICAO/IATA/FAA/EASA
  documents.** Verify every regulatory requirement against current authorised
  sources before operational use.
- **Standard weights ship as unapproved samples.** Replace them with your
  airline's approved table before using a loadsheet computed from them.

### Install

1. Download the installer and check its SHA-256 against
   [`station/latest.json`](station/latest.json):
   ```powershell
   Get-FileHash .\AirLoadStation-Setup-1.1.0.exe -Algorithm SHA256
   ```
2. Run it. A Node.js runtime is included — nothing else is needed.
3. Launch **AirLoad Station**, open the **Aircraft** tab, and paste your
   AHM 514 configuration.

> The installer is not code-signed, so Windows SmartScreen will warn on first
> run. Verifying the published SHA-256 above is the check that actually proves
> the file is the one we published.

### AirLoad Pro — the full departure control system

AirLoad Station is the free load control part of **AirLoad Pro**, a complete
Mini DCS for small airlines:

| | AirLoad Station (free) | AirLoad Pro |
|---|---|---|
| Weight & balance, loadsheet, LMC | ✅ | ✅ |
| CG envelope, trim, Type B | ✅ | ✅ |
| Operational forms | ✅ | ✅ |
| Passenger check-in, seat map | — | ✅ |
| Boarding, BCBP boarding passes (Res 792) | — | ✅ |
| Baggage acceptance, bag tags (Res 740) | — | ✅ |
| Air cargo, air waybills (Res 600a) | — | ✅ |
| Dangerous goods and NOTOC | — | ✅ |
| APIS / PNRGOV regulatory filing | — | ✅ |
| Type B messages (LDM, CPM, LIR, BSM, PTM) | — | ✅ |
| Multi-user, roles, audit trail | — | ✅ |
| Multi-airline, multi-station | — | ✅ |
| Mobile surface for gate and ramp | — | ✅ |
| Self-service kiosk | — | ✅ |

**To buy AirLoad Pro, request a demonstration, or ask about a deployment:**
📧 **mohammad.ghodrati@gmail.com**

---

## العربية

### برنامج مجاني لحساب الوزن والاتزان وإصدار ورقة الحمولة

**AirLoad Station** برنامج **مجاني لمراقبة الحمولة (Load Control)** لمحطات
شركات الطيران والمناولة الأرضية. يعمل على جهاز ويندوز واحد **بدون إنترنت**،
وبدون قاعدة بيانات، وبدون رسوم ترخيص.

- **حساب الوزن والاتزان** — الوزن الخالي من الوقود، ووزن الإقلاع والهبوط،
  والعزوم، ونسبة %MAC، وضبط مثبت الاتزان، مع التحقق من مظروف مركز الثقل
  والحدود الإنشائية للطائرة.
- **رسم مظروف مركز الثقل على ورقة الحمولة المطبوعة** — تظهر نقاط ZFW و TOW و
  LAW داخل المظروف ليتحقق منها القائد قبل التوقيع.
- **ورقة حمولة وفق IATA AHM 560** بصيغة PDF ورسالة Type B وفق AHM 565.
- **إدخال عدد الركاب بدل الكيلوغرامات** — بالغون وأطفال ورضّع، وتُطبَّق الأوزان
  القياسية IATA RP 1720 مع إظهار الحساب للتحقق منه.
- **التغيير في اللحظة الأخيرة (LMC)** يُسجَّل على ورقة حمولة صادرة، ضمن الحد
  المعتمد في دليل التشغيل.
- **جدول مؤشر الوقود AHM 514** — لكل مرحلة ذراع الوقود المطابق للكمية الفعلية.
- **تقارير METAR و TAF** عند توفر اتصال.
- **٤٧ نموذجاً تشغيلياً**.

### لماذا يعمل بدون إنترنت

يجب أن تُرسَل الرحلة سواء كانت الشبكة تعمل أم لا. لا يتصل البرنامج بأي خادم،
ولا يُخزَّن شيء في السحابة، ويستمع على هذا الجهاز فقط.

### ما لا يفعله عمداً

- **لا يأتي ببيانات طائرات.** لا يُحسب شيء قبل تحميل تهيئة AHM 514 الخاصة بك.
- **لا يصدر ورقة حمولة خارج المظروف**، ويرفض أي LMC يتجاوز الحد أو المظروف.
- **النماذج قوالب تنفيذية وليست وثائق رسمية** صادرة عن ICAO/IATA/FAA/EASA.
- **الأوزان القياسية عيّنات غير معتمدة** — استبدلها بجدول شركتك المعتمد.

### التثبيت

نزّل المثبِّت، وتحقق من بصمة SHA-256 من
[`station/latest.json`](station/latest.json)، ثم شغّله. بيئة Node.js مضمَّنة.

> المثبِّت غير موقَّع رقمياً، لذلك سيُظهر ويندوز تحذير SmartScreen عند أول
> تشغيل. التحقق من بصمة SHA-256 هو الإثبات الفعلي لسلامة الملف.

### AirLoad Pro — نظام مراقبة المغادرة الكامل

النسخة المجانية هي جزء مراقبة الحمولة من **AirLoad Pro**، وهو نظام DCS متكامل
يشمل تسجيل الركاب وخريطة المقاعد والصعود وبطاقات الصعود (Res 792) والأمتعة
(Res 740) والشحن الجوي (Res 600a) والبضائع الخطرة وNOTOC وإرسال APIS/PNRGOV
ورسائل Type B وتعدد المستخدمين والصلاحيات وسجل التدقيق.

📧 **للشراء أو طلب عرض توضيحي: mohammad.ghodrati@gmail.com**

---

## Türkçe

### Ücretsiz uçak ağırlık ve denge (W&B) ve yük föyü yazılımı

**AirLoad Station**, havayolu istasyonları ve yer hizmetleri için **ücretsiz
yük kontrol (load control) yazılımıdır**. Tek bir Windows bilgisayarda,
**internet olmadan**, veritabanı ve lisans ücreti olmadan çalışır.

- **Ağırlık ve denge hesabı** — yakıtsız ağırlık, kalkış ve iniş ağırlıkları,
  momentler, %MAC, stabilizatör trim ayarı; sertifikalı ağırlık merkezi
  zarfına ve yapısal limitlere karşı kontrol edilir.
- **Yük föyüne basılan CG zarfı** — ZFW, TOW ve LAW noktaları zarfın içinde
  gösterilir; kaptan imzalamadan önce bir bakışta doğrulayabilir.
- **IATA AHM 560 yük föyü** — yazdırılabilir PDF ve AHM 565 Type B mesajı.
- **Kilogram yerine yolcu sayısı** — yetişkin, çocuk ve bebek sayısı girilir,
  IATA RP 1720 standart ağırlıkları uygulanır ve hesap görünür şekilde gösterilir.
- **Son dakika değişikliği (LMC)** yayımlanmış yük föyüne işlenir.
- **AHM 514 yakıt indeks tablosu**, **METAR ve TAF**, **47 operasyonel form**.

### Neden çevrimdışı

Bir istasyonun uçuşu göndermesi gerekir; ağ çalışsın ya da çalışmasın. Yazılım
dışarı hiçbir bağlantı kurmaz ve yalnızca bu bilgisayarı dinler.

### Bilerek yapmadıkları

- **Uçak verisiyle gelmez.** Kendi AHM 514 konfigürasyonunuzu yüklemeden hiçbir
  hesap yapılmaz.
- **Zarf dışında yük föyü yayımlamaz**, limiti aşan LMC'yi reddeder.
- **Formlar resmî ICAO/IATA/FAA/EASA belgeleri değil**, uygulama şablonlarıdır.
- **Standart ağırlıklar onaysız örnektir** — havayolunuzun onaylı tablosuyla
  değiştirin.

### Kurulum

Kurulumu indirin, SHA-256 özetini
[`station/latest.json`](station/latest.json) ile karşılaştırın ve çalıştırın.
Node.js çalışma ortamı pakete dâhildir.

> Kurulum dosyası kod imzalı değildir; Windows SmartScreen ilk çalıştırmada
> uyarı verir. Gerçek doğrulama yayımlanan SHA-256 kontrolüdür.

### AirLoad Pro — tam kalkış kontrol sistemi

Ücretsiz sürüm, **AirLoad Pro**'nun yük kontrol bölümüdür. Pro; yolcu check-in,
koltuk haritası, biniş ve BCBP biniş kartları (Res 792), bagaj ve bagaj
etiketleri (Res 740), hava kargo (Res 600a), tehlikeli maddeler ve NOTOC,
APIS/PNRGOV bildirimi, Type B mesajları, çok kullanıcılı yetkilendirme ve
denetim kaydı içerir.

📧 **Satın alma ve demo için: mohammad.ghodrati@gmail.com**

---

## Русский

### Бесплатная программа центровки и загрузки самолёта (Weight and Balance)

**AirLoad Station** — **бесплатное программное обеспечение для контроля
загрузки** авиакомпаний и служб наземного обслуживания. Работает на одном
компьютере с Windows **без интернета**, без базы данных и без лицензионных
платежей.

- **Расчёт массы и центровки** — масса без топлива, взлётная и посадочная
  масса, моменты, индекс, %САХ и установка стабилизатора; проверка по
  сертифицированной центровочной диаграмме и конструктивным ограничениям.
- **Центровочная диаграмма на печатном сводном загрузочном листе** — точки ZFW,
  TOW и LAW внутри допустимой области, чтобы командир мог проверить перед
  подписанием.
- **Сводный загрузочный лист IATA AHM 560** — PDF и сообщение Type B (AHM 565).
- **Ввод количества пассажиров вместо килограммов** — применяются стандартные
  массы IATA RP 1720, расчёт показывается для проверки.
- **Изменения в последнюю минуту (LMC)**, **таблица индекса топлива AHM 514**,
  **METAR и TAF**, **47 операционных форм**.

### Почему офлайн

Рейс должен быть отправлен независимо от того, работает ли сеть. Программа
никуда не обращается и слушает только этот компьютер.

### Чего он намеренно не делает

- **Не содержит данных о самолётах.** Расчёт невозможен, пока вы не загрузите
  собственную конфигурацию AHM 514.
- **Не выпускает загрузочный лист вне допустимой центровки** и отклоняет LMC,
  превышающее ваш предел.
- **Формы — шаблоны реализации, а не официальные документы** ICAO/IATA/FAA/EASA.
- **Стандартные массы — неутверждённые образцы.**

### Установка

Скачайте установщик, сверьте SHA-256 с
[`station/latest.json`](station/latest.json) и запустите. Среда Node.js входит
в комплект.

> Установщик не подписан цифровой подписью, поэтому Windows SmartScreen выдаст
> предупреждение при первом запуске. Настоящая проверка — сверка SHA-256.

### AirLoad Pro — полная система управления вылетом

Бесплатная версия — это часть контроля загрузки системы **AirLoad Pro**: полная
DCS с регистрацией пассажиров, картой мест, посадкой и посадочными талонами
BCBP (Res 792), багажом и бирками (Res 740), грузовыми авианакладными
(Res 600a), опасными грузами и NOTOC, передачей APIS/PNRGOV, сообщениями
Type B, ролями и журналом аудита.

📧 **Покупка и демонстрация: mohammad.ghodrati@gmail.com**

---

## فارسی

### نرم‌افزار رایگان وزن و تعادل هواپیما و صدور لودشیت

**AirLoad Station** یک **نرم‌افزار رایگان کنترل بار (Load Control)** برای
ایستگاه‌های شرکت‌های هواپیمایی و خدمات زمینی است. روی یک کامپیوتر ویندوزی،
**بدون اینترنت**، بدون دیتابیس و بدون هزینه‌ی لایسنس کار می‌کند.

- **محاسبه‌ی وزن و تعادل** — وزن بدون سوخت، وزن برخاست و فرود، ممان‌ها، ایندکس،
  درصد MAC و تنظیم تریم، با کنترل در برابر پاکت مرکز ثقل و حدود سازه‌ای هواپیما.
- **رسم پاکت CG روی لودشیت چاپی** — نقاط ZFW و TOW و LAW داخل پاکت نشان داده
  می‌شوند تا کاپیتان پیش از امضا با یک نگاه بررسی کند.
- **لودشیت مطابق IATA AHM 560** به‌صورت PDF و پیام Type B مطابق AHM 565.
- **ورود تعداد مسافر به‌جای کیلوگرم** — بزرگسال، کودک و نوزاد؛ وزن‌های استاندارد
  IATA RP 1720 اعمال و **محاسبه نمایش داده می‌شود** تا قابل بررسی باشد.
- **تغییر لحظه‌ی آخر (LMC)** روی لودشیت صادرشده، تا سقف دستورالعمل شما.
- **جدول ایندکس سوخت AHM 514** — هر مرحله بازوی سوختِ مقدار واقعی روی هواپیما.
- **METAR و TAF** هنگام وجود اتصال، و **۴۷ فرم عملیاتی**.

### چرا آفلاین

ایستگاه باید پرواز را بفرستد، چه شبکه کار کند چه نکند. نرم‌افزار هیچ تماس
بیرونی ندارد و فقط روی همین کامپیوتر گوش می‌دهد. تنظیمات هواپیما و لودشیت‌های
صادرشده فایل‌های ساده‌ی JSON در پوشه‌ی کاربر هستند.

### آنچه عمداً انجام نمی‌دهد

- **با هیچ داده‌ی هواپیمایی نمی‌آید.** تا تنظیمات AHM 514 خودتان را بارگذاری
  نکنید هیچ محاسبه‌ای انجام نمی‌شود.
- **لودشیت خارج از پاکت صادر نمی‌کند** و LMC بیش از سقف یا خارج از پاکت را رد
  می‌کند، نه اینکه هشدار بدهد و اجازه دهد.
- **فرم‌ها قالب پیاده‌سازی هستند، نه اسناد رسمی** ICAO/IATA/FAA/EASA.
- **وزن‌های استاندارد نمونه‌ی تأییدنشده‌اند** — با جدول تأییدشده‌ی شرکت خودتان
  جایگزین کنید.

### نصب

نصب‌کننده را دانلود کنید، مقدار SHA-256 را با
[`station/latest.json`](station/latest.json) بسنجید و اجرا کنید. محیط اجرایی
Node.js همراه بسته است.

> نصب‌کننده امضای دیجیتال ندارد، پس ویندوز در اجرای اول هشدار SmartScreen
> می‌دهد. بررسی SHA-256 منتشرشده تنها چیزی است که واقعاً سالم‌بودن فایل را
> اثبات می‌کند.

### AirLoad Pro — سیستم کامل کنترل پرواز

نسخه‌ی رایگان بخش کنترل بارِ **AirLoad Pro** است؛ یک DCS کامل شامل پذیرش مسافر،
نقشه‌ی صندلی، سوارشدن و کارت پرواز BCBP (Res 792)، پذیرش بار و تگ چمدان
(Res 740)، بار هوایی و بارنامه (Res 600a)، کالای خطرناک و NOTOC، ارسال
APIS/PNRGOV، پیام‌های Type B، چند-کاربره با نقش و سطح دسترسی، و سابقه‌ی ممیزی.

📧 **برای خرید یا درخواست دموی نرم‌افزار: mohammad.ghodrati@gmail.com**

---

<div align="center">

**Keywords** · aircraft weight and balance software · free loadsheet software ·
load control software · IATA AHM 560 loadsheet · AHM 514 · centre of gravity
envelope · trim sheet · last minute change LMC · departure control system DCS ·
ground handling software · offline W&B · برنامج الوزن والاتزان · ورقة الحمولة ·
uçak ağırlık ve denge yazılımı · yük föyü · программа центровки самолёта ·
загрузочный лист · نرم‌افزار وزن و تعادل · لودشیت

</div>

---

This repository carries released installers and end-user documentation only.
The application source is not published here.

**Contact: mohammad.ghodrati@gmail.com**
