#let ltr-footnote(content) = {
  footnote[#text(lang: "en", dir: ltr)[#content]]
}

#let en(content) = {
  text(lang: "en", dir: ltr)[#content]
}
