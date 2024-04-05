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
过大的整数无法使用基本整数类型进行存储和运算，只能以数组的形式去存储整数的每一位，为了满足运算时的进位、借位等处理，应当将每一位保存为```cpp int```并倒序存储

输入时，应当将大整数作为字符串整体输入，以便获取整数的位数、大小、符号信息
  
设正整数$ a &:= 123456789987654321123456789,\ b &:= 3875109875159571357835819359817 $依次输入$a, b$，则表示$a, b$的代码实现如下
```cpp
void Transform(const std::string& numStr, std::vector<int>& num) {
    for (int i = numStr.size() - 1; i >= 0; --i) {
        num[numStr.size() - i - 1] = numStr[i] - '0';
    }
}

std::string aStr, bStr;
std::cin >> aStr >> bStr;
int k = std::max(aStr.size(), bStr.size());
std::vector<int> a(k), b(k);
Transform(aStr, a);
// a: 9 8 7 6 5 4 3 2 1 1 2 3 4 5 6 7 8 9 9 8 7 6 5 4 3 2 1 0 0 0 0
Transform(bStr, b);
// b: 7 1 8 9 5 3 9 1 8 5 3 8 7 5 3 1 7 5 9 5 1 5 7 8 9 0 1 5 7 8 3
```
==== 四则运算
假设$a >= 0$且有$n$位，$b >= 0$且有$m$位，设$a_i, b_i$分别为$a, b$的第$i + 1$位，我们知道，对于十进制数$a, b$，有$0 <= a_i, b_i <= 9$，且第$i + 1$位的位权为$i$，$a, b$的数值与$a_i, b_i$有以下关系$ a = a_(n - 1)...a_3a_2a_1&a_0 = sum_(i = 0)^(n - 1)a_i dot 10^i\ b = b_(m - 1)...b_3b_2b_1&b_0 = sum_(i = 0)^(m - 1)b_i dot 10^i $
+ 加法

  设$a n s = a + b$，其中$a, b$均为$k$位正整数
  
  两个至多$k$位的正整数相加，结果位数至多为$k + 1$位，因此，$a, b, a n s$数组的长度都应当为$k + 1$
  
  计算$a + b$时，首先要将$a_i, b_i$逐位相加，即$a n s_i = a_i + b_i$，如果不考虑进位，即允许$a n s_i > 9$，那么会得到形如$n = 1 space 3 space 46 space 8$的数，其中$n_1 = 46$，在计算$n$的数值时，$46 times 10^1 = 4 times 10^2 + 6 times 10^1$，如果将$4$加到$n_2$上，就可以得到标准十进制表示$n' = 1 space 7 space 6 space 8$，显然，$n$与$n'$表示的数值是相等的
  
  容易得到，将每个$n_(i + 1)$加上$floor(n_i / 10)$，再将$n_i$变为$n_i % 10$，就可以将$n$转化为其标准十进制表示，代码实现如下
  ```cpp 
  for (int i = 0; i < k + 1; ++i) {
      n[i + 1] += n[i] / 10;
      n[i] %= 10;
  }
  ```
  为了避免下标出现```cpp i + 1```导致越界，可以创建一个变量```cpp carry```来保存进位，优化后的代码如下
  ```cpp 
  int carry = 0;
  for (int i = 0; i < k + 1; ++i) {
      n[i] += carry;
      carry = n[i] / 10;
      n[i] %= 10;
  }
  ```
  最终输出结果应当删除前导$0$

  综上所述，$a + b$的代码实现如下
  ```cpp
  std::vector<int> ans(k + 1)
  int carry = 0;
  for (int i = 0; i < k + 1; ++i) {
      ans[i] = a[i] + b[i] + carry;
      carry = ans[i] / 10;
      ans[i] %= 10;
  } // 计算

  while (k > 0 && ans[k] == 0) {
      --k;
  } // 去除前导 0, 注意结果为 0 的情况

  for (int i = k; i >= 0; --i) {
      std::cout << ans[i];
  } // 输出结果
  ```
+ 减法

  设$a n s = a - b$，其中$a, b$均为$k$位正整数
  
  两个至多$k$位的正整数相减，结果位数至多为$k$位，因此，$a, b, a n s$数组的长度都应当为$k$

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

+ 大整数类
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
