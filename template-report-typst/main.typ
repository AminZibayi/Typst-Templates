// Document setup
#set page(
  paper: "a4",
  margin: (left: 25mm, right: 25mm, top: 25mm, bottom: 30mm),
)

#set text(
  font: ("B Nazanin", "Times New Roman"),
  size: 12pt,
  lang: "fa",
  dir: rtl,
  fallback: true,
)

#set par(
  leading: 0.65em,
  spacing: 1.5em,
  justify: true,
)

// Enable equation numbering
#set math.equation(numbering: "(1)")

// Set heading numbering
#set heading(numbering: "1.1")

// Custom header
#align(center)[
  #grid(
    columns: (1fr, 3fr, 1fr),
    column-gutter: 1em,
    align: (center, center, center),
    [#image("etc/aut.png", width: 2cm)],
    [
      #text(size: 10pt)[
        به‌نام خدا \
        پوشش دیسک واحد \
        نام درس \
        نام و نام خانوادگی \
        #v(0.25cm)
        #text(size: 8pt)[
          دانشگاه صنعتی امیرکبیر، دانشکده مهندسی کامپیوتر \
          خردادماه 1401 \
        ]
      ]
    ],
    [#image("etc/ce.png", width: 1.8cm)],
  )
  #v(0.5cm)
  #line(length: 100%, stroke: 1pt)
]

// Theorem environments - all share the same counter, reset per section
#let theorem-counter = counter("theorem")

// Reset theorem counter at each section
#show heading.where(level: 1): it => {
  theorem-counter.update(0)
  it
}

#show figure.where(kind: "definition"): it => {
  theorem-counter.step()
  block(
    width: 100%,
    inset: 8pt,
    [
      *تعریف #context {
        let h = counter(heading).get().first()
        let t = theorem-counter.get().first()
        numbering("1.1", h, t)
      }*.
      #it.body
    ]
  )
}

#show figure.where(kind: "theorem"): it => {
  theorem-counter.step()
  block(
    width: 100%,
    inset: 8pt,
    [
      *قضیه #context {
        let h = counter(heading).get().first()
        let t = theorem-counter.get().first()
        numbering("1.1", h, t)
      }*.
      #it.body
    ]
  )
}

#show figure.where(kind: "lemma"): it => {
  theorem-counter.step()
  block(
    width: 100%,
    inset: 8pt,
    [
      *لم #context {
        let h = counter(heading).get().first()
        let t = theorem-counter.get().first()
        numbering("1.1", h, t)
      }*.
      #it.body
    ]
  )
}

#show figure.where(kind: "observation"): it => {
  theorem-counter.step()
  block(
    width: 100%,
    inset: 8pt,
    [
      *مشاهده #context {
        let h = counter(heading).get().first()
        let t = theorem-counter.get().first()
        numbering("1.1", h, t)
      }*.
      #it.body
    ]
  )
}

#let proof(body) = {
  block(
    width: 100%,
    inset: 8pt,
    [
      *برهان*.
      #body
    ]
  )
}

// Reference setup
#show ref: it => {
  let el = it.element
  if el != none {
    if el.func() == figure {
      if el.kind == "image" {
        [شکل ]
        it
      } else if el.kind == "table" {
        [جدول ]
        it
      }
    } else if el.func() == math.equation {
      [برابری ]
      it
    } else if el.func() == heading {
      [بخش ]
      it
    } else {
      it
    }
  } else {
    it
  }
}

// Headings
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  text(size: 14pt, weight: "bold")[
    #counter(heading).display() #h(0.5em) #it.body
  ]
}

#show heading.where(level: 2): it => {
  text(size: 13pt, weight: "bold")[
    #counter(heading).display() #h(0.5em) #it.body
  ]
}

// Abstract
#align(center)[
  #block(
    width: 100%,
    inset: 12pt,
    [
      در این گزارش، چهار مورد از الگوریتم‌های تقریبی که اخیراً برای مسئله پوشش دیسک واحد ارائه شده‌اند شرح داده می‌شوند و پس از پیاده‌سازی، با استفاده از چند مجموعه‌نقطه دنیای واقعی، مورد ارزیابی تجربی قرار می‌گیرند. معیارهای ارزیابی، تعداد دیسک‌های درنظر گرفته شده و زمان اجرای هر الگوریتم خواهد بود. در نهایت عملکرد هر الگوریتم و بهترین الگوریتم‌ها برای هر معیار گزارش می‌شود.
    ]
  )
]

= شرح مسئله

مجموعه $P$ شامل $n$ نقطه در صفحه داده می‌شود. هدف، پوشش تمام نقاط با استفاده از کمترین تعداد دیسک با شعاع واحد ($r=1$) است. این مسئله، پوشش دیسک واحد ($"UDC"$)#footnote[#text(dir: ltr)[Unit Disk Cover]] نامیده شده و یک مسئله ان‌پی‌سخت#footnote[#text(dir: ltr)[NP-hard]] به‌حساب می‌آید @fowler1981optimal.
در کاربردهای مختلف مانند شبکه‌های بی‌سیم، تعیین موقعیت، برنامه‌ریزی حرکت، پردازش تصاویر و... استفاده می‌شود.

= مرور الگوریتم‌ها

