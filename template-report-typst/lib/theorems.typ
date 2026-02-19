// Persian theorem-like environments
// Docs say: "To create a custom referenceable element like a theorem,
// you can create a figure of a custom kind and write a show rule for it."
// (ref: docs/reference/model/ref.md)
// Figure MUST have numbering to be referenceable.

#let theorem-counter = counter("theorem-counter")

#let reset-theorem-counter() = {
  theorem-counter.update(0)
}

// show rule to suppress default caption rendering for theorem figures
// (call this in template.typ or main.typ via: show figure.where(kind: "theorem-kind"): ...)

#let theorem-env(label-text: "تعریف", body, italic: false) = {
  let theorem-body = if italic { emph(body) } else { body }
  // figure must have numbering to be referenceable
  figure(
    kind: "theorem-kind",
    supplement: label-text,
    numbering: "1",
    caption: none,
    // step and display inside body so function returns single element
    block(
      width: 100%,
      spacing: 0.8em,
      inset: 0pt,
      stroke: none,
    )[
      #theorem-counter.step()
      *#label-text #context {
        let hn = counter(heading).get()
        let sec = if hn.len() > 0 { str(hn.at(0)) } else { "0" }
        let idx = str(theorem-counter.get().first())
        [#sec#str("-")#idx]
      }*
      #theorem-body
    ],
  )
}

#let definition(body) = theorem-env(label-text: "تعریف", body)
#let theorem(body) = theorem-env(label-text: "قضیه", body, italic: true)
#let lemma(body) = theorem-env(label-text: "لم", body, italic: true)
#let proposition(body) = theorem-env(label-text: "گزاره", body, italic: true)
#let corollary(body) = theorem-env(label-text: "نتیجه", body, italic: true)
#let observation(body) = theorem-env(label-text: "مشاهده", body)
#let remark(body) = theorem-env(label-text: "نکته", body)
#let note(body) = theorem-env(label-text: "یادداشت", body)

#let cproof(body) = block(spacing: 0.8em)[
  *برهان.* #body #h(1fr) $square.filled$
]
