
#import "../lib.typ": *

#show: mixed-media-doc.with(
  title: "The Art of Noise",
  subtitle: "Visualizing Sound in Analog",
  author: "Sonic Architect",
  date: "2026-02-01",
)

= Introduction

Mixed Media blends multiple visual styles and techniques — photography, illustration, textures — into one cohesive piece. It adds layers and depth, often evoking experimental or tactile storytelling.

#quote[
  "Collage is the noble conquest of the irrational, the coupling of two realities, irreconcilable in appearance, upon a plane which apparently does not suit them." -- Max Ernst
]

== Core Elements

The aesthetic relies on a few key components:

- *Cutouts and overlays*: Images that feel physically placed on the page.
- *Analog + Digital*: Blending the imperfections of scanned media with clean vector type.
- *Eclectic typography*: Mixing #tape[serifs] with #tape[handwritten scripts, color: mm-red].

#paper-cutout(rotation: -1deg)[
  #heading(level: 3, "Design Note")
  This template uses a randomized rotation for boxes to simulate a hand-pasted effect. The background texture provides a base layer of warmth and age.
]

= Techniques

== Typography as Texture

Typography isn't just for reading; it's a visual element. We use #raw("monospaced fonts") for metadata and technical details, contrasting with bold display faces for headings.

```typst
#show heading: it => {
  set text(font: "Oswald", weight: "bold")
  rotate(-1deg, block(stroke: 2pt, inset: 1em, it))
}
```

== Visual Hierarchy

#figure(
  rect(width: 80%, height: 100pt, fill: silver, stroke: 1pt),
  caption: [A placeholder for a collage visual illustration.],
)

The hierarchy is established through contrast—size, weight, and rotation. Elements that break the grid draw attention immediately.

= Conclusion

This template provides a foundation for creating expressive, art-school style documents using Typst. It pushes the boundaries of what a "document" typically looks like, moving towards a "zine" aesthetic.