از سال 1991 تاکنون الگوریتم‌های زیادی ارائه شده‌اند که این مسئله را به‌صورت تقریبی با فاکتورهای تقریب و پیچیدگی‌های زمانی متفاوت، در نُرم اقلیدسی حل می‌کنند. @tb:1 تاریخچه الگوریتم‌های تقریبی ارائه شده برای این مسئله را نشان می‌دهد.

#figure(
  table(
    columns: 4,
    align: center,
    [مرجع], [فاکتور تقریب], [پیچیدگی زمانی], [سال],
    [@gonzalez1991covering], [$2(1+1/l)$], [$O(l^2 n^7)$], [1991],
    [@gonzalez1991covering], [$8$], [$O(n log S)$], [1991],
    [@bronnimann1995almost], [$O(1)$], [$O(n^3 log n)$], [1995],
    [@franceschetti2001geometric], [$3(1+1/l)^2$], [$O(K n)$], [2001],
    [@fu2007almost], [$2.8334$], [$O(n(log n log log n)^2)$], [2007],
    [@liu2014fast], [$25\/6$], [$O(n log n)$], [2014],
    [@biniaz2017approximation], [$4$], [$O(n log n)$], [2017],
    [@imanparast2020simple], [$4$], [$O(n log n)$], [2018],
    [@dumitrescu2020online], [$O(1.321^d)$], [$-$], [2018],
    [@ghosh2019unit], [$7$], [$O(n)$], [2019],
  ),
  caption: [خلاصه الگوریتم‌های تقریبی ارائه شده برای $"UDC"$],
) <tb:1>

در ادامه، به‌ترتیب الگوریتم‌های ذیل بررسی می‌شوند:
#set par(leading: 1em, spacing: 1em)
- الگوریتم $"BLMS"$ که در سال 2017 ارائه شده است @biniaz2017approximation.
- الگوریتم $"LL"$ که در سال 2014 ارائه شده است @liu2014fast.
- الگوریتم $"DGT"$ که در سال 2018 ارائه شده است @dumitrescu2020online.
- الگوریتم $"FastCover"$ که در سال 2019 ارائه شده است @ghosh2019unit.
#set par(leading: 2em, spacing: 2em)

عنوان سه الگوریتم‌ اول، برگرفته از حرف اول نام پژوهشگران مربوط به آن است.

== الگوریتم $"BLMS"$

مجموعه $P$ را به‌عنوان مجموعه نقاط ورودی که در صفحه قرار دارند و $C^*$ را پوشش دیسک بهینه برای آن در نظر بگیرید. به‌خاطر داشته باشید که شعاع هر دیسک واحد برابر با 1 است.

#figure(
  kind: "definition",
  supplement: none,
  [
    در گراف تقاطع دیسک واحد#footnote[#text(dir: ltr)[Unit Disk Intersection Graph]] $"UDIG"(P)$ نقاط موجود در مجموعه $P$ رئوس را تشکیل می‌دهند و برای هر جفت $p,q in P$ یک یال وجود دارد اگر و تنها اگر $|p q| lt.eq 2$ باشد که $|p q|$ فاصله اقلیدسی بین $p$ و $q$ را نشان می‌دهد.
  ]
) <def:1>

#figure(
  kind: "observation",
  supplement: none,
  [
    برای دو نقطه $p,q in P$ ، اگر $(p,q) in.not "UDIG"(P)$ آنگاه $p$ و $q$ نمی‌توانند با یک دیسک واحد پوشش داده شوند.
  ]
) <ob:1>

#figure(
  kind: "definition",
  supplement: none,
  [
    یک مجموعه مستقل در $"UDIG"(P)$ ، زیرمجموعه‌ای مانند $I$ از مجموعه $P$ است، به‌طوری که هیچ یالی بین جفت نقطه‌های موجود در $I$ وجود ندارد. همچنین $I$ مجموعه مستقل حداکثری#footnote[#text(dir: ltr)[Maximal Independent Set]] نامیده می‌شود، اگر برای هر $p in P backslash I$ ، مجموعه $I union {p}$ در $"UDIG"(P)$ مستقل نباشد.
  ]
)

فرض کنید $I$ مجموعه مستقل حداکثری در $"UDIG"(P)$ باشد. طبق @ob:1 اندازه هر مجموعه مستقل در $"UDIG"(P)$ یک حد پایین#footnote[#text(dir: ltr)[Lower Bound]] برای تعداد دیسک‌های موردنیاز به‌منظور پوشش $P$ است. بنابراین خواهیم داشت:
$ |I| lt.eq |C^*| $ <eq:1>

مطابق @fig:f1 برای پوشش یک دیسک با شعاع 2 ، هفت دیسک واحد با شعاع 1 لازم و کافی است. بر همین اساس، یک الگوریتم با فاکتور تقریب 7 برای مسئله $"UDC"$ به‌دست می‌آید.

