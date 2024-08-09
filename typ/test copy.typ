#set text(font: ("Linux Libertine", "Noto Sans SC"), size: 8pt)

#show raw: set text(font: ("Fira Code", "Noto Sans SC"), features: (calt: 0), lang: "cpp")


#show raw.where(block: false, lang: "cpp"): box.with(
  fill: luma(240),
  inset: (x: 2pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt
)

#show heading.where(): set heading(numbering: "1.1")

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

