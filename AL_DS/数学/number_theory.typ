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


== 认识求和符号(连加号)
求和指标
$ sum_(i=1)^n i $
$ sum_(i=1)^n a_i $
$ sum_(i=1)^n n = n times n $ 
$ sum_(i=1)^n (a_i + b_i) = sum_(i=1)^n a_i + sum_(i=1)^n b_i $ 
$ sum_(i=1)^n k a_i = k sum_(i=1)^n a_i $
$ sum_(1 <= i < j <= n) a_(i j) $
=== 双重求和
矩阵的求和
$ sum_(i=1)^m sum_(j=1)^n a_(i j) = sum_(j=1)^n sum_(i=1)^m a_(i j) $ 

求和符号的性质，可交换性
== 认识求积符号(连乘号)
$ product $


== 集合的概念、交并运算

$ mat(n; k) $