فرض کنید $I$ یک مجموعه مستقل حداکثری دلخواه در $"UDIG"(P)$ باشد. برای هر نقطه $p in I$ فرض کنید $D(p,2)$ یک دیسک با مرکزیت نقطه $p$ و شعاع 2 باشد. همچنین درنظر داشته باشید که $d(p)$ دیسک واحدی است که نقطه $p$ را پوشش می‌دهد. علاوه‌براین، تمام نقاطی که از مجموعه $P$ توسط $d(p)$ پوشش داده می‌شوند، در $D(p,2)$ وجود دارند. بنابراین با پوشش $D(p,2)$ به‌وسیله 7 دیسک واحد، به‌ازای همه $p in I$ ، الگوریتمی با فاکتور تقریب 7 حاصل می‌شود. باید توجه داشت که $"UDIG"(P)$ ممکن است حداکثر $O(n^2)$ یال داشته باشد. بنابراین پیچیدگی زمانی محاسبه $"UDIG"(P)$ در بدترین حالت درجه دو خواهد بود.

#figure(
  image("figs/f1.jpg", width: 40%),
  caption: [پوشش $D(p,2)$ با دیسک‌های واحد],
) <fig:f1>

در ادامه خواهید دید که چگونه می‌توان فاکتور تقریب را به 4 کاهش داد. $p$ را سمت چپ‌ترین نقطه در مجموعه $P$ درنظر بگیرید. در موارد خاص که مقادیر $x$ نقاط با هم برابر است، برای انتخاب سمت چپ‌ترین نقطه، کمتر بودن مقدار $y$ را ملاک قرار می‌دهیم. فرض کنید خط عمودی $l$ از نقطه $p$ عبور کند؛ $R(p)$ اشتراک $D(p,2)$ با نیم‌صفحه#footnote[#text(dir: ltr)[Half-plane]] سمت راست $l$ خواهد بود؛ یعنی $R(p)$ نیم‌دیسک سمت راست $D(p,2)$ است (مطابق @fig:f2).

همان‌طور که قبلاً هم توضیح داده شد، تمام نقاط مجموعه $P$ که با $d(p)$ پوشش داده شده‌اند، در $D(p,2)$ و به‌تبع آن در $R(p)$ نیز قرار دارند. مطابق @fig:f2، نیم‌دیسک $R(p)$ می‌تواند با 4 دیسک واحد پوشش داده شود. قسمت دوم شکل، حالتی از موقعیت قرار گرفتن 7 نقطه را نشان می‌دهد که برای پوشش آنها حداقل به 4 دیسک واحد نیاز است.

#figure(
  image("figs/f2.jpg", width: 30%),
  caption: [پوشش $R(p)$ با دیسک‌های واحد],
) <fig:f2>

برای نقطه‌ای مانند $p$ و مجموعه نقاط $I$ فاصله $d(p,I)$ برابر است با کمترین فاصله اقلیدسی بین $p$ و هر نقطه موجود در $I$ . اگر مجموعه $I$ تهی باشد، فاصله بینهایت درنظر گرفته می‌شود. @blms1، الگوریتم پیشنهادی با فاکتور تقریب 4 را نشان می‌دهد. خروجی آن، مجموعه‌ای از دیسک‌های واحد با نام $C$ است که مجموعه نقاط $P$ را پوشش می‌دهند. ابتدا لیستی از نقاط که از چپ به راست مرتب شده‌اند ایجاد می‌شود. سپس هردفعه اولین عنصر $p$ از لیست انتخاب و حذف می‌شود. اگر فاصله $d(p,I) lt.eq 2$ باشد، نشان‌دهنده این است که قبلاً نقطه $p$ توسط یکی از دیسک‌های مجموعه $C$ پوشش داده شده است. در غیر این صورت، نیم‌دیسک $R(p)$ با 4 دیسک واحد پوشش داده می‌شود و به مجموعه $C$ اضافه می‌شود. در نهایت مجموعه دیسک‌های واحد $C$ به‌عنوان خروجی حاصل می‌شود.

#figure(
  kind: "algorithm",
  supplement: [الگوریتم],
  caption: [نسخه اولیه $"BLMS"$],
  block(
    width: 100%,
    inset: 10pt,
    text(dir: ltr)[
      ```
      1: C = ∅
      2: I = ∅
      3: L = List of points in P sorted from left to right
      4: while L is not empty do
      5:     p = first element of L
      6:     if d(p,I) > 2 then
      7:         Cover R(p) by 4 unit disks c₁, c₂, c₃, c₄
      8:         C = C ∪ {c₁, c₂, c₃, c₄}
      9:         I = I ∪ {p}
      10:    end if
      11:    L = L - {p}
      12: end while
      13: return C
      ```
    ]
  )
) <blms1>

در هر تکرار @blms1 ، نقطه $p$ به مجموعه $I$ اضافه می‌شود، اگر و تنها اگر $d(p,I) > 2$ باشد. بنابراین $p$ در $"UDIG"(P)$ به هیچ نقطه‌ای از $I$ متصل نیست. همچنین بعد از خاتمه الگوریتم، $I$ یک مجموعه مستقل حداکثری خواهد بود.

#figure(
  kind: "theorem",
  supplement: none,
  [
    فاکتور تقریب @blms1 برای مسئله پوشش دیسک واحد، 4 است.
  ]
)

