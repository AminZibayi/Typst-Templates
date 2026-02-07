# Mixed Media Typst Template

A Typst report template with an **eclectic, collage-style aesthetic**. This template mimics the look of mixed media artjournals, blending textured backgrounds, tape effects, torn paper elements, and expressive typography.

![Thumbnail](../assets/paper-texture.png)

## Features

- **Textured Backgrounds**: Includes Kraft paper textures for an analog feel.
- **Collage Elements**:
  - `tape("text")`: Renders text on a piece of washi tape.
  - `paper-cutout(body)`: Wraps content in a rotated, shadowed paper scrap box.
- **Expressive Typography**: Mixes "Oswald" (headlines), "EB Garamond" (body), "Patrick Hand" (accents), and "Courier Prime" (technical).
- **Dynamic Layout**: Rotated headings, non-standard margins, and visual layering.

## Usage

1.  **Install Fonts**: Ensure you have the following fonts installed (available via Google Fonts):
    - Oswald
    - EB Garamond
    - Patrick Hand (or Caveat)
    - Courier Prime
2.  **Import**:
    ```typst
    #import "@local/mixed-media-template:0.1.0": *
    
    #show: mixed-media-doc.with(
      title: "My Zine",
      subtitle: "An experimental document",
      author: "Artist Name"
    )
    ```

## Directory Structure

- `lib.typ`: Main template entry point and styling logic.
- `assets/`: Contains texture images (`paper-texture.png`, `torn-edge.png`, etc.).
- `template/`: Contains an example `main.typ` document.

## License

MIT
