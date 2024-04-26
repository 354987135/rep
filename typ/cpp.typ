#set text(font: ("Linux Libertine", "Noto Sans SC"))

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

= C++程序
== 编译
=== 预处理器
=== 翻译单元
=== 链接器
== C++程序的行为
=== 未定义行为
= 类型与对象
== cv限定符
#link("https://en.cppreference.com/w/cpp/language/cv")[*_cv限定_*]
== 类型转换
= 表达式与值类别
== 移动语义
= 整数与位运算
== 整数的表示
=== 基本概念
整数分为无符号整数和有符号整数，在计算机中均使用有限位的二进制数表示，因此，计算机中整数的大小是有限的
=== 无符号整数的编码
无符号整数不存在负数，不需要考虑符号的表示，因此直接使用其二进制数值表示，例如，要将$55$用$8$位二进制数编码，则先将$55$转为二进制，得到$110111$，再在高位用$0$填补不足的位，就可以得到$55$的$8$位二进制编码$00110111$
=== 有符号整数的编码
+ 有符号整数由于符号的存在，编码时需要表示符号信息，目前被广泛应用的编码方式有$4$种，分别为原码(_sign-magnitude_)，反码(_one's complement_)，补码(_two's complement_)，移码(_offset binary_)

+ 原码类似无符号整数的二进制编码，只是将最高位保留为符号位，用$0$表示非负数，$1$表示负数

+ 反码和补码由原码变换而来，用于解决有负数参与的加减法问题，因此，反码和补码是针对负数的，非负数的原码，反码，补码都是同一个二进制数，并且与相同数值的无符号整数编码相同

    设$x$为非负数，则$-x$的$k$位反码表示为$2^k - 1 - x$，即$underbrace(1...1, "k个1") - x$，相当于保持原码的符号位不变，取反全部数值位，该方法也可以完成从反码到原码的转换

    设$x$为非负数，则$-x$的$k$位补码表示为$2^k - x$，即$1underbrace(0...0, "k个0") - x$，相当于保持原码的符号位不变，取反全部数值位并在最低位$+1$，同时忽略最高位的进位，该方法也可以完成从补码到原码的转换

    补码统一了加减法，大大简化了硬件的复杂度和制造难度，因此，现在绝大多数计算机系统中都使用补码表示整数
  
+ 移码由补码变换而来，用于表示浮点数，此处不深入讨论该问题
== 位运算的注意点
+ 位运算的操作数都是整数，实际参与位运算的是整数的补码

+ 位运算符共$6$个，优先级从高到低排序如下
    + $~$
    + $>>, <<$
    + $\&$
    + $arrowhead.t$
    + $|$
+ 二元位运算符均具有左结合性
== 按位逻辑运算
=== 按位非 <chapter5.2.1>
+ $~$运算符，一元

+ 记$a_i$为$a$补码的第$i$位，$~a$表示对每一个$a_i$做逻辑非运算，相当于取反$a$的每一位，因此也叫按位取反运算，例如$ ~ space & 10110011\ = & overline(01001100) $

+ 基本性质
    - $~a + 1 = -a$
=== 按位与
+ $\&$运算符，二元

+ 记$a_i,b_i$分别为$a,b$补码的第$i$位，$a space \& space b$表示对每一组$a_i,b_i$做逻辑与运算，例如$ & 10110011\ \& space & 01101101\ = & overline(00100001) $

+ 基本性质
    - $a space \& space b = b space \& space a$
    - $a space \& space (b space \& space c) = (a space \& space b) space \& space c$
    - $a space \& space a = a$
    - $a space \& space 0 = 0$
    - $a space \& space ~0 = a$
=== 按位异或 <chapter5.2.3>
+ $arrowhead.t$运算符，二元