#proof[
  مجموعه نقاط $I$ و مجموعه دیسک‌های واحد $C$ را در پایان الگوریتم، درنظر بگیرید. براساس رابطه @eq:1 می‌دانیم که نامساوی $|I| lt.eq |C^*|$ برقرار است. به‌ازای نقاط $p in I$ هر نقطه $q in P$ در یک نیم‌دیسک $R(p)$ قرار دارد (ممکن است $q = p$ باشد). چون برای هر نقطه $p in I$ ، نیم‌دیسک $R(p)$ با 4 دیسک واحد پوشش داده می‌شود، مجموعه $C$ مجموعه $P$ را پوشش می‌دهد. بنابراین رابطه $|C| lt.eq 4|I| lt.eq 4|C^*|$ برقرار است.
]

پیچیدگی زمانی @blms1
$O(n log n + n dot t(d))$
است. $t(d)$ پیچیدگی زمانی محاسبه فاصله $d(p,I)$ را نشان می‌دهد. محاسبه این فاصله با پیچیدگی زمانی $O(log^2 n)$ قابل انجام است @bentley1980decomposable. بنابراین پیچیدگی نهایی الگوریتم، $O(log^2 n)$ است که در ادامه با استفاده از تکنیک جاروی صفحه، بهبود می‌یابد.

به‌جای محاسبه فاصله $d(p,I)$ کافی است بدانیم فاصله نقطه $p$ از مجموعه $I$ از 2 بیشتر است یا نه؛ یعنی به یک مسئله تصمیم‌گیری تبدیل شود. به‌تدریج که یک نقطه جدید مانند $p$ به مجموعه $I$ اضافه می‌شود، نقاط مجموعه $P$ که در نیم‌دیسک $R(p)$ قرار دارند، حذف می‌شوند. برهمین اساس، یک الگوریتم با استفاده از تکنیک جاروی صفحه و پیچیدگی زمانی $O(n log n)$ ارائه می‌شود.

در @blms2، ابتدا نقاط بر اساس مؤلفه $x$ از چپ به راست مرتب شده و در صف رخدادها درج می‌شوند. خط جارو به‌صورت عمودی از چپ به راست بر روی نقاط حرکت می‌کند. به هر نقطه که می‌رسد، اگر نقطه انتهایی یک نیم‌دیسک باشد، نقطه ابتدایی مربوط به آن نیم‌دیسک را از درخت وضعیت حذف می‌کند. در غیر این صورت، دو نقطه همسایه از بالا و دو نقطه همسایه از پایین را در درخت وضعیت برای این نقطه پیدا می‌کند. اگر فاصله آن با حداقل یکی از این 4 همسایه کمتر یا مساوی 2 باشد، به این معنا است که نقطه مورد نظر قبلاً در یک نیم‌دیسک قرار گرفته و تحت پوشش است و نیاز به اقدام خاصی نیست. در غیر این صورت، یک نیم‌دیسک به شعاع 2 و مرکز آن نقطه درنظر گرفته می‌شود و مرکز 4 دیسک واحد پوشش‌دهنده آن نیم‌دیسک محاسبه و به‌عنوان جواب گزارش می‌شود. سپس آن نقطه به‌عنوان نقطه ابتدایی نیم‌دیسک، در مکان مناسب خود در درخت وضعیت درج می‌شود. همچنین، نقطه انتهایی این نیم‌دیسک با اضافه کردن 2 واحد به مؤلفه $x$ مرکز آن، محاسبه شده و در جای مناسب در صف رخدادها درج می‌شود. لازم به ذکر است که درخت وضعیت، شامل نقاط ابتدایی نیم‌دیسک‌هایی است که در هر لحظه با خط جارو متقاطع‌اند و به‌صورت مرتب شده بر اساس مؤلفه $y$ از پایین به بالا قرار گرفته‌اند.

#figure(
  kind: "algorithm",
  supplement: [الگوریتم],
  caption: [نسخه بهبود یافته $"BLMS"$ با تکنیک جاروی صفحه],
  block(
    width: 100%,
    inset: 10pt,
    text(dir: ltr, size: 9pt)[
      ```
      1: Initialize an empty event queue Q. Insert the points in ascending
         order of their x-coordinates into Q.
      2: Initialize an empty BST status structure T.
      3: Initialize an empty list C.
      4: while Q is not empty do
      5:     Determine the next event point p in Q and delete it.
      6:     if p is an end-point then
      7:         Delete the start-point of the corresponding half-disk from T.
      8:     else
      9:         Find the 2 top and the 2 bottom neighbors of p in T.
      10:        if The distance between p and all of these 4 neighbors is
                    greater than 2 then
      11:            Calculate center points of the 4 unit disks which cover
                     half-disk of point p and insert them into C.
      12:            Insert p into T.
      13:            Insert the end-point q=(pₓ + 2, pᵧ) into Q.
      14:        end if
      15:    end if
      16: end while
      17: return C
      ```
    ]
  )
) <blms2>

== الگوریتم $"LL"$

در این الگوریتم، صفحه به نوار‌های عمودی با عرض $sqrt(3)$ تقسیم می‌شود. از هر نوار، یک جواب تقریبی با مرتب‌سازی نقاط براساس مؤلفه $y$ به‌صورت نزولی به‌دست می‌آید. نقطه بعدی درون یک نوار که هنوز پوشش داده نشده است، با قرار دادن یک دیسک در پایین‌ترین مکان ممکن، پوشش داده می‌شود. مرکز این دیسک‌ها، روی خطوط عمودی که نوارها را به دو قسمت تقسیم می‌کنند قرار می‌گیرد. جواب نهایی با اجتماع جوا‌ب همه نوارها حاصل می‌شود. این سامانه نواری، 5 مرتبه به سمت راست و هر دفعه به‌اندازه $sqrt(3) \/ 6$ شیفت داده می‌شود. در هر شیف، یک جواب به‌دست می‌آید. از بین این 6 جواب، آن جوابی که کمترین دیسک را استفاده کرده باشد به‌عنوان جواب نهایی درنظر گرفته می‌شود. جزئیات بیشتر در @alg:LL موجود است. فاکتور تقریب این الگوریتم $25\/6 approx 4.17$ است.

