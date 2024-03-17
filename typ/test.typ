= test typst file
+ it is good
#set text(font: "Fira Code")
+ it is bad
#set text(font: "Microsoft YaHei")
+ 无敌了
```cpp
#include <print>
#include <vector>

int main() {
    std::vector v {1, 3, 5};
    std::println("{}", v);
}
```
#set text(font: "Linux Libertine")
test math: $sqrt(x)=e^(1/2 ln x)$

$ Gamma(x)=integral_0^(+infinity) t^(x-1)e^(-t) dif t $
$ product_(n=1)^infinity $
$ sum_(n=1)^infinity n $

#set text(20pt)
= head1
== head2
=== head3
==== head4
===== head5
====== head6
======= head7
- asijfasji
_test_

+ list1
  + list
    + list
      - sada
you don't need _1.1.2_ ... type of numbers

#image("image.png", width: 5cm, height: 5cm)

#figure(
  image("image.png", width: 20%),
  caption: [
    the first image
  ]
) <firstImage>


now let's jump to the first image(@firstImage)

$ sqrt(x) $

$ v = vec(vec((x_11, x_12, x_13), x_2, x_3)) $
what is this?

what is that?

bold: *bold*

jhaiosdjasd

italic: _italic_

`raw text? no font &&`

#set text(font: "Consolas")
raw text? no font &&

#set text(font: "Linux Libertine")
raw text?

#set enum(numbering: "1)")
+ saffa
+ sfafa
#set enum(numbering: "1.a)")
+ asfaf
+ safasa

#set enum(numbering: "1.")
=
==
===

/ 1d array: 存储连续对象的容器

#let x = 1;
#{ x += 2 }

#x
#set text(font: "Microsoft YaHei", lang: "zh")
#show raw: set text(font: "Microsoft YaHei", features: ((calt: 0)), lang: "typ")

```typ
sapokd
```
#show raw: set text(font: ("Fira Code", "Microsoft YaHei"), features: (calt: 0), lang: "cpp")
```cpp
#include <iostream>
using namespace std;
int main() {
  ->
  &&asd;.?asdasdas
  // 一二三四五六七八九十
}
```
一二三四五六七八九十

$ x \ y $

$ != $

$ #rect(width: 2cm) $

$ floor(3.14) $
$ ceil(3.14) = 4 $

#set align(center)
#set text(font: "", weight: "bold")
= 标题测试
萨芬考分看saggdfasdsf
ascascsa
dgggg
#set text(font: "Microsoft YaHei", weight: "bold")
saokjf


gdkg
测试
#set text(weight: "regular")
测试
#set text(
  font: ("Fira Code", "Microsoft YaHei"),
  fallback: false,
  size: 16pt,
  
)
#outline()
afjkoia
