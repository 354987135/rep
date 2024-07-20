#set text(font: ("Linux Libertine", "Noto Sans SC"), size: 15pt)

#show raw: set text(font: ("Fira Code", "Noto Sans SC"), features: (calt: 0), lang: "cpp")


#show raw.where(block: false, lang: "cpp"): box.with(
  fill: luma(240),
  inset: (x: 2pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt
)

#show heading.where(): set heading(numbering: "1.")

#let spacing = h(0.25em, weak: true)
#show math.equation.where(block: false): it => spacing + it + spacing

#import "@preview/tablex:0.0.8"
#import "@preview/cetz:0.2.2"
#import "@preview/codly:1.0.0"
#show: codly.codly-init.with();

#codly.codly(
  languages: (
    cpp: (
      name: "C++",
      // icon: text(font: "tabler-icons", "\u{fa53}"),
      color: rgb("#283FC1")
    ),
  )
)

#codly.codly(
  stroke: 1pt + gradient.linear(..color.map.flare),
)

```cpp
#include <iostream>

int main() {
  std::cout << 123;
}

```

#set align(center)
#tablex.tablex(
  columns: (3em, 3em, 3em, 3em, 3em, 3em),
  rows: 3em,
  align: center + horizon,
  size: 10pt,
  [2], [3], [4], [5], [6], [7], 
  [8], [9], [10], [11], [12], [13], 
  [14], [15], [16], [17], [18], [19], 
  [20], [21], [22], [23], [24], [25], 
  [26], [27], [28], [29], [30], [31], 
  [32], [33], [34], [35], [36], [37]
)
#set align(left)



// #cetz.tree.tree(
//   ([A], ([A], [B], [C]), ([A]), ([C], [D])),
//   direction: "right"
// )


// #figure(
//   image("sieve-linear.png", width: 64%), caption: [Sieve]
// )