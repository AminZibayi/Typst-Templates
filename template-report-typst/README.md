# Persian RTL Report Template for Typst

This is a Typst version of the LaTeX `template-report`, providing 1:1 fidelity for Persian (Farsi) right-to-left academic reports.

## Features

- **RTL Text Direction**: Full support for Persian right-to-left text
- **Bilingual Support**: Seamless mixing of Persian (RTL) and English/Latin (LTR) text
- **Academic Structure**: Includes abstract, sections, algorithms, figures, tables, and bibliography
- **Custom Environments**: Definitions, theorems, observations, and proofs
- **Algorithm Blocks**: Formatted pseudocode with proper LTR directionality
- **Bibliography**: IEEE-style citations using BibTeX files

## Requirements

- Typst 0.11.0 or later
- Persian fonts (B Nazanin recommended) - The template includes these fonts in the `fonts/` directory

## Compilation

To compile the document:

```bash
typst compile main.typ
```

This will generate `main.pdf`.

## Structure

- `main.typ` - Main document file
- `etc/` - Contains logos and bibliography
  - `aut.png` - University logo (right)
  - `ce.png` - Department logo (left)
  - `references.bib` - Bibliography database
- `figs/` - Figures and images
- `fonts/` - Persian fonts (B Nazanin)

## Font Installation

The template is configured to use B Nazanin font for Persian text. The fonts are included in the `fonts/` directory:
- `B Nazanin.ttf`
- `B Nazanin Bold.ttf`

If you encounter font warnings, you can either:
1. Install the fonts system-wide
2. Use the `--font-path` option when compiling: `typst compile --font-path fonts main.typ`
3. Accept fallback fonts (the document will still render correctly)

## Customization

### Header Information
Edit the header section in `main.typ` to customize:
- Document title (line ~115: "پوشش دیسک واحد")
- Course name (line ~116: "نام درس")
- Author name (line ~117: "نام و نام خانوادگی")
- University and date information

### Page Layout
Page margins are set to match the LaTeX template:
- Top: 25mm
- Bottom: 30mm
- Left: 25mm
- Right: 25mm

### Text Formatting
- Base font size: 12pt
- Line spacing: Double spacing (leading: 0.65em)
- Headings: Automatically numbered with Persian numerals

### Bibliography
The bibliography is configured to use IEEE style. To add or modify references, edit `etc/references.bib`.

## Differences from LaTeX Version

While this template aims for 1:1 fidelity with the LaTeX version, there are some minor implementation differences:

1. **Fonts**: Typst handles fonts differently than XeLaTeX/XePersian. System fonts or font files must be accessible to Typst.
2. **Algorithm Formatting**: Algorithms use custom Typst formatting instead of the algorithmic package.
3. **Counter Management**: Definition, theorem, and observation counters are implemented using Typst's counter system.

## License

This template follows the same license as the original LaTeX template in this repository.

## Credits

Converted from the LaTeX `template-report` template by the Typst-Templates repository.
