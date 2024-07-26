#set text(font: ("Linux Libertine", "Noto Sans SC"), size: 20pt)

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


== 14题

分为选红色和不选红色两种情况

若选红色，选红色的方法有$C_4^1$种，接下来两张卡牌可在$12$张中任选，方法数为$C_4^1C_12^2 = 264$种

若不选红色，则先在12张中任选3张，再去除3张颜色相同的选法，即$C_12^3-C_3^1C_4^3 = 208$种

总方法数为$264+208 = 472$种

== 阅读程序(3)
程序利用DFS求解满足特定条件的排列的数量，生成全排列的个数为$n!$个，每个全排列都要用$O(n)$的时间判断其是否可选，因此总时间复杂度为$O(n dot n!)$

排列的长度为给定整数$n$，排列数字为$1 space ~ space n$，特殊条件为对于排列$a$中的每一个$a_i$，都要满足$a_i + i <= n + 2$

当 n = 1 时，返回值为 0

