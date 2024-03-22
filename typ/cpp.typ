#set text(font: ("Linux Libertine", "Noto Sans SC"))

#show raw: set text(font: ("Fira Code", "Noto Sans SC"), features: (calt: 0), lang: "cpp")

#show heading.where(): set heading(numbering: "1.")

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
+ 只有整数类型和无作用域枚举类型能进行位运算  

+ 整数以补码的形式存储，参与位运算的是补码的二进制位

+ 位运算符的优先级从高到低排序如下
  + $~$
  + $>>, <<$
  + $\&$
  + $arrowhead.t$
  + $|$
+ 二元位运算符均具有左结合性
== 按位逻辑运算
=== 按位非 <chapter5.2.1>
+ $~$运算符，一元

+ 记$a_i$为$a$补码的第$i$位，$~a$表示对每一个$a_i$做逻辑非运算，相当于取反$a$的每一位，因此也叫按位取反运算

  例如，$~10110011 = 01001100$

+ 基本性质
  - $~a + 1 = -a$
=== 按位与
+ $\&$运算符，二元

+ 记$a_i,b_i$分别为$a,b$补码的第$i$位，$a space \& space b$表示对每一组$a_i,b_i$做逻辑与运算

  例如，$10110011 space \& space 01101101 = 00100001$

+ 基本性质
  - $a space \& space b = b space \& space a$
  - $a space \& space (b space \& space c) = (a space \& space b) space \& space c$
  - $a space \& space a = a$
  - $a space \& space 0 = 0$
  - $a space \& space ~0 = a$
=== 按位异或 <chapter5.2.3>
+ $arrowhead.t$运算符，二元

+ 记$a_i,b_i$分别为$a,b$补码的第$i$位，$a arrowhead.t b$表示对每一组$a_i,b_i$做逻辑异或运算

  例如，$10110011 arrowhead.t 01101101 = 11011110$
+ 基本性质 
  - $a arrowhead.t b = b arrowhead.t a$
  - $a arrowhead.t (b arrowhead.t c) = (a arrowhead.t b) arrowhead.t c$
  - $a arrowhead.t a = 0$
  - $a arrowhead.t 0 = a$
  - $a arrowhead.t ~0 = ~a$
=== 按位或
+ $|$运算符，二元

+ 记$a_i,b_i$分别为$a,b$补码的第$i$位，$a | b$表示对每一组$a_i,b_i$做逻辑或运算

  例如，$10110011 | 01101101 = 11111111$

+ 基本性质
  - $a | b = b | a$
  - $a | (b | c) = (a | b) | c$
  - $a | a = a$
  - $a | 0 = a$
  - $a | ~0 = ~0$
== 移位运算
=== 按位左移 <chapter5.3.1>
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

+ 整数是定点数，右移相当于将小数点左移，在二进制下，小数点左移$i$位相当于将原数除以$2^i$，此处还要将结果向$-oo$取整，即$ a >> i = floor(a / 2^i) $
== 综合应用
=== 交换$x,y$
利用按位异或的性质*_(@chapter5.2.3[])_*，可以得到如下过程
$ x &:= x arrowhead.t y\ 
y &:= y arrowhead.t x = y arrowhead.t (x arrowhead.t y) = x\
x &:= x arrowhead.t y = (x arrowhead.t y) arrowhead.t x = y $
该过程实现了$x,y$的交换，并且无需借助临时变量，但要注意，若$x,y$属于同一内存，则相当于进行了$3$次$x := x arrowhead.t x$，导致该内存变为$0$

代码实现如下
```cpp
void Swap(int& x, int& y) {
    x ^= y;
    y ^= x;
    x ^= y;
}
```
=== 输出$x$的补码
根据按位左移运算的定义*_(@chapter5.3.1[])_*，$1 << i$可以得到一个第$i + 1$位为$1$，其余位为$0$的掩码，因此，可以使用$1 << i$屏蔽$x$的其他位，只得到$x$第$i + 1$位的信息，如果$x space \& space (1 << i)$计算结果为$0$，则表示$x$第$i + 1$位上是$0$，否则表示$x$第$i + 1$位上是$1$

假设$x$是$32$位整数，则代码实现如下：
```cpp
int bits = 32;
for (int i = bits - 1; i >= 0; --i) {
    std::cout << (x & (1 << i) ? 1 : 0);
}
```
=== 提取$x$最低位的$1$ <chapter5.4.3>

=== 去除$x$最低位的$1$ <chapter5.4.4>
=== 判断$x$是否为$2$的幂
当$x <= 0$时，$x$显然不是$2$的幂，当$x > 0$时，如果$x$是$2$的幂，根据按位左移运算的性质*_(@chapter5.3.1[])_*，$x$可以表示为$1 << i$的形式，即$x$的补码中只有一位是$1$，其余位都是$0$，因此，只需要考虑无符号整数$x$，并特判$x = 0$的情况，下列代码都保证$x$是无符号整数，或是满足$x >= 0$的有符号整数

- 方法1
    
    结合*_(@chapter5.4.3[])_*可知，当$x$是$2$的幂时，获取的表示最低位的$1$的数与$x$相等

    代码实现如下
    ```cpp 
    if (x && x == (x & ~x + 1)) {
        // 是 2 的幂
    }
    ```
    或
    ```cpp 
    if (x && x == (x & -x)) {
        // 是 2 的幂
    }
    ```
- 方法2

    当$x$是$2$的幂时，$x - 1$表示将$x$的补码从是$1$的位开始的所有位取反，例如$ 00010000 - 1 &= 00001111\ 00000010 - 1 &= 00000001 $

    显然，$x$与$x - 1$做按位与运算的结果是$0$

    代码实现如下
    ```cpp 
    if (x && !(x & (x - 1))) {
        // 是 2 的幂
    }
    ```
- 方法3

    从C++20开始，可使用标准库提供的#link("https://en.cppreference.com/w/cpp/numeric/has_single_bit")[*_std::has_single_bit_*]函数直接进行判断
=== 整数四则运算
+ 加法
  
  观察按位异或运算和按位与运算的结果可以发现，$a arrowhead.t b$的结果是$a,b$不进位加法的结果，而$a space \& space b$是$a, b$加法的进位信息，例如
  $ 
    & 01001011 quad quad && 01001011\ 
    arrowhead.t space & 00111010 quad quad \& space && 00111011\ 
    = space & overline(01110001) quad quad = space && overline(00001011)
  $
  由于进位是需要加到更高位上的，还需要将$a space \& space b$的结果左移$1$位才能使用，如此，我们就得到了新的加数$a' := a arrowhead.t b, space b' := (a space \& space b) << 1$，相同的规则可以应用在$a', b'$上，再产生新的加数，重复执行这一过程，直到$(a space \& space b) << 1 = 0$，就完成了完整的加法

  代码实现如下：
  ```cpp
  int Add(int a, int b) {
      int sum = 0;
      while (b) {
          sum = a ^ b;
          b = (a & b) << 1;
          a = sum;
      }
      return a;
  }
  ```
+ 减法
  
+ 乘法

+ 除法
= 函数
= 面向对象编程
= 泛型编程