+ 记$a_i,b_i$分别为$a,b$补码的第$i$位，$a arrowhead.t b$表示对每一组$a_i,b_i$做逻辑异或运算，例如$ & 10110011\ arrowhead.t space & 01101101\ = & overline(11011110) $
+ 基本性质 
    - $a arrowhead.t b = b arrowhead.t a$
    - $a arrowhead.t (b arrowhead.t c) = (a arrowhead.t b) arrowhead.t c$
    - $a arrowhead.t a = 0$
    - $a arrowhead.t 0 = a$
    - $a arrowhead.t ~0 = ~a$
=== 按位或
+ $|$运算符，二元

+ 记$a_i,b_i$分别为$a,b$补码的第$i$位，$a | b$表示对每一组$a_i,b_i$做逻辑或运算，例如$ & 10110011\ | & 01101101\ = & overline(11111111) $

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

+ 在C++20之前，只有当$a >= 0$时才能对$a$进行按位左移运算，若$a < 0$，则行为未定义，详见#link("https://en.cppreference.com/w/cpp/language/operator_arithmetic#Built-in_bitwise_shift_operators")[*_Built-in bitwise shift operators_*]
=== 按位右移 <按位右移>
+ $>>$运算符，二元

+ $a >> i$表示将$a$的补码整体右移$i$位，如果$a >= 0$，则在左侧补$i$位$0$，如果$a < 0$，则在左侧补$i$位$1$，从而保持$a$的符号不变，并丢弃右侧超出位数范围的$i$位，这一右移规则称为算术右移
  
    例如，$10111011 >> 4$表示将$8$位整数$10111011$右移$4$位，在左侧补$4$位$1$，并丢弃右侧超出$8$位范围的$1011$，得到结果$11111011cancel(1011)$，即$11111011$

+ $i$必须满足$0 <= i < a "的补码位数"$，否则行为未定义

+ 整数是定点数，右移相当于将小数点左移，在二进制下，小数点左移$i$位相当于将原数除以$2^i$，此处还要将结果向$-oo$取整，即$ a >> i = floor(a / 2^i) $
== 综合应用
=== 交换$x,y$
利用按位异或的性质(*_@chapter5.2.3[]_*)，可以得到如下过程
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
根据按位左移运算的定义(*_@chapter5.3.1[]_*)，$1 << i$可以得到一个第$i + 1$位为$1$，其余位为$0$的数，因此，它可以作为掩码屏蔽$x$的其他位，只得到$x$第$i + 1$位的信息，如果$x space \& space (1 << i)$计算结果为$0$，则表示$x$第$i + 1$位上是$0$，否则表示$x$第$i + 1$位上是$1$

假设$x$是$32$位整数，则代码实现如下：
```cpp
int bits = 32;
for (int i = bits - 1; i >= 0; --i) {
    std::cout << (x & (1 << i) ? 1 : 0);
}
```
=== 提取$x$最低的$1$位 <chapter5.4.3>
通过观察可以发现，$n - 1$表示将$n$的补码从最低的$1$位开始取反，例如
$ 
    000underline(10000) - 1 &= 000underline(01111)\ 
    000000underline(10) - 1 &= 000000underline(01)\
    0101underline(1000) - 1 &= 0101underline(0111) 
$也就是说，$-1$可以将形如$...underline(10...0)$的二进制数转换为形如$...underline(01...1)$的二进制数，那么反过来，$+1$可以实现从$...underline(01...1)$到$...underline(10...0)$的转换，这一性质与按位取反运算结合就可以实现部分取反，将取反操作截至最低的$1$位之前

令$x := 11010underline(100)$，则$~x = 00101underline(011), space ~x + 1 = 00101underline(100)$，利用$x space \& space ~x + 1$即可以消去多余的高位，提取出最低的$1$位，得到$00000100$

