// Algorithm environment matching LaTeX `algorithmic` package (noend variant)
// Features: horizontal rules top/bottom, numbered lines, bold keywords, LTR English

// Bold keyword helper
#let kw(s) = strong(s)

// Comment helper (renders like algorithmic \COMMENT)
#let cmt(s) = {
  h(1fr)
  text(size: 9pt)[▷ #s]
}

// Line number helper for use in algo-lines grid
#let ln(n) = align(right)[#n:]

// Indentation helpers
#let ind = h(1.2em)
#let ind2 = h(2.4em)
#let ind3 = h(3.6em)

// Grid-based pseudocode with consistent line-number alignment
#let algo-lines(..cells) = {
  grid(
    columns: (2em, 1fr),
    column-gutter: 0.3em,
    row-gutter: 0.2em,
    ..cells.pos()
  )
}

// Algorithm figure wrapper with horizontal rules
#let algorithm(caption: none, body) = {
  figure(
    kind: "algorithm",
    supplement: "الگوریتم",
    caption: caption,
    block(
      width: 100%,
      inset: (x: 4pt, y: 6pt),
    )[
      #set text(lang: "en", dir: ltr, font: "Times New Roman", size: 10pt)
      #set align(left)
      #set par(leading: 0.55em)
      #body
    ],
  )
}
