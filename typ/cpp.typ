#set text(font: ("Linux Libertine", "Noto Sans SC"))

#show raw: set text(font: ("Fira Code", "Noto Sans SC"), features: (calt: 0), lang: "cpp")

#show heading.where(): set heading(numbering: "1.", supplement: "章节")

#let spacing = h(0.25em, weak: true)
#show math.equation.where(block: false): it => spacing + it + spacing

= C++程序与编译器
= 数组
= 指针与指针
== 原始指针
通常提到“指针”一词时，指的是原始指针(raw pointer)，也叫裸指针(naked pointer)
== 智能指针
== 范围与迭代器
迭代器类型、迭代器*无效化*

= 字符与字符串
= 位运算
== 注意点
+ 只有整数能进行位运算

+ 整数以补码的形式存储，参与位运算的是补码的二进制位

+ $1$的补码只有最低位是$1$，其余位都为$0$

+ $0$的补码所有位全为$0$

+ $-1$的补码所有位全为$1$
== 按位逻辑运算
=== 按位与 

+ $\&$运算符，双目

+ $a space \& space b$表示$a$的每一位与$b$对应的每一位做逻辑与运算

  例如，$10110011 space \& space 01101101 = 00100001$

+ 基本性质
  - $a space \& space a = a$
  - $a space \& space 0 = 0$
=== 按位或

+ $|$运算符，双目

+ $a | b$表示$a$的每一位与$b$对应的每一位做逻辑或运算

  例如，$10110011 | 01101101 = 11111111$

+ 基本性质
  - $a | a = a$
  - $a | 0 = a$
  - 当$a space \& space b = 0$时，$a | b = a + b$
    
    当
=== 按位异或

+ $arrowhead.t$运算符，双目

+ $a arrowhead.t b$表示$a$的每一位与$b$对应的每一位做逻辑异或运算

  例如，$10110011 arrowhead.t 01101101 = 11011110$
+ 基本性质
  - $a arrowhead.t a = 0$
  - $a arrowhead.t 0 = a$
=== 按位非

+ $~$运算符，单目

+ $~a$表示对$a$的每一位做逻辑非运算，相当于取反$a$的每一位，因此也叫按位取反运算

+ 基本性质
  - $~0=-1$
  - $~a + 1 = -a$
== 移位运算
=== 左移
=== 右移
== 综合应用
=== 交换$x,y$
=== 输出整数$x$的补码
=== 提取出整数$x$的补码最低位的$1$ <Chapter5.2>
=== 判断整数$x$是否为$2$的幂
+ 分析
当$x <= 0$时，$x$不是$2$的幂

当$x > 0$时，如果$x$是$2$的幂，那么$x$的补码中只有一位是$1$，其余位都是$0$

因此，只需要考虑无符号整数$x$，并特判$x = 0$的情况

- 方法1
假设$x$是$2$的幂，那么$x - 1$相当于将$x$唯一的$1$位和它之后所有的$0$位全部取反

例如，$00010000 - 1 = 00001111, quad 00000010 - 1 = 00000001$

显然，$x$和$x - 1$做按位与运算的结果是$0$，由此性质可以判断$x$是否为$2$的幂

该方法的代码实现如下
```cpp 
if (x && !(x & (x - 1))) {
    // 是 2 的幂
}
```

- 方法2
假设$x$是$2$的幂，那么利用@Chapter5.2 中的方法提取出来的数将和$x$相等，由此性质也可以判断$x$是否为$2$的幂

该方法的代码实现如下
```cpp 
if (x && x == (x & ~x + 1)) {
    // 是 2 的幂
}
```
或
```cpp 
if (x > 0 && x == (x & -x)) { // 由于涉及到取相反数，x必须为有符号整数
    // 是 2 的幂
}
```

- 方法3
从C++20开始，标准库提供_*std::has_single_bit*_函数 (头文件\<bit\>)，可直接进行判断，该函数只接受无符号整数
= OOP

// https://developer.aliyun.com/article/1389769

// https://www.zhihu.com/question/38206659

// https://blog.csdn.net/qq_50285142/article/details/116380796

// https://graphics.stanford.edu/~seander/bithacks.html 


=== 按位左移
+ $>>$运算符，双目

+ 
=== 按位右移
+ $<<$运算符，双目

+ 



=== 提取$x$最低位的$1$ <Chapter5.4.2>
=== 去除$x$最低位的$1$ <Chapter5.4.3>
=== 输出整数$x$的补码
