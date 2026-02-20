// Persian Academic Report Template

#let header-page(
  title: none,
  course: none,
  author: none,
  organization: none,
  date: none,
) = {
  // Header uses tight lines — matching LaTeX \fontsize{10pt}{10pt} (no extra leading)
  set par(leading: 0.15em)
  grid(
    columns: (auto, 1fr, auto),
    align: (left + horizon, center + horizon, right + horizon),
    column-gutter: 6pt,
    image("../etc/aut.png", width: 2cm),
    align(center)[
      #set text(size: 10pt)
      #set par(leading: 0.15em)
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
  v(0.3cm)
  line(length: 100%, stroke: 1pt)
}

// Abstract environment matching LaTeX article \begin{abstract}
// LaTeX abstract: single-spacing, indented block, centered bold "چکیده"
#let abstract-block(body) = {
  v(0.3em)
  align(center)[
    #text(weight: "bold", size: 12pt)[چکیده]
  ]
  v(0.2em)
  // LaTeX abstract is singlespaced (\singlespacing inside abstract env)
  {
    set par(justify: true, leading: 0.55em)
    pad(left: 3em, right: 3em, body)
  }
  v(0.8em)
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
    numbering: "1",
  )
  // LaTeX: 12pt font with Scale=1.2 for B Nazanin → effectively 14.4pt visual
  // We use 12pt to match the nominal size; B Nazanin scales similarly
  set text(
    font: ("B Nazanin", "Times New Roman"),
    size: 12pt,
    lang: "fa",
    dir: rtl,
  )
  // LaTeX \doublespacing at 12pt: baseline skip ≈ 12pt*1.2*2 ≈ 28.8pt ≈ 2.4em
  // In practice setspace \doublespacing = 1.667× strut = 1.667 × 14.4pt ≈ 24pt = 2em
  set par(justify: true, leading: 1.6em)

  // Heading styles — matching LaTeX article \section / \subsection
  set heading(numbering: "1")
  show heading.where(level: 1): it => {
    v(0.35cm)
    text(size: 16pt, weight: "bold")[#it]
    v(0.15cm)
  }
  show heading.where(level: 2): it => {
    v(0.25cm)
    text(size: 14pt, weight: "bold")[#it]
    v(0.05cm)
  }

  // Figure supplements in Persian
  set figure(supplement: "شکل")
  show figure.where(kind: table): set figure(supplement: "جدول")
  show figure.where(kind: "algorithm"): set figure(supplement: "الگوریتم")

  // Algorithm format perfectly mimicking LaTeX 'ruled' style
  show figure.where(kind: "algorithm"): it => {
    v(0.5em)
    line(length: 100%, stroke: 1pt)
    v(0.3em)
    align(right)[#it.caption]
    v(0.3em)
    line(length: 100%, stroke: 0.5pt)
    it.body
    line(length: 100%, stroke: 1pt)
    v(0.5em)
  }

  // Tables: caption BELOW body (matching LaTeX table environment)
  show figure.where(kind: table): it => {
    it.body
    v(0.3em)
    align(center)[#it.caption]
  }

  // Default table style: no strokes (each table adds its own hlines)
  set table(stroke: none, inset: (x: 8pt, y: 4pt))

  // Equation numbering
  set math.equation(numbering: "(1)", supplement: "رابطه")

  // Links in black
  show link: set text(fill: black)

  // Suppress default figure rendering for theorem-kind; just show the body
  show figure.where(kind: "theorem-kind"): it => it.body

  // Bibliography must render in LTR/EN so IEEE numbers are Arabic not Persian
  show bibliography: set text(lang: "en", dir: ltr)

  // Footnotes rendered LTR
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
