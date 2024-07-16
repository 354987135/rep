#set text(font: ("Linux Libertine", "Noto Sans SC"), size: 12pt)

#show raw: set text(font: ("Fira Code", "Noto Sans SC"), features: (calt: 0), lang: "cpp")


#show raw.where(block: false, lang: "cpp"): box.with(
  fill: luma(240),
  inset: (x: 2pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt
)

// #show heading.where(): set heading(numbering: "1.")

#let spacing = h(0.25em, weak: true)
#show math.equation.where(block: false): it => spacing + it + spacing

== 整除
设$a, b in ZZ$，如果存在$k in ZZ$，使得$b = k a$，则称 $a$ 整除 $b$，记为$a | b$
== 整除的性质

== 因数 约数 素数
== 算术基本定理
== 素数判定 试除法
== 素数筛法