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
==== 表达式求值
+ 前缀表达式

+ 中缀表达式

+ 后缀表达式
=== 队列
== 树与二叉树
本章的树指的是有根树，即有根节点且边是有向的树
=== 表达式树
先序遍历得到前缀表达式，中序遍历得到中缀表达式，后序遍历得到后缀表达式
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
==== 大整数的表示 <chapter3.5.1.1>
设$a$是$n$位正整数，$b$是$m$位正整数，$a_i, b_i$分别为$a, b$的第$i + 1$位，我们知道，对于十进制数$a, b$，有$0 <= a_i, b_i <= 9$，且第$i + 1$位的位权为$i$，$a, b$的数值与$a_i, b_i$有以下关系$ a = a_(n - 1)...a_3a_2a_1&a_0 = sum_(i = 0)^(n - 1)a_i dot 10^i\ b = b_(m - 1)...b_3b_2b_1&b_0 = sum_(i = 0)^(m - 1)b_i dot 10^i $

过大的整数无法使用基本整数类型进行存储和运算，只能以字符型数组或整形数组的形式去存储整数的每一位，其中整型数组便于在运算时处理进位、借位等问题，因此最合适的存储方法是将每一位倒序存储在整形数组中

输入时，可以将大整数作为```cpp std::string```整体输入，以便于获取整数的位数、大小、符号信息
  
设正整数$ a &:= 123456789987654321123456789,\ b &:= 3875109875159571357835819359817 $依次输入$a, b$，则将$a, b$转换为数组存储的代码实现如下
```cpp
std::vector<int> Transform(const std::string& numStr, int size = 0) {
    std::vector<int> num(numStr.size());
    for (int i = numStr.size() - 1; i >= 0; --i) {
        num[numStr.size() - i - 1] = numStr[i] - '0';
    }
    if (size) {
        num.resize(size);
    }
    return num;
}

std::string aStr, bStr;
std::cin >> aStr >> bStr;

// 不统一长度
std::vector<int> a = Transform(aStr), b = Transform(bStr);
// a: 9 8 7 6 5 4 3 2 1 1 2 3 4 5 6 7 8 9 9 8 7 6 5 4 3 2 1
// b: 7 1 8 9 5 3 9 1 8 5 3 8 7 5 3 1 7 5 9 5 1 5 7 8 9 0 1 5 7 8 3

// 统一长度
int k = std::max(aStr.size(), bStr.size());
std::vector<int> a = Transform(aStr, k), b = Transform(bStr, k);
// a: 9 8 7 6 5 4 3 2 1 1 2 3 4 5 6 7 8 9 9 8 7 6 5 4 3 2 1 0 0 0 0
// b: 7 1 8 9 5 3 9 1 8 5 3 8 7 5 3 1 7 5 9 5 1 5 7 8 9 0 1 5 7 8 3
```
==== 比较大整数的大小 <chapter3.5.1.2>
某些情况下，我们需要比较两个大整数$a, b$的大小关系

如果$a, b$位数不同，显然位数更多的数更大，如果$a, b$位数相同，那么从高位到低位，找到的第一对不相等的$a_i, b_i$的大小关系就是$a, b$的大小关系

以小于关系为例，小于关系的代码实现如下
```cpp
bool LessThan(const std::vector<int>& a, const std::vector<int>& b) {
    if (a.size() != b.size()) {
        return a.size() < b.size();
    }
    for (int i = a.size() - 1; i >= 0; --i) {
        if (a[i] != b[i]) {
            return a[i] < b[i];
        }
    }
    return false;
}
```
==== 删除大整数高位多余的$0$ <chapter3.5.1.3>
高位多余的$0$也叫前导$0$，因为大整数在数组中是倒序存储的，所以前导$0$就是数组末尾多余的连续$0$，有时候为了满足特定需求，会主动在大整数的高位补上前导$0$，例如运算之前统一运算数的位数时，而前导$0$也可能会被动出现，例如运算之后结果的位数比运算数少时

