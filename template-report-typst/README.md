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

## Setup Requirements

### Converting PDF Images

Typst cannot directly embed PDF images. The file `figs/f3.pdf` needs to be converted to PNG format before compilation.

**Option 1: Using pdftoppm (recommended)**
```bash
cd figs
pdftoppm -png -singlefile f3.pdf f3
```

**Option 2: Using ImageMagick**
```bash
cd figs
convert -density 300 f3.pdf f3.png
```

**Option 3: Using Ghostscript**
```bash
cd figs
gs -dNOPAUSE -dBATCH -sDEVICE=png16m -r300 -sOutputFile=f3.png f3.pdf
```

After conversion, the file `f3.png` will be used automatically by the template.

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

**Note:** The font warnings during compilation are expected if the fonts are not installed system-wide. Typst will use the font files from the `fonts/` directory.

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

All theorem-like environments (definition, theorem, lemma, observation) share a single counter that resets at each section, following the LaTeX `\newtheorem{theorem}[definition]{قضیه}` pattern. This means they are numbered sequentially as 1.1, 1.2, 1.3, etc. within each section.

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
- PDF to PNG converter (for f3.pdf image)

## Known Limitations

1. **PDF Images**: Typst does not support PDF images directly. Any PDF figures from the original LaTeX template must be converted to PNG/JPEG format.
2. **Font Warnings**: System-installed fonts may show warnings, but embedded fonts in the `fonts/` directory should work.

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
