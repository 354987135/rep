#set text(font: ("Linux Libertine", "Noto Sans SC"), size: 11pt)

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

= 基础算法
== 二分算法
== 递归
=== 完全搜索
俗称dfs
=== 分治算法
== 排序算法
=== 基于比较的排序
=== 基于桶数组的排序
==== 计数排序
==== 桶排序
==== 基数排序
=== 总结
+ 稳定性
- 稳定性的定义
- 稳定的排序
- 不稳定的排序
+ 额外空间
- 需要额外空间
归并排序，计数排序，桶排序，基数排序
- 不需要额外空间
== 贪心算法
== 动态规划算法
= 基础数据结构
== 线性表
=== 链表
=== 栈
=== 队列
== 树与二叉树
本章的树指的是有根树，即有根节点且边是有向的树
== 图
=== 最短路径算法
==== 无权图的最短路径
+ 单源最短路径

+ 多源最短路径
bfs
==== 带权图的最短路径
== 哈希表
= 数学
== 排列组合
== 素性检测
== 判断回文数
== 进制转换
== 高精度算法
=== 高精度整数
==== 大整数的表示
过大的整数无法使用基本整数类型进行存储和运算，只能以数组的形式去存储整数的每一位，为了便于在运算时处理进位、借位等问题，最合适的存储方法是将每一位保存为```cpp int```并倒序存储

输入时，应当将大整数作为字符串整体输入，以便于获取整数的位数、大小、符号信息
  
设正整数$ a &:= 123456789987654321123456789,\ b &:= 3875109875159571357835819359817 $依次输入$a, b$，则表示$a, b$的代码实现如下
```cpp
std::vector<int> Transform(const std::string& numStr) {
    std::vector<int> num(numStr.size());
    for (int i = numStr.size() - 1; i >= 0; --i) {
        num[numStr.size() - i - 1] = numStr[i] - '0';
    }
    return num;
}

std::string aStr, bStr;
std::cin >> aStr >> bStr;
std::vector<int> a = Transform(aStr), b = Transform(bStr);
// a: 9 8 7 6 5 4 3 2 1 1 2 3 4 5 6 7 8 9 9 8 7 6 5 4 3 2 1
// b: 7 1 8 9 5 3 9 1 8 5 3 8 7 5 3 1 7 5 9 5 1 5 7 8 9 0 1 5 7 8 3
```
==== 比较大整数的大小

==== 四则运算
这一节只考虑正整数$a, b$的四则运算，带符号处理的完整四则运算将在(_@chapter3.5.1.4[]_)讨论

设$a$有$n$位，$b$有$m$位，$a_i, b_i$分别为$a, b$的第$i + 1$位，我们知道，对于十进制数$a, b$，有$0 <= a_i, b_i <= 9$，且第$i + 1$位的位权为$i$，$a, b$的数值与$a_i, b_i$有以下关系$ a = a_(n - 1)...a_3a_2a_1&a_0 = sum_(i = 0)^(n - 1)a_i dot 10^i\ b = b_(m - 1)...b_3b_2b_1&b_0 = sum_(i = 0)^(m - 1)b_i dot 10^i $
+ 加法

  设$a n s = a + b$，其中$a, b$的位数至多为$k$位
  
  两个至多$k$位的正整数相加，结果位数至多为$k + 1$位，因此，为了便于计算和保存结果，$a, b, a n s$数组的长度都应当为$k + 1$
  
  计算$a + b$就是模拟加法竖式的计算过程，首先将$a_i, b_i$逐位相加，即$a n s_i = a_i + b_i$，然后再处理进位，如果允许$a n s_i > 9$，那么我们会得到形如$n = 1 space 3 space 46 space 8$的数，其中$n_1 = 46$，这并不是我们熟知的标准十进制表示，但是它等价于$n' = 1 space 7 space 6 space 8$，因为$46 times 10^1 = 4 times 10^2 + 6 times 10^1$，将$4$加到$n_2$上，就可以得到$n'$，显然，$n$与$n'$表示的数值是相等的，同理，对于$a + b$，我们可以先得到$a n s$，再处理每一位$a n s_i$，将其转化为$a n s'$，$a n s'$就是加法运算的结果
  
  转化过程如下$ n'_(i + 1) &= n_(i + 1) + floor(n_i / 10)\ n'_i &= n_i % 10 $代码实现如下
  ```cpp 
  for (int i = 0; i < k + 1; ++i) {
      n[i + 1] += n[i] / 10;
      n[i] %= 10;
  }
  ```
  为了避免下标出现```cpp i + 1```，导致潜在的越界错误，可以创建一个变量```cpp carry```来保存进位，优化后的代码如下
  ```cpp 
  int carry = 0;
  for (int i = 0; i < k + 1; ++i) {
      n[i] += carry;
      carry = n[i] / 10;
      n[i] %= 10;
  }
  ```
  最终$a n s'$可能含有前导$0$，输出时应当删除前导$0$

  综上所述，$a + b$的代码实现如下
  ```cpp
  int k = std::max(aStr.size(), bStr.size()) + 1;
  std::vector<int> a(k), b(k), ans(k);
  int carry = 0;
  for (int i = 0; i < k; ++i) {
      ans[i] = a[i] + b[i] + carry;
      carry = ans[i] / 10;
      ans[i] %= 10;
  } // 计算

  while (k - 1 > 0 && ans[k - 1] == 0) {
      --k;
  } // 去除前导 0, 注意结果为 0 的情况

  for (int i = k - 1; i >= 0; --i) {
      std::cout << ans[i];
  } // 输出结果
  ```