但在输出的时候通常不需要输出这些多余的$0$，现在就来讨论如何删除多余的0
==== 四则运算
这一节只考虑正整数$a, b$的四则运算，带符号处理的完整四则运算将在(_@chapter3.5.1.4[]_)讨论
===== 加法 <chapter3.5.1.3.1>
+ 位数处理

    设$a n s := a + b$，其中$a, b$的位数至多为$k$位

    两个至多$k$位的正整数相加，和的位数至多为$k + 1$位，因此，为了便于计算与保存和，$a, b$数组的长度应当统一为$k$，$a n s$数组的长度应当为$k + 1$，初始化代码见(_@chapter3.5.1.1[]_)
  
+ 运算过程

    模拟加法竖式，先将$a_i, b_i$逐位相加，即$a n s_i = a_i + b_i$，再处理进位，逐位相加的代码实现如下
    ```cpp
    for (int i = 0; i < k; ++i) {
        ans[i] = a[i] + b[i];
    } 
    ```
    在这一过程中会出现$a n s_i > 9$的情况，得到形如$n = 1 space 3 space 46 space 8$的数，其中$n_1 = 46$，这并不是我们熟知的标准十进制表示，实际上它等价于$n' = 1 space 7 space 6 space 8$，因为$46 times 10^1 = 4 times 10^2 + 6 times 10^1$，将$4$加到$n_2$上，就可以得到$n'$
    
    容易得到，任意$n_i$到$n'_i$的转换遵循下列方程$ n'_(i + 1) &= n_(i + 1) + floor(n_i / 10)\ n'_i &= n_i mod 10 $当$0 <= n_i <= 9$时，该方程也成立，代码实现如下
    ```cpp 
    for (int i = 0; i < k + 1; ++i) {
        n[i + 1] += n[i] / 10;
        n[i] %= 10;
    }
    ```
    为了尽量避免运算过程中出现下标访问越界，需要引入变量```cpp carry```来保存前一位的进位，消去```cpp i + 1```，优化后的代码如下
    ```cpp 
    void CarryProcess(std::vector<int>& ans) {
        int carry = 0;
        for (int i = 0; i < ans.size(); ++i) {
            ans[i] += carry;
            carry = ans[i] / 10;
            ans[i] %= 10;
        }
    }
    ```
+ 输出处理

    删除多余的前导$0$()，然后倒序输出

    最终的和可能含有前导$0$，输出时应当删除多余的前导$0$，并考虑结果为$0$的情况
    
    由于存储整数时是倒序存储的，有多种方法可以实现删去前导$0$的效果

    - 利用数组长度标记应当输出的范围，不实际删除$0$，代码实现如下
        ```cpp
        int len = ans.size();
        while (len - 1 > 0 && ans[len - 1] == 0) {
            --len;
        }

        // 倒序输出所有数字
        for (int i = len - 1; i >= 0; --i) {
            std::cout << ans[i];
        }
        ```

    - 直接删除多余的前导$0$，代码实现如下
        ```cpp
        while (ans.size() > 1 && ans.back() == 0) {
            ans.pop_back();
        }

        // 倒序输出所有数字
        for (int i = ans.size() - 1; i >= 0; --i) {
            std::cout << ans[i];
        }
        ```
===== 减法
+ 位数处理

    设$a n s := a - b$，其中$a, b$至多为$k$位

    两个至多$k$位的正整数相减，差的位数至多为$k$位，因此，为了便于计算与保存差，$a, b, a n s$数组的长度都应当为$k$，初始化代码见(_@chapter3.5.1.1[]_)

