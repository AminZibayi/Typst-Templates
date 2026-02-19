#import "lib/template.typ": template, latin, abstract-block
#import "lib/utilities.typ": ltr-footnote, en
#import "lib/theorems.typ": definition, theorem, observation, cproof, reset-theorem-counter
#import "lib/algorithms.typ": algorithm, kw, cmt, ind, ind2, ind3, algo-lines, ln

#show: template.with(
  title: "پوشش دیسک واحد",
  course: "نام درس",
  author: "نام و نام خانوادگی",
  organization: "دانشگاه صنعتی امیرکبیر، دانشکده مهندسی کامپیوتر",
  date: "خردادماه 1401",
)

#set heading(numbering: "1")
#set figure(numbering: "1")
#show heading.where(level: 1): it => {
  reset-theorem-counter()
  it
}

// ─── Abstract ───────────────────────────────────────────────────────────────
#abstract-block[
  در این گزارش، چهار مورد از الگوریتم‌های تقریبی که اخیراً برای مسئله پوشش دیسک واحد ارائه شده‌اند شرح داده می‌شوند و پس از پیاده‌سازی، با استفاده از چند مجموعه‌نقطه دنیای واقعی، مورد ارزیابی تجربی قرار می‌گیرند. معیارهای ارزیابی، تعداد دیسک‌های درنظر گرفته شده و زمان اجرای هر الگوریتم خواهد بود. در نهایت عملکرد هر الگوریتم و بهترین الگوریتم‌ها برای هر معیار گزارش می‌شود.
]

// ─── Section 1 ──────────────────────────────────────────────────────────────
= شرح مسئله

مجموعه $P$ شامل $n$ نقطه در صفحه داده می‌شود. هدف، پوشش تمام نقاط با استفاده از کمترین تعداد دیسک با شعاع واحد ($r=1$) است. این مسئله، پوشش دیسک واحد ($U D C$)#ltr-footnote[Unit Disk Cover] نامیده شده و یک مسئله ان‌پی‌سخت#ltr-footnote[NP-hard] به‌حساب می‌آید @fowler1981optimal. در کاربردهای مختلف مانند شبکه‌های بی‌سیم، تعیین موقعیت، برنامه‌ریزی حرکت، پردازش تصاویر و... استفاده می‌شود.

// ─── Section 2 ──────────────────────────────────────────────────────────────
= مرور الگوریتم‌ها

از سال 1991 تاکنون الگوریتم‌های زیادی ارائه شده‌اند که این مسئله را به‌صورت تقریبی با فاکتورهای تقریب و پیچیدگی‌های زمانی متفاوت، در نُرم اقلیدسی حل می‌کنند. @tb1 تاریخچه الگوریتم‌های تقریبی ارائه شده برای این مسئله را نشان می‌دهد.

#figure(
  kind: table,
  caption: [خلاصه الگوریتم‌های تقریبی ارائه شده برای $U D C$],
  table(
    columns: 4,
    align: center,
    table.hline(stroke: .8pt),
    [مرجع], [فاکتور تقریب], [پیچیدگی زمانی], [سال],
    table.hline(stroke: .4pt),
    [@gonzalez1991covering], [$2(1+1/l)$], [$O(l^2 n^7)$], [1991],
    [@gonzalez1991covering], [$8$], [$O(n log S)$], [1991],
    [@bronnimann1995almost], [$O(1)$], [$O(n^3 log n)$], [1995],
    [@franceschetti2001geometric], [$3(1+1/l)^2$], [$O(K n)$], [2001],
    [@fu2007almost], [$2.8334$], [$O(n (log n log log n)^2)$], [2007],
    [@liu2014fast], [$25\/6$], [$O(n log n)$], [2014],
    [@biniaz2017approximation], [$4$], [$O(n log n)$], [2017],
    [@imanparast2020simple], [$4$], [$O(n log n)$], [2018],
    [@dumitrescu2020online], [$O(1.321^d)$], [$-$], [2018],
    [@ghosh2019unit], [$7$], [$O(n)$], [2019],
    table.hline(stroke: .8pt),
  ),
) <tb1>

در ادامه، به‌ترتیب الگوریتم‌های ذیل بررسی می‌شوند:

#set list(marker: [•], spacing: 1em)
- الگوریتم $B L M S$ که در سال 2017 ارائه شده است @biniaz2017approximation.
- الگوریتم $L L$ که در سال 2014 ارائه شده است @liu2014fast.
- الگوریتم $D G T$ که در سال 2018 ارائه شده است @dumitrescu2020online.
- الگوریتم $F a s t C o v e r$ که در سال 2019 ارائه شده است @ghosh2019unit.

عنوان سه الگوریتم‌ اول، برگرفته از حرف اول نام پژوهشگران مربوط به آن است.

// ─── 2.1 ────────────────────────────────────────────────────────────────────
== الگوریتم $B L M S$

