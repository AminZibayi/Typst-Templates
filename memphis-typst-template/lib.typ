// memphis-typst-template/lib.typ

// ============================================================================
// 1. COLORS & PALETTE (High Contrast, 80s Style)
// ============================================================================
#let memphis-pink = rgb("#E5007D")
#let memphis-blue = rgb("#2F5496") // Deep blue from FHICT, adapted
#let memphis-cyan = rgb("#00FFFF")
#let memphis-yellow = rgb("#FFD700")
#let memphis-black = rgb("#000000")
#let memphis-white = rgb("#FFFFFF")
#let memphis-purple = rgb("#663366") // Kept for some depth
#let memphis-grey = rgb("#F0F0F0")

// ============================================================================
// 2. HELPER SHAPES & PATTERNS
// ============================================================================

// A simple squiggle pattern using SVG
#let squiggle-pattern(color: memphis-pink) = {
  box(
    width: 100%,
    height: 10pt,
    fill: tiling(size: (20pt, 10pt))[
      #place(line(start: (0pt, 5pt), end: (10pt, 0pt), stroke: 2pt + color))
      #place(line(start: (10pt, 0pt), end: (20pt, 5pt), stroke: 2pt + color))
    ]
  )
}

// A confetti background pattern
#let confetti-background() = {
  place(top + left, rect(width: 100%, height: 100%, fill: memphis-white))
  // We can add random shapes here if we want, but for now a clean white with 
  // maybe a grid overlay might be better for readability.
  // Let's try a subtle grid.
  place(top + left, rect(width: 100%, height: 100%, fill: tiling(size: (20pt, 20pt))[
    #place(circle(radius: 1pt, fill: memphis-grey))
  ]))
}

// ============================================================================
// 3. CONTENT BLOCKS
// ============================================================================

// Custom Text Box with Drop Shadow (Offset Box)
#let memphis-box(body, title: none, color: memphis-yellow) = {
  block(
    width: 100%,
    breakable: false,
    {
      // The shadow box
      place(
        dx: 4pt,
        dy: 4pt,
        rect(width: 100%, height: 100%, fill: memphis-black, stroke: none)
      )
      // The main box
      rect(
        width: 100%,
        fill: color,
        stroke: 2pt + memphis-black,
        inset: 1em,
        radius: 0pt,
        {
          if title != none {
            block(below: 0.5em, text(weight: "bold", size: 1.1em, font: "Bauhaus 93", title))
          }
          body
        }
      )
    }
  )
}

// Zebra Striped Table with Memphis Colors
#let memphis-table(..args) = {
  let cell-fill(x, y) = {
    if y == 0 { memphis-pink } // Header
    else if calc.even(y) { memphis-yellow.lighten(80%) }
    else { memphis-cyan.lighten(80%) }
  }
  
  show table.cell.where(y: 0): set text(fill: memphis-white, weight: "bold", font: "Bauhaus 93")
  
  table(
    fill: cell-fill,
    stroke: 2pt + memphis-black,
    inset: 10pt,
    ..args
  )
}