根据按位取反运算的性质(*_@chapter5.2.1[]_*)，$x space \& space -x$的效果与$x space \& space ~x + 1$相同
=== 删除$x$最低的$1$位 <chapter5.4.4>
该问题相当于提取$x$最低的$1$位之前的位，结合(*_@chapter5.4.3[]_*)，令$x := underline(10110)100$，则$x - 1 = underline(10110)011$，易知$x space \& space (x - 1)$能够达成这一效果
=== 统计$x$补码中$1$的数量
- 方法1

    由(*_@chapter5.4.4[]_*) 可知，$x space \& space (x - 1)$可以删除$x$最低的$1$位，因此只要删除$x$中所有的$1$，并统计删除的次数，即可计算出$x$补码中$1$的数量

    代码实现如下
    ```cpp
    int Popcount(int x) {
        int cnt = 0;
        while (x) {
            x &= x - 1;
            ++cnt;
        }
        return cnt;
    }
    ``` 

- 方法2
  
    从C++20开始，可使用标准库提供的#link("https://en.cppreference.com/w/cpp/numeric/popcount")[*_std::popcount_*]函数直接计算出结果
=== 判断$x$是否为$2$的幂
当$x <= 0$时，$x$显然不是$2$的幂，当$x > 0$时，如果$x$是$2$的幂，根据按位左移运算的性质(*_@chapter5.3.1[]_*)，$x$可以表示为$1 << i$的形式，即$x$的补码中只有一位是$1$，其余位都是$0$，因此，只需要考虑无符号整数$x$，并特判$x = 0$的情况，下列代码都保证$x$是无符号整数，或是满足$x >= 0$的有符号整数

- 方法1

    结合(*_@chapter5.4.3[]_*)可知，当$x$是$2$的幂时，$x$与$x - 1$做按位与运算的结果是$0$

    代码实现如下
    ```cpp 
    if (x && !(x & (x - 1))) {
        // 是 2 的幂
    }
    ```

- 方法2
    
    结合(*_@chapter5.4.3[]_*)可知，当$x$是$2$的幂时，$x$提取出的最低的$1$位与$x$本身相等

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
- 方法3

    从C++20开始，可使用标准库提供的#link("https://en.cppreference.com/w/cpp/numeric/has_single_bit")[*_std::has_single_bit_*]函数直接进行判断
=== 计算$x$的绝对值
假设$x$是$32$位整数，若$x$是正数，则$x >> 31 = 0$，若$x$是负数，则$x >> 31 = -1$，设$m a s k := x >> 31$，由按位取反运算的性质(*_@chapter5.2.1[]_*)可知，$x$的相反数可由$~x + 1$得到，由按位异或运算的性质(*_@chapter5.2.3[]_*)可知，$x space arrowhead.t space -1 = ~x$，因此，当$x$是负数时，$(x space arrowhead.t m a s k) - m a s k = ~x + 1 = -x$，当$x$是正数时，$(x space arrowhead.t m a s k) - m a s k = x$，可以使用该式计算$x$的绝对值

代码实现如下：
```cpp
int Abs(int x) {
    int bits = sizeof x * 8;
    int mask = x >> bits - 1;
    return (x ^ mask) - mask;
}
```
=== 用位运算实现整数四则运算
==== 加法
通过观察可以发现，$a arrowhead.t b$的结果是$a,b$无进位加法的结果，而$a space \& space b$的结果是$a, b$加法的进位信息，例如
$ 
    & 01001011 quad quad && 01001011\ 
    arrowhead.t space & 00111010 quad quad \& space && 00111010\ 
    = & overline(01110001) quad quad = && overline(00001010)
$
由于进位是需要加到更高位上的，还要将$a space \& space b$得到的进位信息左移$1$位处理

只要存在进位，就说明加法还没有完成，如此，我们就得到了新的加数$a' := a arrowhead.t b, space b' := (a space \& space b) << 1$，将相同的规则应用在$a', b'$上，可以产生新的加数，重复执行这一过程，直到不需要再进位，即$(a space \& space b) << 1 = 0$

