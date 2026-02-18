// Algorithm environment with plain pseudocode styling

#let algorithm(caption: none, body) = {
  figure(
    kind: "algorithm",
    supplement: "الگوریتم",
    caption: caption,
    {
      set text(lang: "en", dir: ltr, font: "Times New Roman", size: 10pt)
      set align(left)
      set par(leading: 0.75em)
      body
    },
  )
}