// ============================================================================
// 4. MAIN TEMPLATE FUNCTION
// ============================================================================
#let memphis-doc(
  title: "MEMPHIS REPORT",
  subtitle: none,
  author: "Author Name",
  date: datetime.today(),
  version: "1.0",
  toc-depth: 3,
  body
) = {
  
  // Set Metadata
  set document(title: title, author: author)
  
  // --------------------------------------------------------------------------
  // TYPOGRAPHY CONFIGURATION
  // --------------------------------------------------------------------------
  set text(font: "Century Gothic", size: 11pt, fill: memphis-black)
  
  // Headings
  show heading: it => {
    set text(font: "Bauhaus 93", fill: memphis-black)
    block(above: 1.5em, below: 1em)[
      #if it.level == 1 {
         // H1: Big, Pink Background, Shadow
         box(
           fill: memphis-pink,
           inset: 10pt,
           radius: 0pt,
           stroke: 2pt + memphis-black,
           text(fill: memphis-white, size: 24pt, it.body)
         )
         // Add a decorative squiggle below H1
         v(0.5em)
         line(length: 100%, stroke: 4pt + memphis-blue)
      } else if it.level == 2 {
         // H2: Blue Text, Underline
         text(fill: memphis-blue, size: 18pt, it.body)
         v(-0.5em)
         line(length: 100%, stroke: 2pt + memphis-yellow)
      } else {
         // Others
         text(fill: memphis-black, size: 14pt, it.body)
      }
    ]
  }
  
  // Lists with Geometric Bullets
  set list(marker: (
    box(width: 0.8em, height: 0.8em, fill: memphis-pink, stroke: 1pt + memphis-black), // Square
    box(width: 0.8em, height: 0.8em, radius: 0.4em, fill: memphis-cyan, stroke: 1pt + memphis-black), // Circle
    text("►", fill: memphis-yellow) // Triangle-ish
  ))
  
  // Links
  show link: it => text(fill: memphis-blue, weight: "bold", underline(it))
  
  // Raw Code Blocks
  show raw.where(block: true): it => {
    block(
      width: 100%,
      fill: memphis-black,
      inset: 10pt,
      stroke: 2pt + memphis-pink,
      text(fill: memphis-cyan, font: "Space Mono", it)
    )
  }
  show raw.where(block: false): it => {
    box(fill: memphis-grey, inset: 2pt, radius: 2pt, text(font: "Space Mono", it))
  }
  
  // --------------------------------------------------------------------------
  // PAGE CONFIGURATION
  // --------------------------------------------------------------------------
  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 3cm),
    background: confetti-background(),
    
    // Header
    header: context {
      // Don't show header on FIRST page (Cover)
      if counter(page).get().at(0) > 1 {
         grid(
           columns: (1fr, auto),
           align: horizon,
           text(title, font: "Bauhaus 93", fill: memphis-purple),
           text(date.display(), style: "italic")
         )
         line(length: 100%, stroke: 2pt + memphis-pink)
      }
    },
    
    // Footer
    footer: context {
      if counter(page).get().at(0) > 1 {
         align(center)[
           // Rotated Square for Page Number
           #box(
             width: 20pt, height: 20pt,
             fill: memphis-yellow,
             stroke: 1pt + memphis-black,
             rotate(45deg, reflow: true)[
               #place(center + horizon, rotate(-45deg, text(counter(page).display(), weight: "bold")))
             ]
           )
         ]
      }
    }
  )
  
  // --------------------------------------------------------------------------
  // COVER PAGE
  // --------------------------------------------------------------------------
  // We use `place` to put geometric shapes absolutely
  {
    set page(margin: 0pt, header: none, footer: none)
    
    // Background Split
    place(top + left, rect(width: 100%, height: 50%, fill: memphis-yellow))
    place(bottom + left, rect(width: 100%, height: 50%, fill: memphis-blue))
    
    // Big Triangle
    place(
        center + horizon,
        polygon(
            fill: memphis-pink,
            stroke: 3pt + memphis-black,
            (0pt, -200pt), (200pt, 200pt), (-200pt, 200pt)
        )
    )
    
    // Title Box (Centered, huge)
    place(center + horizon, dy: -50pt, {
        block(
             fill: memphis-white,
             stroke: 4pt + memphis-black,
             inset: 20pt,
             radius: 10pt,
             align(center)[
                 #text(size: 40pt, font: "Bauhaus 93", fill: memphis-black, upper(title))
                 #v(10pt)
                 #if subtitle != none {
                     text(size: 20pt, font: "Century Gothic", fill: memphis-purple, subtitle)
                 }
             ]
        )
    })
    
    // Author & Info at bottom
    place(bottom + center, dy: -50pt, {
        text(size: 16pt, fill: memphis-white, weight: "bold")[
            #author \
            #date.display()
        ]
    })
    
    // Decorative Circle
    place(top + right, dx: -50pt, dy: 50pt, circle(radius: 40pt, fill: memphis-cyan, stroke: 2pt + memphis-black))
    
    // Decorative Lines
    place(bottom + left, dx: 50pt, dy: -300pt, rotate(15deg, rect(width: 10pt, height: 100pt, fill: memphis-black)))
    place(bottom + left, dx: 80pt, dy: -300pt, rotate(15deg, rect(width: 10pt, height: 100pt, fill: memphis-black)))
  }
  
  // Page Break after Cover
  pagebreak()
  
  // Reset page counter to starts at 1 for the first content page
  counter(page).update(1)
  
  // --------------------------------------------------------------------------
  // TOC
  // --------------------------------------------------------------------------
  if toc-depth > 0 {
    // Custom outline style ?
    show outline.entry: it => {
       text(font: "Bauhaus 93", it)
    }
    outline(title: "CONTENT", depth: toc-depth, indent: auto)
    pagebreak()
  }

  // --------------------------------------------------------------------------
  // BODY CONTENT
  // --------------------------------------------------------------------------
  body
}