+ 减法

  设$a n s = a - b$，其中$a, b$至多为$k$位
  
  两个至多$k$位的正整数相减，结果位数至多为$k$位，因此，为了便于计算和保存结果，$a, b, a n s$数组的长度都应当为$k$

  计算$a - b$时，首先要保证被减数大于等于减数，否则结果会出现错误，如果$a < b$，则需要交换$a, b$，并且最终结果为负数，代码实现如下
  ```cpp
  bool negative = false;
  if (aStr.size() < bStr.size() || aStr.size() == bStr.size() && aStr < bStr) {
      std::swap(aStr, bStr);
      negative = true;
  }
  ```
  计算时，将$a_i, b_i$逐位相减，即$a n s_i = a_i - b_i$，和加法类似，如果不考虑借位，即允许$a n s_i < 0$，那么会得到形如$n = 1 space 3 space -23 space 8$的数，其中$n_1 = -23$，和加法时的处理一样，$-23 times 10^1 = -3 times 10^2 + 7 times 10^1 $，将$-3$加到$n_2$上就可以得到标准十进制表示$n' = 1 space 0 space 7 space 8$，其计算方法也是将每个$n_(i + 1)$加上$floor(n_i / 10)$，再将$n_i$变为$n_i % 10$，注意负数需要特殊处理，代码实现如下
  ```cpp
  int carry = 0;
  for (int i = 0; i < k; ++i) {
      n[i] += carry;
      carry = n[i] / 10 - (n[i] < 0);
      n[i] = n[i] % 10 + (n[i] < 0) * 10;
  }
  ```
  最终输出结果应当删除前导$0$，并注意是否应该添加负号

  综上所述，$a - b$的代码实现如下
  ```cpp
  std::vector<int> ans(k);
  int carry = 0;
  for (int i = 0; i < k; ++i) {
      ans[i] = a[i] - b[i] + carry;
      carry = ans[i] / 10 - (ans[i] < 0); // 向下取整有错 -10 / 10 = -1， -1-1=-2错误
      ans[i] = ans[i] % 10 + (ans[i] < 0) * 10; // 取模有错 -10 % 10 = 0， 0 + 10 = 10
      // carry = ans[i] / 10 - (ans[i] % 10 < 0);
        // ans[i] = ans[i] % 10 + (ans[i] % 10 < 0) * 10;
  } // 计算

  while (k - 1 > 0 && ans[k - 1] == 0) {
      --k;
  } // 去除前导 0, 注意结果为 0 的情况

  if (negative) {
      std::cout << '-';
  }
  for (int i = k - 1; i >= 0; --i) {
      std::cout << ans[i];
  } // 输出结果
  ```
+ 乘法

+ 带余除法

==== 大整数类 <chapter3.5.1.4>
+ 若$a < 0 and b < 0$，则相当于计算$|a| + |b|$，并在结果中添加负号
+ 若$a >= 0 and b < 0$，则该加法运算实际上是减法运算，相当于计算$|a| - |b|$，并在结果中添加负号
+ 若$a < 0 and b >= 0$，则该加法运算实际上是减法运算，相当于计算$|b| - |a|$，并在结果中添加负号

```cpp
struct BigInt {
    vector<int> num;
    bool negative {};

    friend ostream& operator<<(ostream& os, BigInt n) {
        
    } 
};
```
=== 高精度浮点数
== 快速幂
= 综合应用 / 高级数据结构
