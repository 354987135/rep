#set text(font: ("Linux Libertine", "Noto Sans SC"), size: 21pt)

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

= 测试
== 测试

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
// 
// 
// 
// 
// 
$ 1 in {1, 2, 3, 4} $

$ 5 in.not {1, 2, 3, 4} $

$ A subset B $

$ A subset.eq B $

自然数集$NN$

正整数集$NN^+$或$NN^*$

整数集$ZZ$

有理数集$QQ$

实数集$RR$

复数集$CC$

$A sect B$

$A union B$

$complement_B A$



对任意$a, b in ZZ$, 如果存在$k in ZZ$,使得$b = k a$成立，那么就说$a$整除$b$，记作$a divides b$，反之，$a$不整除$b$，记作$a divides.not b$

如果$a divides b$，那么$a$是$b$的约数，（也叫因数、因子...），$b$是$a$的倍数

平凡约数：$1$和整数自身，对应地还有非平凡约数

素数：不等于$0, 1$且只包含平凡因子的整数

素数可以是负数，但是一般只讨论正的素数

不是素数，也不是$0, 1$的整数，称为合数

数学上的取整：向上取整（$ceil(x)$），向下取整（$floor(x)$）

C++中的取整：向上取整 ceil(x)，向下取整 floor(x) / (int)强制转换，四舍五入取整 round(x)


$sigma  Sigma$

$pi Pi$

$ sum_(i = 1)^n i  = 1 + 2 + ... + n $
$ sum_(i = 1)^n a_i  = a_1 + a_2 + ... + a_n $

$ product_(i = 1)^n i = 1 times 2 times 3 times ... times n  $

$ product_(i = 1)^n a_i = a_1 times a_2 times a_3 times ... times a_n  $


整除的性质：
1. $1 divides a, a in ZZ$
2. $a divides b and b divides c arrow.double a divides c$

$a$与$b$在模$m$的前提下同余，记作$a eq.triple b (mod m)$


3 % 7 = 3;

10 % 7 = 3;

$3 eq.triple 10(mod 7)$