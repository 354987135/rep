#set text(font: ("Linux Libertine", "Noto Sans SC"))

#show raw: set text(font: ("Fira Code", "Noto Sans SC"), features: (calt: 0), lang: "cpp")

#show heading.where(): set heading(numbering: "1.")

#let spacing = h(0.25em, weak: true)
#show math.equation.where(block: false): it => spacing + it + spacing

= 字符与字符串
= 位运算
== 注意点
+ 只有整数类型和无作用域枚举类型能进行位运算  

+ 整数以补码的形式存储，参与位运算的是补码的二进制位

+ 位运算符均具有左结合性

+ 位运算符的优先级从高到低排序如下
  + $>>, <<$
  + $~$
  + $\&$
  + $arrowhead.t$
  + $|$
== 按位逻辑运算
=== 按位与 
+ $\&$运算符，二元

+ $a space \& space b$表示$a$的每一位与$b$对应的每一位做逻辑与运算

  例如，$10110011 space \& space 01101101 = 00100001$

+ 基本性质
  - $a space \& space a = a$
  - $a space \& space 0 = 0$
=== 按位或
+ $|$运算符，二元

+ 记$a_i,b_i$分别为$a,b$补码的第$i$位，$a | b$表示对每一组$a_i,b_i$做逻辑或运算

  例如，$10110011 | 01101101 = 11111111$

+ 基本性质
  - $a | a = a$
  - $a | 0 = a$
  - 当$a space \& space b = 0$时，$a | b = a + b$
    
    当
=== 按位异或
+ $arrowhead.t$运算符，二元

+ $a arrowhead.t b$表示$a$的每一位与$b$对应的每一位做逻辑异或运算

  例如，$10110011 arrowhead.t 01101101 = 11011110$
+ 基本性质
  - $a arrowhead.t a = 0$
  - $a arrowhead.t 0 = a$
=== 按位非
+ $~$运算符，一元

+ $~a$表示对$a$的每一位做逻辑非运算，相当于取反$a$的每一位，因此也叫按位取反运算

+ 基本性质
  - $~a + 1 = -a$ <property1>

// https://developer.aliyun.com/article/1389769

// https://www.zhihu.com/question/38206659

// https://blog.csdn.net/qq_50285142/article/details/116380796

// https://graphics.stanford.edu/~seander/bithacks.html 

== 移位运算
=== 按位左移
+ $<<$运算符，二元

+ $a << i$表示将$a$的补码整体左移$i$位，在右侧补$i$位$0$，并丢弃左侧超出位数范围的$i$位
  
  例如，$00111011 << 4$表示将$8$位整数$00111011$左移$4$位，在右侧补$4$位$0$，并丢弃左侧超出$8$位的范围的$0011$，得到结果$cancel(0011)10110000$，即$10110000$

+ $i$必须满足$0 <= i < a "的补码位数"$，否则行为未定义

+ 整数是定点数，左移相当于将小数点右移，在二进制下，小数点右移$i$位相当于将原数乘上$2^i$，即$ a << i = a times 2^i $

+ 在C++20之前，只有当$a >= 0$时才能对$a$进行按位左移运算，若$a < 0$，则行为未定义，详见#link("https://en.cppreference.com/w/cpp/language/operator_arithmetic")[*_Built-in bitwise shift operators_*]
=== 按位右移
+ $>>$运算符，二元

+ $a >> i$表示将$a$的补码整体右移$i$位，如果$a >= 0$，则在左侧补$i$位$0$，如果$a < 0$，则在左侧补$i$位$1$，从而保持$a$的符号不变，并丢弃右侧超出位数范围的$i$位，这一右移规则称为算术右移
  
  例如，$10111011 >> 4$表示将$8$位整数$10111011$右移$4$位，在左侧补$4$位$1$，并丢弃右侧超出$8$位范围的$1011$，得到结果$11111011cancel(1011)$，即$11111011$

+ $i$必须满足$0 <= i < a "的补码位数"$，否则行为未定义

+ 整数是定点数，右移相当于将小数点左移，在二进制下，小数点左移$i$位相当于将原数除以$2^i$，此外，这里还要将结果向$-oo$取整，即$ a >> i = floor(a / 2^i) $
=== 输出整数$x$的补码
已知$1 << i$可以得到一个第$i + 1$位为$1$，其余位为$0$的掩码，因此$x space \& space (1 << i)$可以得到$x$第$i + 1$位上的信息，如果计算结果为$0$，则表示$x$第$i + 1$位上是$0$，否则表示$x$第$i + 1$位上是$1$

假设$x$是$32$位整数，代码实现如下：
```cpp
int bits = 32;
for (int i = bits - 1; i >= 0; --i) {
    std::cout << (x & (1 << i) ? 1 : 0);
}
```
=== 提取$x$最低位的$1$ <Chapter5.4.2>
根据按位非运算的性质第一条可知，当$x$为有符号整数时，（错误，无论是否有符号，~x+1均等价于-x）还可以使用$-x$代替~x + 1
=== 去除$x$最低位的$1$ <Chapter5.4.3>


按位->逐位？

// 交换一下 方法1和方法2，因为Chapter5.4.2在前

- 方法1
如果$x$是$2$的幂，那么利用@Chapter5.4.3[] 中的方法去除末位$1$后得到的数一定为$0$
// 注释补充：// x 为无符号整数

- 方法2
如果$x$是$2$的幂，那么利用@Chapter5.4.2 中的方法提取出来的代表末位$1$的数一定和$x$相等