#figure(
  kind: "algorithm",
  supplement: [الگوریتم],
  caption: [محاسبه موقعیت دیسک‌های واحد با استفاده از $"LL"$],
  block(
    width: 100%,
    inset: 10pt,
    text(dir: ltr, size: 8pt)[
      ```
      1: Disk-Centers ← ∅, min ← n+1
      2: Sort P w.r.t x-coordinate in O(n log n) time
      3: for i ∈ {0,1,2,3,4,5} do
      4:     current ← 1, C ← ∅, right ← P[1]ₓ + (i√3)/6
      5:     while current ≤ n do
      6:         index ← current
      7:         while P[current]ₓ < right and current ≤ n do
      8:             current ← current + 1
      9:         end while
      10:        x-of-restriction-line ← right - √3/2, segments ← ∅
      11:        for j ← index to current-1 do
      12:            d ← P[j]ₓ - x-of-restriction-line, y ← √(1-d²)
      13:            Create a segment s having the endpoints
                     (x-of-restriction-line, P[j]ᵧ+y) and
                     (x-of-restriction-line, P[j]ᵧ-y) and insert it
                     into segments
      14:        end for
      15:        Sort segments in non-ascending order based on y-coordinates
                 of their tops. Greedily stab them by choosing the stabbing
                 point as low as possible, while still stabbing the topmost
                 unstabbed segment. Put the stabbing points (the disk centers)
                 in C
      16:        Increment right by a multiple of √3 such that
                 P[current] - right ≤ √3
      17:    end while
      18:    if |C| < min then
      19:        Disk-Centers ← C, min ← |C|
      20:    end if
      21: end for
      22: return Disk-Centers
      ```
    ]
  )
) <alg:LL>

== الگوریتم $"DGT"$

این الگوریتم، ساده و برخط است. به‌ازای هرنقطه‌ای که تاکنون تحت پوشش قرار نگرفته است، یک دیسک واحد به مرکز آن نقطه ایجاد می‌شود. فاکتور تقریب آن در صفحه، 5 است. در فضای با ابعاد $d$ دارای فاکتور تقریب $O(1.321^d)$ است. برای مشاهده توصیف سطح بالا، به @alg:DGT مراجعه نمایید.

#figure(
  kind: "algorithm",
  supplement: [الگوریتم],
  caption: [محاسبه موقعیت دیسک‌های واحد با استفاده از $"DGT"$],
  block(
    width: 100%,
    inset: 10pt,
    text(dir: ltr)[
      ```
      1: Disk-Centers ← ∅
      2: for p ∈ P do
      3:     if the distance from p to the nearest point in Disk-Centers is >1 then
      4:         Disk-Centers ← Disk-Centers ∪ {p}
      5:     end if
      6: end for
      7: return Disk-Centers
      ```
    ]
  )
) <alg:DGT>

== الگوریتم $"FastCover"$

در این الگوریتم، از یک شبکه#footnote[#text(dir: ltr)[Grid]] با مربع‌های به ضلع $sqrt(2)$ استفاده می‌شود. هر مربع از این شبکه، می‌تواند توسط یک دیسک به شعاع واحد محاط شود. به‌ازای هر نقطه، اگر توسط یکی از دیسک‌هایی که قبلاً قرار گرفته است تحت پوشش باشد، عملی انجام نمی‌شود؛ در غیر این صورت، یک دیسک واحد به مرکز مربعی که آن نقطه درونش قرار گرفته است، ایجاد می‌شود.

در پیاده‌سازی برای جستجوی سریع‌تر، از یک جدول درهم‌ساز#footnote[#text(dir: ltr)[Hash table]] استفاده می‌شود. در این جدول، مختصات مرکز دیسک‌هایی که اضافه شده‌اند ذخیره می‌شود. برای جلوگیری از مشکلات اعداد اعشاری، از یک جفت عدد صحیح برای نمایش مرکز هر دیسک استفاده می‌شود. مختصات حقیقی می‌تواند با ضرب کردن هر عدد صحیح در $sqrt(2)$ و اضافه کردن $sqrt(2) \/ 2 = 1 \/ sqrt(2)$ به آن به‌دست بیاید. برای به‌دست آوردن اعداد صحیح از روی یک نقطه، مؤلفه‌های $x,y$ آن بر $sqrt(2)$ تقسیم می‌شود. درواقع این اعداد صحیح، مربع مربوط به آن نقطه را در شبکه نشان می‌دهد. این فرآیند در @alg:fastcover قابل ملاحظه است.

