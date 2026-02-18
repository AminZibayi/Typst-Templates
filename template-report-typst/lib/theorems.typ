// Persian theorem-like environments with shared section-based numbering

#let theorem-counter = counter("theorem-counter")

#let reset-theorem-counter() = context {
  theorem-counter.update(0)
}

#let theorem-env(label-text: "تعریف", body, italic: false) = context {
  theorem-counter.step()
  let heading-num = counter(heading).get()
  let sec = if heading-num.len() > 0 { heading-num.at(0) } else { 0 }
  let idx = theorem-counter.get().first()
  let theorem-body = if italic { emph(body) } else { body }
  block[
    *#label-text #sec.#idx.*
    #theorem-body
  ]
}

#let definition(body) = theorem-env(label-text: "تعریف", body)
#let theorem(body) = theorem-env(label-text: "قضیه", body, italic: true)
#let lemma(body) = theorem-env(label-text: "لم", body, italic: true)
#let proposition(body) = theorem-env(label-text: "گزاره", body, italic: true)
#let corollary(body) = theorem-env(label-text: "نتیجه", body, italic: true)
#let observation(body) = theorem-env(label-text: "مشاهده", body)
#let remark(body) = theorem-env(label-text: "نکته", body)
#let note(body) = theorem-env(label-text: "یادداشت", body)

#let cproof(body) = block[
  *برهان.* #body #h(0.5em) $square$
]
