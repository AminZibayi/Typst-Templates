# Persian Academic Report Template (Typst)

This is a Typst transpilation of a Persian academic report template originally written in LaTeX.

## Overview

This template provides a complete Persian/Farsi academic report structure with:
- Right-to-left (RTL) text direction
- Persian fonts (B Nazanin)
- Theorem-like environments (definitions, theorems, lemmas, observations, proofs)
- Algorithm pseudocode blocks
- Mathematical equations with proper numbering
- Tables and figures with captions
- Bibliography support
- Cross-referencing

## Structure

- `main.typ` - Main document file
- `etc/` - Supporting files
  - `aut.png`, `ce.png` - University logos
  - `references.bib` - Bibliography database
- `figs/` - Figure files
- `fonts/` - Persian fonts (B Nazanin)

## Compilation

To compile the document:

```bash
typst compile main.typ
```

This will generate `main.pdf`.

## Features

### Page Layout
- A4 paper size
- Margins: 25mm (top, left, right), 30mm (bottom)
- Double spacing

### Fonts
- Persian text: B Nazanin (scale 1.2)
- Latin text: Times New Roman
- Font files are included in the `fonts/` directory

### Document Structure
1. Custom header with university logos and title
2. Abstract
3. Problem description
4. Algorithm review with detailed descriptions
5. Evaluation section with results
6. Conclusion
7. Bibliography
8. Appendix

### Theorem Environments
- تعریف (Definition)
- قضیه (Theorem)
- لم (Lemma)
- مشاهده (Observation)
- برهان (Proof)

All environments are numbered according to section.

### Cross-References
Use `@label` syntax to reference:
- Equations: `@eq:1`
- Sections: `@sec:name`
- Figures: `@fig:name`
- Tables: `@tb:name`
- Algorithms: `@alg:name`

## Customization

### Header
Edit lines 26-50 in `main.typ` to customize the header with your:
- Course name
- Student name
- University information
- Date

### Colors and Styling
The template uses default styling. You can customize:
- Theorem environment styling (lines 56-109)
- Heading styles
- Table formatting
- Algorithm block appearance

## Requirements

- Typst 0.11.0 or later
- Persian fonts (B Nazanin) - included in the template

## Notes

- The document uses RTL text direction for Persian content
- Latin text in footnotes uses LTR direction
- Algorithms are formatted as code blocks within figure environments
- Bibliography uses BibTeX format (`.bib` file)

## Original Template

This template is a transpilation of a LaTeX template that used:
- XeLaTeX with xepersian package
- Custom theorem environments
- Algorithmic package for pseudocode

## License

Please refer to the LICENSE file in the repository root.