این الگوریتم دارای فاکتور تقریب 7 و پیچیدگی زمانی $O(n)$ است. یک الگوریتم برخط به‌حساب می‌آید و هیچ پیش‌پردازشی مثل مرتب‌سازی روی نقاط انجام نمی‌دهد. به‌اندازه $O(s)$ حافظه اضافی مصرف می‌کند که $s$ نشان‌دهنده اندازه پوشش تولید شده است.

#figure(
  kind: "algorithm",
  supplement: [الگوریتم],
  caption: [محاسبه موقعیت دیسک‌های واحد با استفاده از $"FastCover"$],
  block(
    width: 100%,
    inset: 10pt,
    text(dir: ltr)[
      ```
      1: H ← ∅; Disk-Centers ← ∅
      2: for p ∈ P do
      3:     i ← ⌊pₓ/√2⌋; j ← ⌊pᵧ/√2⌋
      4:     if (i,j) ∉ H then
      5:         insert (i,j) into H and (√2·i + 1/√2, √2·j + 1/√2)
               into Disk-Centers
      6:     end if
      7: end for
      8: return Disk-Centers
      ```
    ]
  )
) <alg:fastcover>

این الگوریتم را می‌توان کمی بهبود داد. وقتی که یک نقطه در یک مربع از شبکه قرار می‌گیرد، ممکن است توسط 4 دیسک واحد که مربوط به مربع‌های همسایه است و قبلاً اضافه شده‌اند تحت پوشش باشد (مطابق @fig:f3). بنابراین بهتر است برای کاهش تعداد دیسک‌ها این شرایط نیز بررسی شود. در @alg:fastcoverplus جزئیات نسخه بهبودیافته ذکر شده است.

#figure(
  image("figs/f3.jpg", width: 40%),
  caption: [امکان پوشش یک نقطه با دیسک‌های مربع‌های همسایه],
) <fig:f3>

#figure(
  kind: "algorithm",
  supplement: [الگوریتم],
  caption: [محاسبه موقعیت دیسک‌های واحد با استفاده از $"FastCover+"$],
  block(
    width: 100%,
    inset: 10pt,
    text(dir: ltr, size: 7.5pt)[
      ```
      1: H ← ∅; Disk-Centers ← ∅
      2: for p ∈ P do
      3:     i ← ⌊pₓ/√2⌋; j ← ⌊pᵧ/√2⌋
      4:     if (i,j) ∈ H then
      5:         update B(i,j) using p   // p is already covered by D(i,j)
      6:     else if pₓ ≥ √2(i+1.5) - 1 and (i+1,j) ∈ H and
                  distance(p, (√2(i+1)+1/√2, √2·j+1/√2)) ≤ 1 then
      7:         continue   // p is covered by the grid-disk E placed before
      8:     else if pₓ ≤ √2(i-0.5) + 1 and (i-1,j) ∈ H and
                  distance(p, (√2(i-1)+1/√2, √2·j+1/√2)) ≤ 1 then
      9:         continue   // p is covered by the grid-disk W placed before
      10:    else if pᵧ ≥ √2(j+1.5) - 1 and (i,j+1) ∈ H and
                  distance(p, (√2·i+1/√2, √2(j+1)+1/√2)) ≤ 1 then
      11:        continue   // p is covered by the grid-disk N placed before
      12:    else if pᵧ ≤ √2(j-0.5) + 1 and (i,j-1) ∈ H and
                  distance(p, (√2·i+1/√2, √2(j-1)+1/√2)) ≤ 1 then
      13:        continue   // p is covered by the grid-disk S placed before
      14:    else
      15:        insert (i,j) into H and (√2·i + 1/√2, √2·j + 1/√2)
               into Disk-Centers
      16:    end if
      17: end for
      18: return Disk-Centers
      ```
    ]
  )
) <alg:fastcoverplus>

بهبود دیگری می‌توان روی الگوریتم اعمال نمود. اگر نقاط موجود در دو دیسک مجاور را بتوان با یک دیسک پوشش داد، یعنی قطر مجموعه نقاط هر دو دیسک کمتر از 2 باشد، می‌توان آن دو دیسک را ادغام نمود. برای ادغام، یک دیسک واحد به مرکز وسط قطر مجموعه نقاط درنظر گرفته می‌شود. برای اینکه محاسبه قطر، تأثیری روی پیچیدگی زمانی الگوریتم نداشته باشد، به‌همراه هر دیسک واحدی که ایجاد می‌شود، یک مستطیل مرزی نیز برای مجموعه نقاط موجود در آن نگهداری می‌شود. هر دفعه که یک نقطه جدید تحت پوشش یک دیسک واحد قرار می‌گیرد، ابعاد مستطیل مرزی مربوط به آن نیز بروزرسانی می‌شود. این بروزرسانی در $O(1)$ قابل انجام است. جزئیات بیشتر در @alg:fastcoverplusplus ذکر شده است.

