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
+ 大整数的表示

  如果需要处理的整数超过了```cpp long long```(有符号)或```cpp unsigned long long```(无符号)可存储的范围，就无法使用基本整数类型进行存储和运算，只能以数组的形式去存储整数的每一位，为了便于运算时进位和借位，应当将每一位保存为```cpp int```并倒序存储

  输入时，应当将大整数作为字符串整体输入，便于获取位数、大小、符号信息
  
  例如，设$a := 123456789987654321123456789, b := 3875109875159571357835819359817$依次输入，则表示$a, b$的代码实现如下
  ```cpp
  std::string as, bs;
  std::cin >> as >> bs;
  int size = std::max(as.size(), bs.size());
  std::vector<int> a(size), b(size);
  for (int i = as.size() - 1; i >= 0; --i) {
      a[as.size() - i - 1] = as[i] - '0';
  }
  for (int i = bs.size() - 1; i >= 0; --i) {
      b[bs.size() - i - 1] = bs[i] - '0';
  }

  for (int i = 0; i < a.size(); ++i) {
      std::cout << a[i];
  } // 输出 9876543211234567899876543210000
  std::cout << '\n';
  for (int i = 0; i < b.size(); ++i) {
      std::cout << b[i];
  } // 输出 7189539185387531759515789015783
  ```
+ 四则运算
  
  - 加法
    
    首先分析符号情况，若$a < 0, b >= 0$或$a >= 0, b < 0$，则该加法运算实际上是减法运算，
  - 减法

  - 乘法

  - 带余除法

+ 大整数类
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