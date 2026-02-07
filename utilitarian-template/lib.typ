// Utilitarian Template
// A function-first, clean, and direct document template
// Military-industrial aesthetics with grid layout, monospaced fonts, and muted tones

// ============================================================================
// COLOR PALETTE - Muted, industrial tones
// ============================================================================

#let util-charcoal = rgb("#2C2C2C")      // Primary text, headings
#let util-slate = rgb("#64748B")          // Secondary text, metadata
#let util-warm-gray = rgb("#F5F5F0")      // Background accents
#let util-accent = rgb("#B8860B")         // Sparse accent (dark goldenrod)
#let util-grid-line = rgb("#D4D4D4")      // Grid lines, borders
#let util-black = rgb("#1A1A1A")          // Deep black for emphasis

// ============================================================================
// TYPOGRAPHY
// ============================================================================

#let mono-font = ("JetBrains Mono", "Consolas", "Courier New")
#let body-font = ("Inter", "Roboto", "Arial")

// ============================================================================
// UTILITY FUNCTIONS
// ============================================================================

/// Create a minimal horizontal rule
#let util-rule(width: 100%, weight: 0.5pt) = {
  line(length: width, stroke: weight + util-grid-line)
}

/// Create a labeled data field (key: value layout)
#let util-field(label, value) = {
  grid(
    columns: (auto, 1fr),
    gutter: 1em,
    text(font: mono-font, size: 8pt, fill: util-slate, tracking: 0.05em, upper(label)),
    text(font: body-font, size: 10pt, fill: util-charcoal, value),
  )
}

/// Minimal table with grid aesthetics
#let util-table(columns: auto, ..cells) = {
  set table(
    stroke: 0.5pt + util-grid-line,
    inset: 8pt,
    align: left + horizon,
  )
  show table.cell.where(y: 0): set text(
    font: mono-font,
    size: 8pt,
    fill: util-slate,
    tracking: 0.05em,
    weight: "regular",
  )
  show table.cell.where(y: 0): upper
  
  table(columns: columns, ..cells)
}

/// Code block with minimal styling
#let util-code(lang: none, code) = {
  block(
    width: 100%,
    inset: 12pt,
    fill: util-warm-gray,
    radius: 0pt,
    text(font: mono-font, size: 9pt, fill: util-charcoal, code)
  )
}

/// Callout box for important notes
#let util-note(body) = {
  block(
    width: 100%,
    inset: (left: 12pt, y: 8pt, right: 8pt),
    stroke: (left: 2pt + util-accent),
    text(font: body-font, size: 10pt, fill: util-charcoal, body)
  )
}

// ============================================================================
// MAIN DOCUMENT TEMPLATE
// ============================================================================

