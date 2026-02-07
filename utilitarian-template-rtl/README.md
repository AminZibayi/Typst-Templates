# Utilitarian Typst Template (RTL Variant)

A function-first, clean, and direct Typst report template with military-industrial aesthetics, optimized for Persian and Right-to-Left (RTL) languages.

## Overview

The Utilitarian template prioritizes **clarity over decoration** with a rugged, technical design suitable for:

- Technical manuals
- System documentation
- Field operation guides
- Engineering reports
- Military/industrial specifications

**This is the RTL variant of the Utilitarian template.**

## Features

- **Right-to-Left (RTL) Layout**: Fully optimized for Persian/Arabic scripts.
- **Persian Typography**: Pre-configured for **Vazirmatn** and **Sahel** fonts.
- **Grid-based layout** with generous margins.
- **Monospaced fonts** for headings and code (Vazir Code, JetBrains Mono).
- **Muted color palette** (charcoal, slate, warm gray).
- **Zero decoration** – purely functional design.
- **Automatic page numbering** in footer.
- **Header/footer** with document metadata.
- **Utility functions** for tables, notes, and data fields.

## Fonts

This template requires the following fonts for optimal rendering:

1.  **[Sahel FD](https://github.com/rastikerdar/sahel-font)** (Primary body text)
2.  **[Vazirmatn](https://github.com/rastikerdar/vazirmatn)** (Secondary body text)
3.  **[Vazir Code FD](https://github.com/rastikerdar/vazir-code)** (Monospaced/Code)
4.  **[JetBrains Mono](https://www.jetbrains.com/lp/mono/)** (Latin Code/Mono fallback)

_Note: The "FD" variants (Farsi Digits) are preferred for consistent numeral rendering._

If these fonts are not installed, Typst will attempt to fallback to available system fonts, but the layout may not look as intended.

## Installation

### Local Installation

1.  Clone or download this template to your Typst templates directory.
2.  Install the required fonts.
3.  Import in your document:

```typst
#import "@local/utilitarian-template-rtl:1.0.0": *
```

### Direct Import

Copy `lib.typ` to your project and import directly:

```typst
#import "lib.typ": *
```

## Quick Start

```typst
#import "@local/utilitarian-template-rtl:1.0.0": *

#show: utilitarian-doc.with(
  title: "عنوان سند",
  subtitle: "راهنمای فنی",
  author: "واحد مهندسی",
  date: "1404/11/12",
  version: "1.0.0",
  document-id: "DOC-2026-0042",
  toc: true,
)

= مقدمه

متن خود را اینجا بنویسید...
```

## Template Parameters

| Parameter     | Type        | Default | Description                      |
| ------------- | ----------- | ------- | -------------------------------- |
| `title`       | string      | "عنوان" | Main document title              |
| `subtitle`    | string/none | none    | Optional subtitle                |
| `author`      | string/none | none    | Author name                      |
| `date`        | string/none | none    | Date (auto-generated if omitted) |
| `version`     | string/none | none    | Version number                   |
| `document-id` | string/none | none    | Document classification/ID       |
| `language`    | string      | "fa"    | Document language (default 'fa') |
| `toc`         | boolean     | true    | Show table of contents           |
| `toc-depth`   | integer     | 3       | TOC depth level                  |

## Utility Functions

### `util-rule()`

Creates a minimal horizontal rule.

```typst
#util-rule(width: 100%, weight: 0.5pt)
```

### `util-field()`

Creates a labeled data field (key: value layout). In RTL, Label is on the Right.

```typst
#util-field("مدل", "سری UTL-7000")
#util-field("ظرفیت", "10,000 عملیات/ثانیه")
```

### `util-table()`

Creates a clean table with grid aesthetics.

```typst
#util-table(
  columns: (auto, 1fr, auto),
  [اجزا], [عملکرد], [وضعیت],
  [ماژول هسته], [پردازش مرکزی], [فعال],
)
```

### `util-note()`

Creates a callout box with accent border (Right border in RTL).

```typst
#util-note[
  *مهم:* همیشه قبل از راه‌اندازی منبع تغذیه را بررسی کنید.
]
```

## Compilation

```bash
# From template directory
typst compile template/main.typ output.pdf --root .

# Or from your project
typst compile your-document.typ output.pdf
```

## License

MIT License – Free to use and modify.

---

**Version**: 1.0.0
**Last Updated**: 2026-02-01