代码实现如下
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
注意返回值应当是$a$，而不是$s u m$，当$b$初始值为$0$时，返回$s u m$会得到错误结果
==== 减法
根据$a - b = a + (-b)$和按位取反运算的性质(*_@chapter5.2.1[]_*)，减法可以转换为加法实现

代码实现如下
```cpp
int Subtract(int a, int b) {
    return Add(a, Add(~b, 1));
}
```
==== 乘法 <位运算实现乘法>
假设$a, b$均为$8$位无符号整数，$a = 11011011, b = 10110001$，则$a * b$的运算过程如下

$#{let i = 0; while i < 34 {[$space.fig$]; i += 1;}} 11011011\
#{let i = 0; while i < 32 {[$space.fig$]; i += 1;}} * #h(3pt) 10110001\
#{let i = 0; while i < 34 {[$space.fig$]; i += 1;}} overline(11011011)\
#{let i = 0; while i < 33 {[$space.fig$]; i += 1;}} 00000000 #h(2pt) dots.v \
#{let i = 0; while i < 32 {[$space.fig$]; i += 1;}} 00000000 #h(2pt) dots.v #{let i = 0; while i < 1 {[$#h(3pt) dots.v$]; i += 1;}}\
#{let i = 0; while i < 31 {[$space.fig$]; i += 1;}} 00000000 #h(2pt) dots.v #{let i = 0; while i < 2 {[$#h(3pt) dots.v$]; i += 1;}}\
#{let i = 0; while i < 30 {[$space.fig$]; i += 1;}} 11011011 #h(2pt) dots.v #{let i = 0; while i < 3 {[$#h(3pt) dots.v$]; i += 1;}}\
#{let i = 0; while i < 29 {[$space.fig$]; i += 1;}} 11011011 #h(2pt) dots.v #{let i = 0; while i < 4 {[$#h(3pt) dots.v$]; i += 1;}}\
#{let i = 0; while i < 28 {[$space.fig$]; i += 1;}} 00000000 #h(2pt) dots.v #{let i = 0; while i < 5 {[$#h(3pt) dots.v$]; i += 1;}}\
#{let i = 0; while i < 27 {[$space.fig$]; i += 1;}} 11011011 #h(2pt) dots.v #{let i = 0; while i < 6 {[$#h(3pt) dots.v$]; i += 1;}}\
#{let i = 0; while i < 34 {[$space.fig$]; i += 1;}} overline(01101011) = (107)_10$

从低位到高位，每次使用$b$的一位$b_i$与$a$整体相乘，得到一个部分积，如果$b_i$是$0$，则该部分积是$0$，如果$b_i$是$1$，则该部分积是$a$，之后将该部分积左移$i$位，并在右侧补$i$位$0$，如此得到所有的部分积后，将它们累加起来并丢弃超出范围的位，就得到了$a * b$的积

可以看出，乘法的本质也是加法，利用移位运算将乘法转换为加法计算，每次得到部分积后，将$a$左移$1$位，将$b$右移$1$位，直到所有$b_i$都参与计算，此时$b = 0$

由(*_@按位右移[]_*)，可知，对负数执行按位右移运算会在左侧补$1$，即当$b < 0$时，无法形成循环终止条件$b = 0$，因此，在右移之后还需要将最高位设置为$0$

代码实现如下
```cpp
int Multiply(int a, int b) {
    int ans = 0, mask = -1;
    while (b) {
        if (b & 1) {
            ans = Add(ans, a);
        }
        a <<= 1;
        b >>= 1;
    }
    return ans;
}
```

由(*_@按位右移[]_*)，可知，对负数执行按位右移运算会在左侧补$1$，无法形成循环终止条件$b = 0$，因此上述代码不支持$b < 0$的情况，为了解决这个问题，我们需要先计算$|a| * |b|$，再确定积的符号，当$a, b$同号时，积为正，当$a, b$异号时，积为负，并且因为$-0 = 0$，所以$a, b$一个为负一个为$0$的情况不需要单独讨论

