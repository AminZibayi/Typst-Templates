// Persian Academic Report Template

#let header-page(
  title: none,
  course: none,
  author: none,
  organization: none,
  date: none,
) = {
  grid(
    columns: (1fr, 6fr, 1fr),
    align: (left, center, right),
    gutter: 0pt,
    image("../etc/aut.png", width: 2cm),
    align(center)[
      #set text(size: 10pt)
      به‌نام خدا \
      #title \
      #course \
      #author
      #v(0.25cm)
      #set text(size: 8pt)
      #organization \
      #date
    ],
    image("../etc/ce.png", width: 1.8cm),
  )
  v(0.5cm)
  line(length: 100%, stroke: 1pt)
}

#let template(
  title: "پوشش دیسک واحد",
  course: "نام درس",
  author: "نام و نام خانوادگی",
  organization: "دانشگاه صنعتی امیرکبیر، دانشکده مهندسی کامپیوتر",
  date: "خردادماه 1401",
  body,
) = {
  set document(title: title, author: author)
  set page(
    paper: "a4",
    margin: (top: 25mm, bottom: 30mm, left: 25mm, right: 25mm),
  )
  set text(
    font: ("B Nazanin", "Times New Roman"),
    size: 12pt,
    lang: "fa",
    dir: rtl,
  )
  set par(justify: true, leading: 1.35em)

  set heading(numbering: "1")
  show heading.where(level: 1): it => {
    v(0.35cm)
    it
    v(0.2cm)
  }
  show heading.where(level: 2): it => {
    v(0.25cm)
    it
    v(0.1cm)
  }
  set figure(supplement: "شکل")
  show figure.where(kind: table): set figure(supplement: "جدول")
  show figure.where(kind: "algorithm"): set figure(supplement: "الگوریتم")
  set math.equation(numbering: "(1)")
  show link: set text(fill: black)
  show footnote.entry: it => {
    align(left)[
      #set text(lang: "en", dir: ltr, size: 8pt)
      #it
    ]
  }

  header-page(
    title: title,
    course: course,
    author: author,
    organization: organization,
    date: date,
  )

  body
}

#let latin(body) = text(lang: "en", dir: ltr)[#body]
