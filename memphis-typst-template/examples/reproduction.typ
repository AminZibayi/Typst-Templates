#import "../lib.typ": *

#show: memphis-doc.with(
  title: "MEMPHIS STYLE",
  subtitle: "A bold, geometric report template",
  author: "Antigravity",
  date: datetime.today(),
  version: "1.0",
  toc-depth: 2
)

= Introduction to Memphis
Memphis design is an influential postmodern style that emerged from the celebrated Memphis Design Group of Milan in the early 1980s. It was led by the legendary Italian designer *Ettore Sottsass* and had a significant impact on the design world.

== Key Characteristics
The style is characterized by:
- *Clashing Colors*: High contrast, saturated colors like #text(fill: memphis-pink)[Hot Pink], #text(fill: memphis-cyan)[Cyan], and #text(fill: memphis-yellow)[Yellow].
- *Geometric Shapes*: Triangles, circles, and squiggles used decoratively.
- *Abstract Patterns*: Confetti, grids, and bacteria-like patterns.

= Typography & Layout
This template uses *Bauhaus 93* for headings to capture that retro-futuristic vibe, and *Century Gothic* for body text to ensure readability while maintaining a geometric feel.

== Lists
We use custom geometric markers for lists:
- First level item (Box)
  - Second level item (Circle)
    - Third level item (Triangle)
- Another item to show spacing.

== Block Quotes & Alerts
> Memphis is not just a style, it's an attitude. It's about breaking the rules of "good taste".

#memphis-box(title: "Design Tip")[
  Don't be afraid of empty space or asymmetry. Memphis design thrives on unexpected layouts!
]

= Tables & Data
Here is a "loud" table demonstrating usage of the custom `memphis-table` function:

#memphis-table(
  columns: (1fr, 1fr, 1fr),
  [Element], [Color], [Shape],
  [Primary Header], [Pink], [Rect],
  [Secondary], [Blue], [Line],
  [Accent], [Yellow], [Triangle],
  [Background], [White/Grey], [Confetti],
)

= Code & Technical
Even code blocks get the Memphis treatment:

```rust
fn main() {
    println!("Hello, 80s!");
    let style = "Memphis";
    assert_eq!(style, "Awesome");
}
```

= Mood & Occasion
// #image("../assets/memphis-mood.png", width: 80%)

*Mood*: Youthful, quirky, anti-establishment.
*Occasion*: Great for creative brands, event posters, or retro fashion.

= Conclusion
This template provides a starting point for creating documents with a distinct personality. Use it wisely – it's loud!