#let utilitarian-doc(
  title: "DOCUMENT TITLE",
  subtitle: none,
  author: none,
  date: none,
  version: none,
  document-id: none,
  language: "en",
  toc: true,
  toc-depth: 3,
  body,
) = {
  // Document metadata
  set document(
    title: title,
    author: if author != none { (author,) } else { () },
  )
  
  // Page setup - Grid-friendly margins
  set page(
    paper: "a4",
    margin: (
      top: 3cm,
      bottom: 2.5cm,
      left: 2.5cm,
      right: 2.5cm,
    ),
    header: context {
      if counter(page).get().first() > 1 {
        grid(
          columns: (1fr, auto),
          align: (left, right),
          text(font: mono-font, size: 7pt, fill: util-slate, tracking: 0.1em, upper(title)),
          text(font: mono-font, size: 7pt, fill: util-slate, 
            if document-id != none { document-id } else { "" }
          ),
        )
        v(4pt)
        line(length: 100%, stroke: 0.5pt + util-grid-line)
      }
    },
    footer: context {
      line(length: 100%, stroke: 0.5pt + util-grid-line)
      v(4pt)
      grid(
        columns: (1fr, auto, 1fr),
        align: (left, center, right),
        text(font: mono-font, size: 7pt, fill: util-slate,
          if version != none { "v" + version } else { "" }
        ),
        text(font: mono-font, size: 8pt, fill: util-charcoal, 
          str(counter(page).get().first())
        ),
        text(font: mono-font, size: 7pt, fill: util-slate,
          if date != none { date } else { datetime.today().display("[year]-[month]-[day]") }
        ),
      )
    },
    numbering: "1",
  )
  
  // Text defaults
  set text(
    font: body-font,
    size: 10pt,
    fill: util-charcoal,
    lang: language,
  )
  
  // Paragraph styling
  set par(
    justify: true,
    leading: 0.8em,
    first-line-indent: 0pt,
  )
  
  // Heading styles - Uppercase, monospaced, letterspaced
  set heading(numbering: "1.1")
  
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(1.5cm)
    block(
      text(
        font: mono-font,
        size: 14pt,
        weight: "bold",
        fill: util-black,
        tracking: 0.15em,
      )[
        #if it.numbering != none {
          counter(heading).display(it.numbering)
          h(0.4em)
          sym.bar.v
        }
        #upper(it.body)
      ]
    )
    v(0.8cm)
  }
  
  show heading.where(level: 2): it => {
    v(0.8cm)
    block(
      text(
        font: mono-font,
        size: 11pt,
        weight: "medium",
        fill: util-charcoal,
        tracking: 0.1em,
      )[
        #if it.numbering != none {
          counter(heading).display(it.numbering)
          h(0.4em)
          sym.bar.v
        }
        #upper(it.body)
      ]
    )
    v(0.4cm)
  }
  
  show heading.where(level: 3): it => {
    v(0.5cm)
    block(
      text(
        font: mono-font,
        size: 10pt,
        weight: "regular",
        fill: util-slate,
        tracking: 0.08em,
      )[
        #if it.numbering != none {
          counter(heading).display(it.numbering)
          h(0.5em)
          sym.bar.v
          h(0.5em)
        }
        #upper(it.body)
      ]
    )
    v(0.3cm)
  }
  
  show heading.where(level: 4): it => {
    v(0.4cm)
    block(
      text(
        font: body-font,
        size: 10pt,
        weight: "semibold",
        fill: util-charcoal,
        it.body
      )
    )
    v(0.2cm)
  }
  
  // Link styling
  show link: it => {
    text(fill: util-accent, it)
  }
  
  // Raw/code inline styling
  show raw.where(block: false): it => {
    box(
      fill: util-warm-gray,
      inset: (x: 3pt, y: 1pt),
      radius: 1pt,
      text(font: mono-font, size: 9pt, it)
    )
  }
  
  // Code block styling
  show raw.where(block: true): it => {
    block(
      width: 100%,
      fill: util-warm-gray,
      inset: 12pt,
      radius: 0pt,
      text(font: mono-font, size: 9pt, fill: util-charcoal, it)
    )
  }
  
  // Figure styling
  show figure.caption: it => {
    text(font: mono-font, size: 8pt, fill: util-slate, tracking: 0.03em, upper(it))
  }
  
  // ============================================================================
  // COVER PAGE
  // ============================================================================
  
  // Minimal grid overlay visual
  place(
    top + right,
    dx: -2cm,
    dy: 2cm,
    rect(
      width: 1cm,
      height: 20cm,
      fill: util-warm-gray,
    )
  )
  
  v(4cm)
  
  // Document ID / Classification
  if document-id != none {
    text(font: mono-font, size: 8pt, fill: util-slate, tracking: 0.2em, upper(document-id))
    v(0.5cm)
  }
  
  // Title block
  block(
    text(
      font: mono-font,
      size: 24pt,
      weight: "bold",
      fill: util-black,
      tracking: 0.1em,
      upper(title)
    )
  )
  
  if subtitle != none {
    v(0.3cm)
    block(
      text(
        font: body-font,
        size: 12pt,
        fill: util-slate,
        subtitle
      )
    )
  }
  
  v(2cm)
  util-rule()
  v(1cm)
  
  // Metadata grid
  if author != none or date != none or version != none {
    grid(
      columns: (1fr, 1fr),
      row-gutter: 0.8em,
      if author != none { util-field("Author", author) },
      if version != none { util-field("Version", version) },
      if date != none { util-field("Date", date) } else { util-field("Date", datetime.today().display("[year]-[month]-[day]")) },
      [],
    )
  }
  
  pagebreak()
  
  // ============================================================================
  // TABLE OF CONTENTS
  // ============================================================================
  
  if toc {
    heading(outlined: false, numbering: none, 
      text(font: mono-font, size: 14pt, weight: "bold", fill: util-black, tracking: 0.15em, "CONTENTS")
    )
    v(1cm)
    
    show outline.entry.where(level: 1): it => {
      v(0.3em)
      strong(it)
    }
    
    outline(
      title: none,
      depth: toc-depth,
      indent: 1.5em,
    )
    
    pagebreak()
  }
  
  // ============================================================================
  // BODY CONTENT
  // ============================================================================
  
  body
}