+ 运算过程

  在减法竖式中，要保证被减数大于等于减数，因此首先要考虑$a, b$的大小关系(_@chapter3.5.1.2[]_)，如果$a < 
  b$，则应当先交换$a, b$，再进行计算，这种情况下差为负数，输出时应当带有负号，代码实现如下
  ```cpp
  bool negative = false; // 标记差是否为负数
  if (LessThan(a, b)) {
      std::swap(a, b);
      negative = true;
  }
  ```
  接下来模拟减法竖式，先将$a_i, b_i$逐位相减，即$a n s_i = a_i - b_i$，再处理借位，逐位相减的代码实现如下
    ```cpp
    for (int i = 0; i < k; ++i) {
        ans[i] = a[i] - b[i];
    } 
    ```
  
  在这一过程中会出现$a n s_i < 0$的情况，得到形如$n = 1 space 3 space -23 space 8$的数，其中$n_1 = -23$，和加法(_@chapter3.5.1.3.1[]_)类似，它等价于$n' = 1 space 0 space 7 space 8$，因为$-23 times 10^1 = -3 times 10^2 + 7 times 10^1 $，将$-3$加到$n_2$上，就可以得到$n'$，不难看出，借位相当于负的进位，因此，当$n_i < 0$时，$n_i$到$n'_i$的转换和$n_i > 9$的情况是相同的
  
  由于```cpp /```运算符的结果是向$0$取整的，对负数使用```cpp %```运算符求余数可能会得到负数，当余数为负数时，说明```cpp /```运算符求得的商比预期大$1$，正确结果应当再减去$1$，此时对应的余数为正数，加上模数$10$即可得到正确的余数，代码实现如下
  ```cpp
  void CarryProcess(std::vector<int>& ans) {
      int carry = 0;
      for (int i = 0; i < ans.size(); ++i) {
          ans[i] += carry;
          carry = ans[i] / 10 - (ans[i] % 10 < 0);
          ans[i] = ans[i] % 10 + (ans[i] % 10 < 0) * 10;
      }
  }
  ```
  该代码可以处理$a n s_i$为任意整数的情况
+ 输出处理
    
    相比加法，输出差时需要额外判断是否输出负号，代码实现如下
    ```cpp
    if (negative) {
        std::cout << '-';
    }
    ```
===== 乘法
+ 位数处理

    设$a n s := a times b$，其中$a$是$m$位，$b$是$n$位

    一个$m$位的正整数与一个$n$位的正整数相乘，积的位数至多为$m + n$位，因此，为了便于计算与保存积，$a, b, a n s$数组的长度都应当为$m + n$
+ 运算过程


+ 输出处理


+ 完整代码


+ 大数乘较小数时的优化

    如果乘法中的一个因子是可以使用基本整数类型存储的较小的数，那么这个较小的数实际有多少位，都可以被当成一个整体，即$1$位大数进行运算，但需要注意，我们依然需要较小数的位数来确定积的位数

    该优化也就是所谓的“高精度乘低精度”，可以使乘法的时间复杂度从$O(m * n)$降低到$O(n)$，代码实现如下
    ```cpp
    int GetDigits(int n) {
        if (n == 0) {
            return 1;
        }
        int cnt = 0;
        while (n > 0) {
            n /= 10;
            ++cnt;
        }
        return cnt;
    }

    std::string s; // 大数
    int n; // 较小数
    std::cin >> s >> n;
    int k = s.size() + GetDigits(n);
    std::vector<int> a = Transform(s, k), ans(k);

    for (int i = 0; i < k; ++i) {
        ans[i] = a[i] * n;
    } // 做乘法

    int carry = 0;
    for (int i = 0; i < k; ++i) {
        ans[i] += carry;
        carry = ans[i] / 10;
        ans[i] %= 10;
    } // 处理进位

    while (k - 1 > 0 && ans[k - 1] == 0) {
        --k;
    } // 去除前导 0, 注意积为 0 的情况 

    for (int i = k - 1; i >= 0; --i) {
        cout << ans[i];
    } // 输出积
    ```
===== 除法
+ 位数处理

+ 运算过程

+ 输出处理

+ 完整代码

==== 大整数类 <chapter3.5.1.4>
===== 实现加法与减法
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