假设$a, b$都是$32$位有符号整数，加入符号处理后的代码实现如下
```cpp
int Multiply(int a, int b) {
    int bits = sizeof a * 8;
    // 获取 a, b 的符号
    int sign_a = a >> Add(bits, ~0);
    int sign_b = b >> Add(bits, ~0);
    // 取 a, b 的绝对值，原理见 (4.5.7)
    a = Add(a ^ sign_a, Add(~sign_a, 1));
    b = Add(b ^ sign_b, Add(~sign_b, 1));
    int ans = 0;
    while (b) {
        if (b & 1) {
            ans = Add(ans, a);
        }
        a <<= 1;
        b >>= 1;
    }
    return sign_a ^ sign_b ? Add(~ans, 1) : ans;
}
```
==== 除法
以(*_@位运算实现乘法[]_*)中的$a = 11011011, b = 10110001, c = 01101011$为例，$a * b = c$，假设现在已知$a, c$，需要求出$b$，则$b = c div a$

除法是乘法的逆运算，

代码实现如下
```cpp
int Divide(int a, int b) {
    
}
```
= 指针与数组
== 原始指针
=== 基本概念
+ 提到指针一词时，通常表示的是指向对象的原始指针(_raw pointer_)，也叫裸指针(_naked pointer_)，即类型为```cpp T *``` 的对象，它们的作用是保存```cpp T```类型对象的地址，地址是一个长度固定的十六进制整数，地址长度只与机器字长有关，所以指针占用的内存大小也只与机器字长有关，与```cpp T```无关，在最常见的32位和64位机器上，指针分别占4个字节和8个字节

+ 写法上，```cpp *``` 可以紧贴着```cpp T```写，即```cpp T*```

+ 指针的值
    - 值为空指针常量，即```cpp nullptr```的指针称为空指针(_null pointer_)

    - 哨兵指针，也称为尾后指针

    - 如果指针的值是...，野指针

    - 如果指针指向的对象所占用的内存被释放，但该指针依然指向这块内存，则称该指针为悬垂指针(_dangling pointer_)

    - 野指针，悬垂指针统称无效指针(_invalid pointer_)
+ 通过指针获取其指向的对象的过程称为解引用，此过程需要用到间接寻址运算符```cpp *```，解引用空指针和无效指针是未定义行为

+ 类型为```cpp void *```的指针称为无类型指针，这样的指针仅用于保存地址，不指向任何对象，也不能被解引用
=== 语法
+ 声明指针

+ 
=== 指针与cv限定
见#link("https://en.cppreference.com/w/cpp/language/pointer#Constness")[*_Constness_*]
=== 指针算术运算

= 函数
== 函数指针
== 完美转发
== lambda表达式
在本章之前需要先了解 8.
= 字符与字符串
== 字符
字符
== char
char类型的字符是使用ASCII编码的字符，char的符号由实现定义，通常来说是signed char，能够存储-128\~127范围内的整数，其中 0\~127 范围内的每个整数都代表一个字符，这张整数和字符对应的表称为 ASCII 码表，在表上，32\~126 是可显示字符，0\~31 和 127 是控制字符，不可显示
== C风格字符串
若字符数组以空字符，即```cpp '\0'```结尾，则称该字符数组为C风格字符串，
== \<std::basic_string\>容器
*_std::basic_string\<char\>_*，别名_std::string_，是一个类似_vector\<char\>_的容器，相比_vector\<char\>_，它提供了许多针对字符串处理的功能，
= 面向对象编程
== 类与成员
== 指向类成员的指针
=== 指向数据成员的指针
=== 指向成员函数的指针
= 泛型编程
== 模板
== 函数模板
== 类模板
= 内存管理
== 智能指针
= 异常处理
= 范围与迭代器
== 容器
== 迭代器
迭代器类型、迭代器无效化
