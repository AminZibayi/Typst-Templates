
// Mixed Media Template
// A collage-style, experimental, and texture-rich document template

// ============================================================================
// COLOR PALETTE
// ============================================================================

#let mm-paper = rgb("#F0E6D2")        // Base paper color (if texture fails)
#let mm-charcoal = rgb("#2F2F2F")     // Primary text
#let mm-ink = rgb("#1a1a1a")          // Deep black for contrast
#let mm-red = rgb("#D9534F")          // Accent/stamp color
#let mm-blue = rgb("#5BC0DE")         // Tape/highlight color
#let mm-pencil = rgb("#555555")       // Secondary text

// ============================================================================
// TYPOGRAPHY
// ============================================================================

#let body-font = ("EB Garamond", "Georgia", "serif")
#let heading-font = ("Oswald", "Impact", "sans-serif")
#let hand-font = ("Patrick Hand", "Caveat", "cursive")
#let mono-font = ("Courier Prime", "Courier New", "monospace")

// ============================================================================
// ASSETS
// ============================================================================

#let texture-paper = "assets/paper-texture.png"
#let texture-torn = "assets/torn-edge.png"
#let texture-stamps = "assets/collage-stamps.png"

// ============================================================================
// UTILITY FUNCTIONS
// ============================================================================

/// Renders a "torn paper" tape effect
#let tape(body, color: mm-blue, rotation: -2deg) = {
  rotate(rotation)[
    #box(
      fill: color.lighten(30%),
      inset: (x: 10pt, y: 5pt),
      radius: 2pt,
      stroke: (paint: color.darken(10%), thickness: 0.5pt, dash: "dotted"),
    )[
      #text(fill: mm-ink, font: hand-font, weight: "bold", body)
    ]
  ]
}

/// Renders a text box that looks like a cut-out piece of paper
#let paper-cutout(body, fill: white, rotation: 1deg) = {
  rotate(rotation)[
    #block(
      fill: fill,
      inset: 16pt,
      outset: 2pt,
      radius: 1pt,
      stroke: (paint: black.lighten(60%), thickness: 0.5pt),
    )[
      #body
    ]
  ]
}

/// Adds a background texture to the page
#let background-texture() = {
  place(top + left, rect(width: 100%, height: 100%, fill: mm-paper))
  // place(top + left, image(texture-paper, width: 100%, height: 100%, fit: "cover"))
}

// ============================================================================
// MAIN DOCUMENT TEMPLATE
// ============================================================================

#let mixed-media-doc(
  title: "Mixed Media Report",
  subtitle: none,
  author: none,
  date: none,
  body
) = {
  
  // Document setup
  set document(title: title, author: if author != none { (author,) } else { () })
  
  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 3cm),
    background: background-texture(),
    header: context {
      if counter(page).get().first() > 1 {
        set text(font: mono-font, size: 9pt, fill: mm-pencil)
        grid(
          columns: (1fr, auto),
          align: (bottom + left, bottom + right),
          upper(title),
          counter(page).display("1 / 1")
        )
        v(5pt)
        line(length: 100%, stroke: 0.5pt + mm-pencil)
      }
    }
  )

  // Typography setup
  set text(font: body-font, size: 11pt, fill: mm-charcoal)
  set par(justify: true, leading: 0.8em)

  // Heading styling - Mixed and expressive
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(1.5cm)
    set align(center)
    rotate(-1deg)[
      #block(
        fill: mm-charcoal,
        inset: 18pt,
        radius: 2pt,
        stroke: 2pt + mm-ink
      )[
        #text(font: heading-font, size: 22pt, fill: white, weight: "bold", upper(it.body))
      ]
    ]
    v(1cm)
  }

  show heading.where(level: 2): it => {
    v(1cm)
    grid(
      columns: (auto, 1fr),
      gutter: 10pt,
      move(dy: 4pt)[
        #box(fill: mm-red, width: 8pt, height: 8pt, radius: 4pt)
      ],
      text(font: heading-font, size: 16pt, weight: "bold", fill: mm-ink, it.body)
    )
    v(0.5cm)
  }

  show heading.where(level: 3): it => {
    v(0.5cm)
    text(font: mono-font, size: 12pt, weight: "bold", fill: mm-red, upper(it.body))
    v(0.3cm)
  }

  // Raw text / Code block styling - Typewriter style
  show raw: it => {
    if it.block {
      block(
        fill: white.darken(5%),
        inset: 12pt,
        stroke: (left: 4pt + mm-pencil),
        width: 100%,
        text(font: mono-font, size: 10pt, it)
      )
    } else {
      box(
        fill: white.darken(10%),
        outset: (y: 2pt),
        inset: (x: 2pt),
        radius: 2pt,
        text(font: mono-font, size: 0.9em, it)
      )
    }
  }

  show quote: it => {
    align(center)[
      #block(width: 80%)[
        #set text(font: hand-font, size: 14pt, fill: mm-pencil)
        #it
      ]
    ]
  }

  // ============================================================================
  // TITLE PAGE
  // ============================================================================

  // Title page content
  v(3cm)
  
  align(center)[
    #rotate(2deg)[
      #block(
        stroke: 3pt + mm-charcoal,
        inset: 2em,
        fill: white.transparentize(10%),
      )[
        #text(font: heading-font, size: 36pt, weight: "black", fill: mm-ink, title)
        #if subtitle != none {
          parbreak()
          v(0.5em)
          text(font: hand-font, size: 20pt, fill: mm-red, subtitle)
        }
      ]
    ]
  ]

  v(2fr)

  if author != none or date != none {
    align(center)[
      #rotate(-1deg)[
         #box(
           fill: black,
           inset: 1em,
         )[
           #set text(fill: white, font: mono-font)
           #if author != none {
             upper(author) 
             if date != none { " | " }
           }
           #if date != none {
             date
           }
         ]
      ]
    ]
  }
  
  v(2cm)
  
  // Decorative stamp at bottom
  place(bottom + right, dx: -1cm, dy: -1cm)[
    #rotate(-15deg)[
      #text(font: mono-font, size: 50pt, fill: mm-ink.transparentize(80%), weight: "bold")[DRAFT]
    ]
  ]

  pagebreak()

  // ============================================================================
  // CONTENT BODY
  // ============================================================================

  body
}