مجموعه $P$ را به‌عنوان مجموعه نقاط ورودی که در صفحه قرار دارند و $C^*$ را پوشش دیسک بهینه برای آن در نظر بگیرید. به‌خاطر داشته باشید که شعاع هر دیسک واحد برابر با 1 است.

#definition[
در گراف تقاطع دیسک واحد#ltr-footnote[Unit Disk Intersection Graph] که با $U D I G(P)$ نمایش داده می‌شود، نقاط موجود در مجموعه $P$ رئوس را تشکیل می‌دهند و برای هر جفت $p,q in P$ یک یال وجود دارد اگر و تنها اگر $|p q| lt.eq 2$ باشد که $|p q|$ فاصله اقلیدسی بین $p$ و $q$ را نشان می‌دهد.
] <def1>

#observation[
برای دو نقطه $p,q in P$، اگر $(p,q) in.not U D I G(P)$ آنگاه $p$ و $q$ نمی‌توانند با یک دیسک واحد پوشش داده شوند.
] <ob1>

#definition[
یک مجموعه مستقل در $U D I G(P)$، زیرمجموعه‌ای مانند $I$ از مجموعه $P$ است، به‌طوری که هیچ یالی بین جفت نقطه‌های موجود در $I$ وجود ندارد. همچنین $I$ مجموعه مستقل حداکثری#ltr-footnote[Maximal Independent Set] نامیده می‌شود، اگر برای هر $p in P without I$، مجموعه $I union {p}$ در $U D I G(P)$ مستقل نباشد.
]

فرض کنید $I$ مجموعه مستقل حداکثری در $U D I G(P)$ باشد. طبق @ob1 اندازه هر مجموعه مستقل در $U D I G(P)$ یک حد پایین#ltr-footnote[Lower Bound] برای تعداد دیسک‌های موردنیاز به‌منظور پوشش $P$ است. بنابراین خواهیم داشت:

$ |I| lt.eq |C^*| $ <eq1>

مطابق @figf1 برای پوشش یک دیسک با شعاع 2، هفت دیسک واحد با شعاع 1 لازم و کافی است. بر همین اساس، یک الگوریتم با فاکتور تقریب 7 برای مسئله $U D C$ به‌دست می‌آید.

فرض کنید $I$ یک مجموعه مستقل حداکثری دلخواه در $U D I G(P)$ باشد. برای هر نقطه $p in I$ فرض کنید $D(p,2)$ یک دیسک با مرکزیت نقطه $p$ و شعاع 2 باشد. همچنین درنظر داشته باشید که $d(p)$ دیسک واحدی است که نقطه $p$ را پوشش می‌دهد. علاوه‌براین، تمام نقاطی که از مجموعه $P$ توسط $d(p)$ پوشش داده می‌شوند، در $D(p,2)$ وجود دارند. بنابراین با پوشش $D(p,2)$ به‌وسیله 7 دیسک واحد، به‌ازای همه $p in I$، الگوریتمی با فاکتور تقریب 7 حاصل می‌شود.

#figure(
  image("figs/f1.jpg", width: 40%),
  caption: [پوشش $D(p,2)$ با دیسک‌های واحد],
) <figf1>

در ادامه خواهید دید که چگونه می‌توان فاکتور تقریب را به 4 کاهش داد. $p$ را سمت چپ‌ترین نقطه در مجموعه $P$ درنظر بگیرید. در موارد خاص که مقادیر $x$ نقاط با هم برابر است، برای انتخاب سمت چپ‌ترین نقطه، کمتر بودن مقدار $y$ را ملاک قرار می‌دهیم. فرض کنید خط عمودی $l$ از نقطه $p$ عبور کند؛ $R(p)$ اشتراک $D(p,2)$ با نیم‌صفحه#ltr-footnote[Half-plane] سمت راست $l$ خواهد بود؛ یعنی $R(p)$ نیم‌دیسک سمت راست $D(p,2)$ است (مطابق @figf2).

همان‌طور که قبلاً هم توضیح داده شد، تمام نقاط مجموعه $P$ که با $d(p)$ پوشش داده شده‌اند، در $D(p,2)$ و به‌تبع آن در $R(p)$ نیز قرار دارند. مطابق @figf2، نیم‌دیسک $R(p)$ می‌تواند با 4 دیسک واحد پوشش داده شود. قسمت دوم شکل، حالتی از موقعیت قرار گرفتن 7 نقطه را نشان می‌دهد که برای پوشش آنها حداقل به 4 دیسک واحد نیاز است.

#figure(
  image("figs/f2.jpg", width: 30%),
  caption: [پوشش $R(p)$ با دیسک‌های واحد],
) <figf2>

برای نقطه‌ای مانند $p$ و مجموعه نقاط $I$ فاصله $d(p,I)$ برابر است با کمترین فاصله اقلیدسی بین $p$ و هر نقطه موجود در $I$. اگر مجموعه $I$ تهی باشد، فاصله بینهایت درنظر گرفته می‌شود. @blms1، الگوریتم پیشنهادی با فاکتور تقریب 4 را نشان می‌دهد. خروجی آن، مجموعه‌ای از دیسک‌های واحد با نام $C$ است که مجموعه نقاط $P$ را پوشش می‌دهند.

