# Utilitarian Typst Template

A function-first, clean, and direct Typst report template with military-industrial aesthetics.

## Overview

The Utilitarian template prioritizes **clarity over decoration** with a rugged, technical design suitable for:

- Technical manuals
- System documentation
- Field operation guides
- Engineering reports
- Military/industrial specifications

## Features

- **Grid-based layout** with generous margins
- **Monospaced fonts** for headings (JetBrains Mono, Consolas fallback)
- **Muted color palette** (charcoal, slate, warm gray)
- **Zero decoration** – purely functional design
- **Automatic page numbering** in footer
- **Header/footer** with document metadata
- **Table of contents** generation
- **Utility functions** for tables, notes, and data fields

## Installation

### Local Installation

1. Clone or download this template to your Typst templates directory
2. Import in your document:

```typst
#import "@local/utilitarian-template:1.0.0": *
```

### Direct Import

Copy `lib.typ` to your project and import directly:

```typst
#import "lib.typ": *
```

## Quick Start

```typst
#import "@local/utilitarian-template:1.0.0": *

#show: utilitarian-doc.with(
  title: "System Operations Manual",
  subtitle: "Technical Reference Guide",
  author: "Engineering Division",
  date: "2026-02-01",
  version: "1.0.0",
  document-id: "DOC-2026-0042",
  toc: true,
)

= Introduction

Your content here...
```

## Template Parameters

| Parameter     | Type        | Default          | Description                      |
| ------------- | ----------- | ---------------- | -------------------------------- |
| `title`       | string      | "DOCUMENT TITLE" | Main document title              |
| `subtitle`    | string/none | none             | Optional subtitle                |
| `author`      | string/none | none             | Author name                      |
| `date`        | string/none | none             | Date (auto-generated if omitted) |
| `version`     | string/none | none             | Version number                   |
| `document-id` | string/none | none             | Document classification/ID       |
| `language`    | string      | "en"             | Document language                |
| `toc`         | boolean     | true             | Show table of contents           |
| `toc-depth`   | integer     | 3                | TOC depth level                  |

## Utility Functions

### `util-rule()`

Creates a minimal horizontal rule.

```typst
#util-rule(width: 100%, weight: 0.5pt)
```

### `util-field()`

Creates a labeled data field (key: value layout).

```typst
#util-field("Model", "UTL-7000 Series")
#util-field("Capacity", "10,000 operations/second")
```

### `util-table()`

Creates a clean table with grid aesthetics.

```typst
#util-table(
  columns: (auto, 1fr, auto),
  [Component], [Function], [Status],
  [Core Module], [Central processing], [Active],
  [Comm Array], [Communications], [Standby],
)
```

### `util-note()`

Creates a callout box with accent border.

```typst
#util-note[
  *Important:* Always verify power supply before startup.
]
```

## Color Palette

The template uses a muted, industrial color scheme:

- **Charcoal** (`#2C2C2C`) – Primary text, headings
- **Slate** (`#64748B`) – Secondary text, metadata
- **Warm Gray** (`#F5F5F0`) – Background accents
- **Dark Goldenrod** (`#B8860B`) – Sparse accent color
- **Grid Line** (`#D4D4D4`) – Borders and rules

## Typography

- **Headings**: Monospaced (JetBrains Mono → Consolas → Courier New)
- **Body**: Sans-serif (Inter → Roboto → Arial)
- **Code**: Monospaced with warm gray background

## Page Layout

- **Paper**: A4
- **Margins**: 3cm top, 2.5cm bottom/left/right
- **Header**: Document title and ID (appears from page 2)
- **Footer**: Version, page number (center), date
- **Page numbering**: Automatic, centered in footer

## Example Output

See `example-output.pdf` for a complete demonstration including:

- Cover page with metadata
- Table of contents
- Hierarchical headings
- Tables and data fields
- Code blocks
- Note callouts

## Compilation

```bash
# From template directory
typst compile template/main.typ output.pdf --root .

# Or from your project
typst compile your-document.typ output.pdf
```

## Font Warnings

If you see warnings about "unknown font family", the template will automatically use fallback fonts:

- JetBrains Mono → Consolas → Courier New
- Inter → Roboto → Arial

To eliminate warnings, install [JetBrains Mono](https://www.jetbrains.com/lp/mono/) and [Inter](https://rsms.me/inter/).

## Design Philosophy

The Utilitarian template follows these principles:

1. **Function over form** – Every element serves a purpose
2. **Clarity first** – Information hierarchy is paramount
3. **No decoration** – No borders, shadows, or ornamental elements
4. **Grid-based** – Structured, predictable layout
5. **Industrial aesthetic** – Technical, professional, efficient

## License

MIT License – Free to use and modify.

## Credits

Created as a professional Typst template for technical documentation.

---

**Version**: 1.0.0  
**Last Updated**: 2026-02-01