#figure(
  kind: "algorithm",
  supplement: [الگوریتم],
  caption: [محاسبه موقعیت دیسک‌های واحد با استفاده از $"FastCover++"$],
  block(
    width: 100%,
    inset: 10pt,
    text(dir: ltr, size: 7pt)[
      ```
      1: H ← ∅; Disk-Centers ← ∅
      2: for p ∈ P do
      3:     i ← ⌊pₓ/√2⌋; j ← ⌊pᵧ/√2⌋
      4:     if (i,j) ∈ H then
      5:         update B(i,j) using p   // p is already covered by D(i,j)
      6:     else if pₓ ≥ √2(i+1.5) - 1 and (i+1,j) ∈ H and
                  distance(p, (√2(i+1)+1/√2, √2·j+1/√2)) ≤ 1 then
      7:         update B(i+1,j) using p  // p is covered by grid-disk E
      8:     else if pₓ ≤ √2(i-0.5) + 1 and (i-1,j) ∈ H and
                  distance(p, (√2(i-1)+1/√2, √2·j+1/√2)) ≤ 1 then
      9:         update B(i-1,j) using p  // p is covered by grid-disk W
      10:    else if pᵧ ≥ √2(j+1.5) - 1 and (i,j+1) ∈ H and
                  distance(p, (√2·i+1/√2, √2(j+1)+1/√2)) ≤ 1 then
      11:        update B(i,j+1) using p  // p is covered by grid-disk N
      12:    else if pᵧ ≤ √2(j-0.5) + 1 and (i,j-1) ∈ H and
                  distance(p, (√2·i+1/√2, √2(j-1)+1/√2)) ≤ 1 then
      13:        update B(i,j-1) using p  // p is covered by grid-disk S
      14:    else
      15:        insert (i,j) into H and initialize B(i,j) using p
      16:    end if
      17: end for
      18: while there is a grid-disk (i,j) ∈ H that is not considered yet do
      19:    if there is a grid disk (k,ℓ) ∈ H such that |i-k|≤1, |j-ℓ|≤1
               and the diagonal-length of the bounding-box
               B := B(i,j)∪B(k,ℓ) is at most 2 then
      20:        remove (i,j) and (k,ℓ) from H and add the center of B to
               Disk-Centers
      21:    end if
      22: end while
      23: for every grid-disk (i,j) ∈ H do
      24:    insert (√2·i + 1/√2, √2·j + 1/√2) into Disk-Centers
      25: end for
      26: return Disk-Centers
      ```
    ]
  )
) <alg:fastcoverplusplus>

= ارزیابی

همه الگوریتم‌ها با زبان $C++$ و کتابخانه $"CGAL"$ پیاده‌سازی شده‌اند. هرکدام از آنها بر روی 10 مجموعه‌نقطه دنیای واقعی اجرا شده‌اند. @tb:eval نتایج ارزیابی را نشان می‌دهد. هر الگوریتم، 5 بار بر روی هر مجموعه‌نقطه اجرا شده است. هر خانه کمترین تعداد دیسک و کمترین زمان پردازش برحسب ثانیه از بین این 5 اجرا را نشان می‌دهد. منظور از $"LL-1P"$ ، اجرای یک مرحله‌ای @alg:LL به‌جای شش مرحله است.

#figure(
  kind: table,
  caption: [نتایج ارزیابی الگوریتم‌ها],
  table(
    columns: 8,
    align: center,
    stroke: 0.5pt,
    text(dir: ltr, size: 7pt)[
      [], [LL], [LL-1P], [BLMS], [DGT], [FastCover], [FastCover+], [FastCover++],
      [birch3], [99989, 0.18], [99991, 0.03], [99994, 0.05], [99993, 0.07], [99996, 0.02], [99995, 0.02], [99980, 0.08],
      [monalisa], [100000, 0.15], [100000, 0.03], [100000, 0.11], [100000, 0.08], [100000, 0.02], [100000, 0.02], [100000, 0.08],
      [usa], [115475, 0.17], [115475, 0.04], [115475, 0.12], [115475, 0.09], [115475, 0.02], [115475, 0.03], [115475, 0.10],
      [KDDCU2D], [1147, 0.19], [1152, 0.04], [1692, 0.10], [1626, 0.01], [1418, 0.01], [1374, 0.01], [1257, 0.01],
      [europe], [168253, 0.35], [168271, 0.06], [168088, 0.19], [168069, 0.16], [168333, 0.03], [168277, 0.04], [167811, 0.20],
      [wildfires], [622, 3.74], [622, 0.88], [842, 1.21], [787, 0.12], [663, 0.04], [637, 0.04], [620, 0.06],
      [world], [6667, 2.84], [6680, 0.51], [9145, 0.79], [10980, 0.15], [7874, 0.03], [7576, 0.04], [6967, 0.07],
      [nyctaxi], [25, 13.84], [26, 3.09], [32, 2.90], [31, 0.13], [34, 0.05], [31, 0.05], [25, 0.10],
      [uber], [3, 21.06], [3, 4.75], [5, 4.03], [5, 0.19], [5, 0.06], [4, 0.06], [4, 0.16],
      [hail2015], [888, 39.83], [889, 9.82], [1193, 11.19], [1128, 0.74], [901, 0.28], [860, 0.28], [847, 0.42],
    ]
  )
) <tb:eval>

= نتیجه‌گیری

در مجموعه‌نقطه‌های دنیای واقعی، اگر معیار با اهمیت‌تر برای ارزیابی، تعداد دیسک‌های استفاده شده باشد، الگوریتم $"LL"$ عملکرد بهتری دارد. هرچند که الگوریتم $"FastCover"^(++)$ در برخی موارد، هم از لحاظ تعداد دیسک‌ها و هم زمان اجرا، عملکرد بهتری داشته است.