#algorithm(caption: [نسخه اولیه $B L M S$])[
  #algo-lines(
    ln[1], [$C = emptyset$],
    ln[2], [$I = emptyset$],
    ln[3], [$L = $ List of points in $P$ sorted from left to right],
    ln[4], [#kw[while] $L$ is not empty #kw[do]],
    ln[5], [#ind #kw[if] $d(p,I) > 2$ #kw[then]],
    ln[6], [#ind2 Cover $R(p)$ by 4 unit disks $c_1, c_2, c_3, c_4$],
    ln[7], [#ind2 $C = C union { c_1, c_2, c_3, c_4 }$],
    ln[8], [#ind2 $I = I union { p }$],
    ln[9], [#ind #kw[end if]],
    ln[10], [#ind $L = L - { p }$],
    ln[11], [#kw[end while]],
    ln[12], [#kw[return] $C$],
  )
] <blms1>

در هر تکرار @blms1، نقطه $p$ به مجموعه $I$ اضافه می‌شود، اگر و تنها اگر $d(p,I) > 2$ باشد. بنابراین $p$ در $U D I G(P)$ به هیچ نقطه‌ای از $I$ متصل نیست. همچنین بعد از خاتمه الگوریتم، $I$ یک مجموعه مستقل حداکثری خواهد بود.

#theorem[
فاکتور تقریب @blms1 برای مسئله پوشش دیسک واحد، 4 است.
]

#cproof[
مجموعه نقاط $I$ و مجموعه دیسک‌های واحد $C$ را در پایان الگوریتم، درنظر بگیرید. براساس @eq1 می‌دانیم که نامساوی $|I| lt.eq |C^*|$ برقرار است. به‌ازای نقاط $p in I$ هر نقطه $q in P$ در یک نیم‌دیسک $R(p)$ قرار دارد (ممکن است $q = p$ باشد). چون برای هر نقطه $p in I$، نیم‌دیسک $R(p)$ با 4 دیسک واحد پوشش داده می‌شود، مجموعه $C$ مجموعه $P$ را پوشش می‌دهد. بنابراین رابطه $|C| lt.eq 4|I| lt.eq 4|C^*|$ برقرار است.
]

پیچیدگی زمانی @blms1 برابر $O(n log n + n dot t(d))$ است. $t(d)$ پیچیدگی زمانی محاسبه فاصله $d(p,I)$ را نشان می‌دهد. محاسبه این فاصله با پیچیدگی زمانی $O(log^2 n)$ قابل انجام است @bentley1980decomposable. بنابراین پیچیدگی نهایی الگوریتم، $O(n log^2 n)$ است که در ادامه با استفاده از تکنیک جاروی صفحه، بهبود می‌یابد.

به‌جای محاسبه فاصله $d(p,I)$ کافی است بدانیم فاصله نقطه $p$ از مجموعه $I$ از 2 بیشتر است یا نه؛ یعنی به یک مسئله تصمیم‌گیری تبدیل شود. به‌تدریج که یک نقطه جدید مانند $p$ به مجموعه $I$ اضافه می‌شود، نقاط مجموعه $P$ که در نیم‌دیسک $R(p)$ قرار دارند، حذف می‌شوند. برهمین اساس، یک الگوریتم با استفاده از تکنیک جاروی صفحه و پیچیدگی زمانی $O(n log n)$ ارائه می‌شود.

در @blms2، ابتدا نقاط بر اساس مؤلفه $x$ از چپ به راست مرتب شده و در صف رخدادها درج می‌شوند. خط جارو به‌صورت عمودی از چپ به راست بر روی نقاط حرکت می‌کند. به هر نقطه که می‌رسد، اگر نقطه انتهایی یک نیم‌دیسک باشد، نقطه ابتدایی مربوط به آن نیم‌دیسک را از درخت وضعیت حذف می‌کند. در غیر این صورت، دو نقطه همسایه از بالا و دو نقطه همسایه از پایین را در درخت وضعیت برای این نقطه پیدا می‌کند. اگر فاصله آن با حداقل یکی از این 4 همسایه کمتر یا مساوی 2 باشد، نقطه مورد نظر قبلاً در یک نیم‌دیسک قرار گرفته و تحت پوشش است. در غیر این صورت، یک نیم‌دیسک به شعاع 2 و مرکز آن نقطه درنظر گرفته می‌شود و مرکز 4 دیسک واحد پوشش‌دهنده آن نیم‌دیسک محاسبه و به‌عنوان جواب گزارش می‌شود.

#algorithm(caption: [نسخه بهبود یافته $B L M S$ با تکنیک جاروی صفحه])[
  #set par(leading: 0.45em)
  #algo-lines(
    ln[1], [Initialize an empty event queue $Q$. Insert the points in ascending order of their $x$-coordinates into $Q$.],
    ln[2], [Initialize an empty BST status structure $T$.],
    ln[3], [Initialize an empty list $C$.],
    ln[4], [#kw[while] $Q$ is not empty #kw[do]],
    ln[5], [#ind Determine the next event point $p$ in $Q$ and delete it.],
    ln[6], [#ind #kw[if] $p$ is an end-point #kw[then]],
    ln[7], [#ind2 Delete the start-point of the corresponding half-disk from $T$.],
    ln[8], [#ind #kw[else]],
    ln[9], [#ind2 Find the 2 top and the 2 bottom neighbors of $p$ in $T$.],
    ln[10], [#ind2 #kw[if] The distance between $p$ and all of these 4 neighbors is greater than 2 #kw[then]],
    ln[11], [#ind3 Calculate center points of the 4 unit disks which cover half-disk of point $p$ and insert them into $C$.],
    ln[12], [#ind3 Insert $p$ into $T$.],
    ln[13], [#ind3 Insert the end-point $q=(p_x + 2, p_y)$ into $Q$.],
    ln[14], [#ind2 #kw[end if]],
    ln[15], [#ind #kw[end if]],
    ln[16], [#kw[end while]],
    ln[17], [#kw[return] $C$],
  )
] <blms2>

// ─── 2.2 ────────────────────────────────────────────────────────────────────
== الگوریتم $L L$

در این الگوریتم، صفحه به نوار‌های عمودی با عرض $sqrt(3)$ تقسیم می‌شود. از هر نوار، یک جواب تقریبی با مرتب‌سازی نقاط براساس مؤلفه $y$ به‌صورت نزولی به‌دست می‌آید. نقطه بعدی درون یک نوار که هنوز پوشش داده نشده است، با قرار دادن یک دیسک در پایین‌ترین مکان ممکن، پوشش داده می‌شود. مرکز این دیسک‌ها، روی خطوط عمودی که نوارها را به دو قسمت تقسیم می‌کنند قرار می‌گیرد. جواب نهایی با اجتماع جواب همه نوارها حاصل می‌شود. این سامانه نواری، 5 مرتبه به سمت راست و هر دفعه به‌اندازه $sqrt(3) / 6$ شیفت داده می‌شود. در هر شیف، یک جواب به‌دست می‌آید. از بین این 6 جواب، آن جوابی که کمترین دیسک را استفاده کرده باشد به‌عنوان جواب نهایی درنظر گرفته می‌شود. جزئیات بیشتر در @algLL موجود است. فاکتور تقریب این الگوریتم $25\/6 approx 4.17$ است.

#algorithm(caption: [محاسبه موقعیت دیسک‌های واحد با استفاده از $L L$])[
  #set par(leading: 0.45em)
  #algo-lines(
    ln[1], [$"Disk-Centers" arrow.l emptyset$, $min arrow.l n+1$;],
    ln[2], [Sort $P$ w.r.t $x$-coordinate in $O(n log n)$ time;],
    ln[3], [#kw[for] $i in {0,1,2,3,4,5}$ #kw[do]],
    ln[4], [#ind $"current" arrow.l 1$, $C arrow.l emptyset$, $"right" arrow.l P[1]_x + (i sqrt(3))\/6$;],
    ln[5], [#ind #kw[while] $"current" lt.eq n$ #kw[do]],
    ln[6], [#ind2 $"index" arrow.l "current"$;],
    ln[7], [#ind2 #kw[while] $P["current"]_x < "right"$ #kw[and] $"current" lt.eq n$ #kw[do]],
    ln[8], [#ind3 $"current" arrow.l "current" + 1$;],
    ln[9], [#ind2 #kw[end while]],
    ln[10], [#ind2 $x"-of-restriction-line" arrow.l "right" - sqrt(3)\/2$, $"segments" arrow.l emptyset$;],
    ln[11], [#ind2 #kw[for] $j arrow.l "index"$ #kw[to] $"current"-1$ #kw[do]],
    ln[12], [#ind3 $d arrow.l P[j]_x - x"-of-restriction-line"$, $y arrow.l sqrt(1-d^2)$;],
    ln[13], [#ind3 Create a segment $s$ and insert it into $"segments"$;],
    ln[14], [#ind2 #kw[end for]],
    ln[15], [#ind2 Sort $"segments"$ in non-ascending order and greedily stab them; put stabbing points in $C$;],
    ln[16], [#ind2 Increment $"right"$ by a multiple of $sqrt(3)$ s.t. $P["current"] - "right" lt.eq sqrt(3)$;],
    ln[17], [#ind #kw[end while]],
    ln[18], [#ind #kw[if] $|C| < min$ #kw[then]],
    ln[19], [#ind2 $"Disk-Centers" arrow.l C$, $min arrow.l |C|$;],
    ln[20], [#ind #kw[end if]],
    ln[21], [#kw[end for]],
    ln[22], [#kw[return] $"Disk-Centers"$;],
  )
] <algLL>

// ─── 2.3 ────────────────────────────────────────────────────────────────────
== الگوریتم $D G T$

این الگوریتم، ساده و برخط است. به‌ازای هرنقطه‌ای که تاکنون تحت پوشش قرار نگرفته است، یک دیسک واحد به مرکز آن نقطه ایجاد می‌شود. فاکتور تقریب آن در صفحه، 5 است. در فضای با ابعاد $d$ دارای فاکتور تقریب $O(1.321^d)$ است. برای مشاهده توصیف سطح بالا، به @algDGT مراجعه نمایید.

#algorithm(caption: [محاسبه موقعیت دیسک‌های واحد با استفاده از $D G T$])[
  #algo-lines(
    ln[1], [$"Disk-Centers" arrow.l emptyset$;],
    ln[2], [#kw[for] $p in P$ #kw[do]],
    ln[3], [#ind #kw[if] the distance from $p$ to the nearest point in $"Disk-Centers"$ is $> 1$ #kw[then]],
    ln[4], [#ind2 $"Disk-Centers" arrow.l "Disk-Centers" union {p}$;],
    ln[5], [#ind #kw[end if]],
    ln[6], [#kw[end for]],
    ln[7], [#kw[return] $"Disk-Centers"$;],
  )
] <algDGT>

// ─── 2.4 ────────────────────────────────────────────────────────────────────
== الگوریتم $F a s t C o v e r$

در این الگوریتم، از یک شبکه#ltr-footnote[Grid] با مربع‌های به ضلع $sqrt(2)$ استفاده می‌شود. هر مربع از این شبکه، می‌تواند توسط یک دیسک به شعاع واحد محاط شود. به‌ازای هر نقطه، اگر توسط یکی از دیسک‌هایی که قبلاً قرار گرفته است تحت پوشش باشد، عملی انجام نمی‌شود؛ در غیر این صورت، یک دیسک واحد به مرکز مربعی که آن نقطه درونش قرار گرفته است، ایجاد می‌شود.

در پیاده‌سازی برای جستجوی سریع‌تر، از یک جدول درهم‌ساز#ltr-footnote[Hash table] استفاده می‌شود. در این جدول، مختصات مرکز دیسک‌هایی که اضافه شده‌اند ذخیره می‌شود. برای جلوگیری از مشکلات اعداد اعشاری، از یک جفت عدد صحیح برای نمایش مرکز هر دیسک استفاده می‌شود. مختصات حقیقی می‌تواند با ضرب کردن هر عدد صحیح در $sqrt(2)$ و اضافه کردن $sqrt(2) \/ 2 = 1 \/ sqrt(2)$ به آن به‌دست بیاید. این فرآیند در @algFast قابل ملاحظه است.

این الگوریتم دارای فاکتور تقریب 7 و پیچیدگی زمانی $O(n)$ است. یک الگوریتم برخط به‌حساب می‌آید و هیچ پیش‌پردازشی مثل مرتب‌سازی روی نقاط انجام نمی‌دهد. به‌اندازه $O(s)$ حافظه اضافی مصرف می‌کند که $s$ نشان‌دهنده اندازه پوشش تولید شده است.

#algorithm(caption: [محاسبه موقعیت دیسک‌های واحد با استفاده از $F a s t C o v e r$])[
  #algo-lines(
    ln[1], [$cal(H) arrow.l emptyset$; $"Disk-Centers" arrow.l emptyset$;],
    ln[2], [#kw[for] $p in P$ #kw[do]],
    ln[3], [#ind $i arrow.l floor(p_x \/ sqrt(2))$; $j arrow.l floor(p_y \/ sqrt(2))$;],
    ln[4], [#ind #kw[if] $(i,j) in.not cal(H)$ #kw[then]],
    ln[5], [#ind2 insert $(i,j)$ into $cal(H)$ and $(sqrt(2) i + 1\/sqrt(2),\ sqrt(2) j + 1\/sqrt(2))$ into $"Disk-Centers"$;],
    ln[6], [#ind #kw[end if]],
    ln[7], [#kw[end for]],
    ln[8], [#kw[return] $"Disk-Centers"$;],
  )
] <algFast>

این الگوریتم را می‌توان کمی بهبود داد. وقتی که یک نقطه در یک مربع از شبکه قرار می‌گیرد، ممکن است توسط 4 دیسک واحد که مربوط به مربع‌های همسایه است و قبلاً اضافه شده‌اند تحت پوشش باشد (مطابق @figf3). بنابراین بهتر است برای کاهش تعداد دیسک‌ها این شرایط نیز بررسی شود. در @algFastPlus جزئیات نسخه بهبودیافته ذکر شده است.

#figure(
  image("figs/f3.jpg", width: 40%),
  caption: [امکان پوشش یک نقطه با دیسک‌های مربع‌های همسایه],
) <figf3>

#algorithm(caption: [محاسبه موقعیت دیسک‌های واحد با استفاده از $F a s t C o v e r+$])[
  #set par(leading: 0.45em)
  #algo-lines(
    ln[1], [$cal(H) arrow.l emptyset$; $"Disk-Centers" arrow.l emptyset$;],
    ln[2], [#kw[for] $p in P$ #kw[do]],
    ln[3], [#ind $i arrow.l floor(p_x\/sqrt(2))$; $j arrow.l floor(p_y\/sqrt(2))$;],
    ln[4], [#ind #kw[if] $(i,j) in cal(H)$ #kw[then] #kw[continue]; #cmt[$p$ is already covered by $D(i,j)$]],
    ln[5], [#ind #kw[else if] $p_x gt.eq sqrt(2)(i+1.5)-1$ #kw[and] $(i+1,j) in cal(H)$ #kw[and] $"dist"(p, D(i+1,j)) lt.eq 1$ #kw[then]],
    ln[6], [#ind2 #kw[continue]; #cmt[$p$ is covered by the grid-disk $E$ placed before]],
    ln[7], [#ind #kw[else if] $p_x lt.eq sqrt(2)(i-0.5)+1$ #kw[and] $(i-1,j) in cal(H)$ #kw[and] $"dist"(p, D(i-1,j)) lt.eq 1$ #kw[then]],
    ln[8], [#ind2 #kw[continue]; #cmt[$p$ is covered by the grid-disk $W$ placed before]],
    ln[9], [#ind #kw[else if] $p_y gt.eq sqrt(2)(j+1.5)-1$ #kw[and] $(i,j+1) in cal(H)$ #kw[and] $"dist"(p, D(i,j+1)) lt.eq 1$ #kw[then]],
    ln[10], [#ind2 #kw[continue]; #cmt[$p$ is covered by the grid-disk $N$ placed before]],
    ln[11], [#ind #kw[else if] $p_y lt.eq sqrt(2)(j-0.5)+1$ #kw[and] $(i,j-1) in cal(H)$ #kw[and] $"dist"(p, D(i,j-1)) lt.eq 1$ #kw[then]],
    ln[12], [#ind2 #kw[continue]; #cmt[$p$ is covered by the grid-disk $S$ placed before]],
    ln[13], [#ind #kw[else]],
    ln[14], [#ind2 insert $(i,j)$ into $cal(H)$ and $(sqrt(2) i + 1\/sqrt(2), sqrt(2) j + 1\/sqrt(2))$ into $"Disk-Centers"$;],
    ln[15], [#ind #kw[end if]],
    ln[16], [#kw[end for]],
    ln[17], [#kw[return] $"Disk-Centers"$;],
  )
] <algFastPlus>

بهبود دیگری می‌توان روی الگوریتم اعمال نمود. اگر نقاط موجود در دو دیسک مجاور را بتوان با یک دیسک پوشش داد، یعنی قطر مجموعه نقاط هر دو دیسک کمتر از 2 باشد، می‌توان آن دو دیسک را ادغام نمود. برای ادغام، یک دیسک واحد به مرکز وسط قطر مجموعه نقاط درنظر گرفته می‌شود. برای اینکه محاسبه قطر، تأثیری روی پیچیدگی زمانی الگوریتم نداشته باشد، به‌همراه هر دیسک واحدی که ایجاد می‌شود، یک مستطیل مرزی نیز برای مجموعه نقاط موجود در آن نگهداری می‌شود. جزئیات بیشتر در @algFastPP ذکر شده است.

#algorithm(caption: [محاسبه موقعیت دیسک‌های واحد با استفاده از $F a s t C o v e r"++"$])[
  #set par(leading: 0.45em)
  #algo-lines(
    ln[1], [$cal(H) arrow.l emptyset$; $"Disk-Centers" arrow.l emptyset$;],
    ln[2], [#kw[for] $p in P$ #kw[do]],
    ln[3], [#ind $i arrow.l floor(p_x\/sqrt(2))$; $j arrow.l floor(p_y\/sqrt(2))$;],
    ln[4], [#ind #kw[if] $(i,j) in cal(H)$ #kw[then] update $B(i,j)$ using $p$; #cmt[$p$ is already covered by $D(i,j)$]],
    ln[5], [#ind #kw[else if] east/west/north/south neighbor covers $p$ #kw[then] update its bounding box;],
    ln[6], [#ind #kw[else] insert $(i,j)$ into $cal(H)$ and initialize $B(i,j)$ using $p$;],
    ln[7], [#ind #kw[end if]],
    ln[8], [#kw[end for]],
    ln[9], [#kw[while] there is a grid-disk $(i,j) in cal(H)$ not yet considered #kw[do]],
    ln[10], [#ind #kw[if] $exists$ grid-disk $(k,l) in cal(H)$ s.t. $|i-k| lt.eq 1$, $|j-l| lt.eq 1$ #kw[and] diagonal$(B(i,j) union B(k,l)) lt.eq 2$ #kw[then]],
    ln[11], [#ind2 remove $(i,j)$ and $(k,l)$ from $cal(H)$; add center of merged box to $"Disk-Centers"$;],
    ln[12], [#ind #kw[end if]],
    ln[13], [#kw[end while]],
    ln[14], [#kw[for] every grid-disk $(i,j) in cal(H)$ #kw[do]],
    ln[15], [#ind insert $(sqrt(2) i + 1\/sqrt(2),\ sqrt(2) j + 1\/sqrt(2))$ into $"Disk-Centers"$;],
    ln[16], [#kw[end for]],
    ln[17], [#kw[return] $"Disk-Centers"$;],
  )
] <algFastPP>

// ─── Section 3 ──────────────────────────────────────────────────────────────
= ارزیابی

همه الگوریتم‌ها با زبان $C"++"$ و کتابخانه $C G A L$ پیاده‌سازی شده‌اند. هرکدام از آنها بر روی 10 مجموعه‌نقطه دنیای واقعی اجرا شده‌اند. @tbeval نتایج ارزیابی را نشان می‌دهد. هر الگوریتم، 5 بار بر روی هر مجموعه‌نقطه اجرا شده است. هر خانه کمترین تعداد دیسک و کمترین زمان پردازش برحسب ثانیه از بین این 5 اجرا را نشان می‌دهد. منظور از $L L"-"1P$، اجرای یک مرحله‌ای @algLL به‌جای شش مرحله است.

#figure(
  kind: table,
  caption: [نتایج ارزیابی الگوریتم‌ها],
  {
    set text(lang: "en", dir: ltr, size: 8pt)
    table(
      columns: 8,
      stroke: .4pt,
      align: center,
      table.hline(stroke: .8pt),
      table.header(
        [*#h(0pt)*], [*LL*], [*LL-1P*], [*BLMS*], [*DGT*], [*FastCover*], [*FastCover+*], [*FastCover++*],
      ),
      table.hline(stroke: .8pt),
      [birch3],   [99989, 0.18],  [99991, 0.03],  [99994, 0.05],  [99993, 0.07],  [99996, 0.02],  [99995, 0.02],  [99980, 0.08],
      [monalisa], [100000, 0.15], [100000, 0.03], [100000, 0.11], [100000, 0.08], [100000, 0.02], [100000, 0.02], [100000, 0.08],
      [usa],      [115475, 0.17], [115475, 0.04], [115475, 0.12], [115475, 0.09], [115475, 0.02], [115475, 0.03], [115475, 0.10],
      [KDDCU2D],  [1147, 0.19],   [1152, 0.04],   [1692, 0.10],   [1626, 0.01],   [1418, 0.01],   [1374, 0.01],   [1257, 0.01],
      [europe],   [168253, 0.35], [168271, 0.06], [168088, 0.19], [168069, 0.16], [168333, 0.03], [168277, 0.04], [167811, 0.20],
      [wildfires],[622, 3.74],    [622, 0.88],    [842, 1.21],    [787, 0.12],    [663, 0.04],    [637, 0.04],    [620, 0.06],
      [world],    [6667, 2.84],   [6680, 0.51],   [9145, 0.79],   [10980, 0.15],  [7874, 0.03],   [7576, 0.04],   [6967, 0.07],
      [nyctaxi],  [25, 13.84],    [26, 3.09],     [32, 2.90],     [31, 0.13],     [34, 0.05],     [31, 0.05],     [25, 0.10],
      [uber],     [3, 21.06],     [3, 4.75],      [5, 4.03],      [5, 0.19],      [5, 0.06],      [4, 0.06],      [4, 0.16],
      [hail2015], [888, 39.83],   [889, 9.82],    [1193, 11.19],  [1128, 0.74],   [901, 0.28],    [860, 0.28],    [847, 0.42],
      table.hline(stroke: .8pt),
    )
  },
) <tbeval>

// ─── Section 4 ──────────────────────────────────────────────────────────────
= نتیجه‌گیری

در مجموعه‌نقطه‌های دنیای واقعی، اگر معیار با اهمیت‌تر برای ارزیابی، تعداد دیسک‌های استفاده شده باشد، الگوریتم $L L$ عملکرد بهتری دارد. هرچند که الگوریتم $F a s t C o v e r^("++" )$ در برخی موارد، هم از لحاظ تعداد دیسک‌ها و هم زمان اجرا، عملکرد بهتری داشته است.

اگر معیار مهم‌تر، زمان اجرا باشد الگوریتم $F a s t C o v e r$ عملکرد بهتری داشته است؛ اما چون تفاوت چندانی با نسخه بهبودیافته خود که تعداد دیسک‌های کمتری تولید می‌کند ندارد، استفاده از $F a s t C o v e r^("++" )$ پیشنهاد می‌شود.

اگر هردو معیار تعداد دیسک‌ها و زمان اجرا با اهمیت باشد، استفاده از الگوریتم $F a s t C o v e r^("++" )$ توصیه می‌شود؛ چرا که تعادل خوبی بین هردو معیار برقرار می‌کند @friederich2022experiments.

// ─── References ─────────────────────────────────────────────────────────────
#pagebreak()

#heading(level: 1, numbering: none)[مراجع]

#bibliography("etc/references.bib", title: none, style: "ieee")

// ─── Appendix ────────────────────────────────────────────────────────────────
#pagebreak()

#heading(level: 1, numbering: none)[پیوست]

همان‌طور که در @tb1 ملاحظه شد، بهترین الگوریتم‌هایی که تاکنون برای مسئله $U D C$ ارائه شده‌اند، دارای فاکتور تقریب 4 هستند. اینجانب، توجه زیادی به این مسئله با هدف بهبود فاکتور تقریب و نگارش مقاله نمودم. ایده‌های مختلفی برای بهبود فاکتور تقریب به ذهنم رسید که پس از بررسی‌های فراوان متوجه شدم برخی از آنها اشتباه است و برخی دیگر را به‌دلیل کمبود زمان نتوانستم به‌طور دقیق بررسی کنم. در ادامه تعدادی از آنها را بیان می‌کنم.

ایده اول، با هدف کاهش فاکتور تقریب از 4 به 3 بود. در @figf2 نشان داده شد که برای پوشش یک نیم‌دیسک به شعاع 2، دقیقاً به 4 دیسک واحد احتیاج است. بر اساس این شکل، برای پوشش یک ربع‌دیسک نیز دقیقاً به 3 دیسک واحد احتیاج است. با فرض اینکه اشتراک دو نیم‌دیسک به شعاع 2 حداکثر با یک ربع‌دیسک قابل پوشش است، می‌توان یک‌بار مطابق @blms2 خط جارو را از چپ به راست و بار دیگر از بالا به پایین حرکت داد. پس از بررسی مشخص شد که این ایده عملی نیست. چون فرض اولیه اشتباه است و حالت‌هایی وجود دارد که اشتراک دو نیم‌دیسک بیشتر از حد تصور می‌شود و نمی‌توان آن را با یک ربع‌دیسک پوشش داد (مطابق @figapp1).

#figure(
  image("figs/app1.png", width: 30%),
  caption: [عدم امکان پوشش اشتراک دو نیم‌دیسک با ربع‌دیسک],
) <figapp1>

ایده دوم نیز با هدف کاهش فاکتور تقریب از 4 به 3 بود. به‌جای نیم‌دیسک‌های با شعاع 2، ربع‌دیسک‌هایی به شعاع 2 درنظر گرفته می‌شود که هرکدام با 3 دیسک واحد قابل پوشش هستند. در @algapp1 جزئیات ایده بیان شده است. در این الگوریتم، خط جارو از بالا به پایین بر روی نقاط حرکت می‌کند. پس از بررسی، مشخص شد که این ایده نیز، عملی نیست. زیرا مانند @figapp2 حالت‌هایی وجود دارد که ربع‌دیسک‌های زیادی با یکدیگر همپوشانی پیدا می‌کنند و در نهایت فاکتور تقریب، $O(n)$ می‌شود.

#pagebreak()

#algorithm(caption: [ایده دوم برای کاهش فاکتور تقریب به 3])[
  #algo-lines(
    ln[1], [Initialize an empty event queue $Q$. Insert the points in descending order of their $y$-coordinates into $Q$. If two points have the same $y$-coordinate, the one with smaller $x$-coordinate has higher priority.],
    ln[2], [Initialize an empty BST status structure $T$.],
    ln[3], [Initialize an empty list $C$.],
    ln[4], [#kw[while] $Q$ is not empty #kw[do]],
    ln[5], [#ind Determine the next event point $p$ in $Q$ and delete it.],
    ln[6], [#ind #kw[if] $p$ is an end-point #kw[then]],
    ln[7], [#ind2 Delete the start-point of the corresponding quarter disk from $T$.],
    ln[8], [#ind #kw[else]],
    ln[9], [#ind2 Find the two left neighbors $p', p''$ of $p$ in $T$.],
    ln[10], [#ind2 #kw[if] $|p p'| > 2$ and $|p p''| > 2$ #kw[then]],
    ln[11], [#ind3 Calculate center points of the 3 unit disks which cover quarter disk of point $p$ and insert them into $C$.],
    ln[12], [#ind3 Insert $p$ into $T$.],
    ln[13], [#ind3 Insert the end-point $q = (p_x, p_y + 2)$ into $Q$.],
    ln[14], [#ind2 #kw[end if]],
    ln[15], [#ind #kw[end if]],
    ln[16], [#kw[end while]],
    ln[17], [#kw[return] $C$],
  )
] <algapp1>

#figure(
  image("figs/app2.png", width: 25%),
  caption: [حالتی که ربع‌دیسک‌های زیادی همپوشانی پیدا می‌کنند],
) <figapp2>