اگر معیار مهم‌تر، زمان اجرا باشد الگوریتم $"FastCover"$ عملکرد بهتری داشته است؛ اما چون تفاوت چندانی با نسخه بهبودیافته خود که تعداد دیسک‌های کمتری تولید می‌کند ندارد، استفاده از $"FastCover"^(++)$ پیشنهاد می‌شود.

اگر هردو معیار تعداد دیسک‌ها و زمان اجرا با اهمیت باشد، استفاده از الگوریتم $"FastCover"^(++)$ توصیه می‌شود؛ چرا که تعادل خوبی بین هردو معیار برقرار می‌کند @friederich2022experiments.

#pagebreak()

#heading(numbering: none)[مراجع]
#bibliography("etc/references.bib", style: "ieee")

#pagebreak()

#heading(numbering: none)[پیوست]

همان‌طور که در @tb:1 ملاحظه شد، بهترین الگوریتم‌هایی که تاکنون برای مسئله $"UDC"$ ارائه شده‌اند، دارای فاکتور تقریب 4 هستند. اینجانب، توجه زیادی به این مسئله با هدف بهبود فاکتور تقریب و نگارش مقاله نمودم. ایده‌های مختلفی برای بهبود فاکتور تقریب به ذهنم رسید که پس از بررسی‌های فراوان متوجه شدم برخی از آنها اشتباه است و برخی دیگر را به‌دلیل کمبود زمان نتوانستم به‌طور دقیق بررسی کنم. در ادامه تعدادی از آنها را بیان می‌کنم.

ایده اول، با هدف کاهش فاکتور تقریب از 4 به 3 بود. در @fig:f2 نشان داده شد که برای پوشش یک نیم‌دیسک به شعاع 2، دقیقاً به 4 دیسک واحد احتیاج است. بر اساس این شکل، برای پوشش یک ربع‌دیسک نیز دقیقاً به 3 دیسک واحد احتیاج است. با فرض اینکه اشتراک دو نیم‌دیسک به شعاع 2 حداکثر با یک ربع‌دیسک قابل پوشش است، می‌توان یک‌بار مطابق @blms2 خط جارو را از چپ به راست و بار دیگر از بالا به پایین حرکت داد. طی این دو مرحله، تعدادی نیم‌دیسک حاصل می‌شود. نواحی از نیم‌دیسک‌ها که با یکدیگر هم‌پوشانی پیدا می‌کنند (اشتراک نیم‌دیسک‌ها) مواردی است که لازم است با دیسک‌های واحد پوشش داده شود. پس از بررسی مشخص شد که این ایده عملی نیست. چون فرض اولیه اشتباه است و حالت‌هایی وجود دارد که اشتراک دو نیم‌دیسک بیشتر از حد تصور می‌شود و نمی‌توان آن را با یک ربع‌دیسک پوشش داد (مطابق @fig:app1).

#figure(
  image("figs/app1.png", width: 30%),
  caption: [عدم امکان پوشش اشتراک دو نیم‌دیسک با ربع‌دیسک],
) <fig:app1>

ایده دوم نیز با هدف کاهش فاکتور تقریب از 4 به 3 بود. به‌جای نیم‌دیسک‌های با شعاع 2، ربع‌دیسک‌هایی به شعاع 2 درنظر گرفته می‌شود که هرکدام با 3 دیسک واحد قابل پوشش هستند. در @alg:app1 جزئیات ایده بیان شده است. در این الگوریتم، خط جارو از بالا به پایین بر روی نقاط حرکت می‌کند. پس از بررسی، مشخص شد که این ایده نیز، عملی نیست. زیرا مانند @fig:app2 حالت‌هایی وجود دارد که ربع‌دیسک‌های زیادی با یکدیگر همپوشانی پیدا می‌کنند و در نهایت فاکتور تقریب، $O(n)$ می‌شود.

#figure(
  kind: "algorithm",
  supplement: [الگوریتم],
  caption: [ایده دوم برای کاهش فاکتور تقریب به 3],
  block(
    width: 100%,
    inset: 10pt,
    text(dir: ltr, size: 8pt)[
      ```
      1: Initialize an empty event queue Q. Insert the points in descending
         order of their y-coordinates into Q. If two points have the same
         y-coordinate, the one with smaller x-coordinate has higher priority.
      2: Initialize an empty BST status structure T.
      3: Initialize an empty list C.
      4: while Q is not empty do
      5:     Determine the next event point p in Q and delete it.
      6:     if p is an end-point then
      7:         Delete the start-point of the corresponding quarter disk from T.
      8:     else
      9:         Find the two left neighbors p', p'' of p in T. If p has the
               same x-coordinate with a point in T, consider the point with the
               higher y-coordinate as the left.
      10:        if |pp'| > 2 and |pp''| > 2 then
      11:            Calculate center points of the 3 unit disks which cover
                     quarter disk of point p and insert them into C.
      12:            Insert p into T.
      13:            Insert the end-point q=(pₓ, pᵧ + 2) into Q.
      14:        end if
      15:    end if
      16: end while
      17: return C
      ```
    ]
  )
) <alg:app1>

#figure(
  image("figs/app2.png", width: 25%),
  caption: [حالتی که ربع‌دیسک‌های زیادی همپوشانی پیدا می‌کنند],
) <fig:app2>
