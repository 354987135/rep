#set text(font: ("Linux Libertine", "Noto Sans SC"), size: 12.5pt)

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
== 目录
- 枚举
  也叫蛮力法（brute force）
- 模拟
  利用程序模拟解题时的过程并最终得出答案，用于一些无法套用现成算法思想的问题上
  和枚举法一起俗称暴力求解
- 递归
  - 深度优先搜索
    - 剪枝(prune)优化（分支限界法）
  - 分治
    - 快速排序、归并排序
- 排序
  - 冒泡排序，插入排序、选择排序、希尔排序、计数排序、桶排序、基数排序
  - 归并排序、快速排序（放在分治法一章）
  - 堆排序（放在二叉树-堆一章）
- 二分
  - 二分查找
    - upper_bound() 和 lower_bound()
  - 三分
- 倍增
- 递推
- 贪心
- 动态规划
== 复杂度
=== 复杂度的概念
复杂度 (Complexity) 分为时间复杂度和空间复杂度，并称时空复杂度，是以问题规模 $n$ 为自变量的函数

时间复杂度描述的是执行一个算法需要消耗的时间的量级，时间复杂度越低则表示算法越优秀，并不是描述一个算法在某台计算机上执行消耗的具体时间，在不同的计算机上执行相同的程序很可能会消耗不同的时间，这不影响一个算法的时间复杂度。

空间复杂度描述的是执行一个算法需要消耗的存储空间的量级，空间复杂度越低则算法越优秀，对于一个算法来说，其时空复杂度往往是相互影响的，在追求较低的时间复杂度时可能会使空间复杂度变差，反之亦然

通常我们更关注算法在最坏情况下的时空复杂度，并以此评估程序能否在指定时间、指定空间下解决问题
=== 渐进符号
如果 $f(n) = O(g(n))$，表示 $f(n)$ 的增长速度至多和 $g(n)$ 一样快，这种记号称为 $O$ 表示法 (大 $O$ 表示法)

如果 $f(n) = Omega(g(n))$，表示 $f(n)$ 的增长速度至少和 $g(n)$ 一样快，这种记号称为 $Omega$ 表示法 (大 $Omega$ 表示法)

如果 $f(n) = Theta(g(n))$，表示 $f(n)$ 的增长速度和 $g(n)$ 一样快，这种记号称为 $Theta$ 表示法 (大 $Theta$ 表示法)

在描述一个算法的时空复杂度时， $Theta$ 表示法最精确，实际应用中会更多地使用 $O$ 表示法粗略描述一个算法的复杂度
=== 复杂度的比较
当问题的规模 $n arrow +inf$ 时，$n$ 对 $f(n)$ 增长速度的影响远大于常数项，并且此时高阶项的增长速度远大于低阶项，因此对于复杂度来说只需要关注最高阶的一项，通过比较最高阶的增长速度来评价复杂度的优劣

常见的复杂度优劣的比较：
$O(1)<O(log n)<O(sqrt{n})<O(n)<O(n log n)<O(n^2)<O(n^3)<O(2^n)<O(n!)<O(n^n)$

其中对数阶的底数通常不写，默认是 $2$ ，其他底数的对数可以通过换底公式转换为以 $2$ 为底的对数，原来的底数就是 $log n$ 前面的常数，例如：$log_3n=frac{log_2n}{log_23}=frac{1}{log_23}log n$，因此即使底数不同也属于同阶
=== 普通递归算法的时间复杂度
以汉诺塔问题的递归解法为例

有 $n$ 个盘片要移动到 $C$ 柱，根据规则，要先将上面 $n-1$ 个盘片移动到 $B$ 柱，再移动最下面 $1$ 个盘片到 $C$ 柱，然后把剩下的 $n-1$ 个盘片移动到 $C$ 柱，这样就完成了，对于那 $n-1$ 个盘片，可以采取相同的策略，把上面 $n-2$ 个盘片先移动到 $A$ 柱，此时 $B$ 柱上是编号为 $n-1$ 的第 $2$ 大的盘片，将它移动到 $C$ 柱即可，依此类推，可以递推到只有 $2$ 个盘片的情况，而当只有 $1$ 个盘片时，只需要将盘片从 $A$ 柱移动到 $C$ 柱就完成了，这就是一个递归算法的过程

函数参数中的 $A$ 代表起始位置，$B$ 代表中间的过渡位置，$C$ 代表目标位置，并非指实际的 $A, B, C$ 柱
```cpp
void hanoi(int n, char A = 'A', char B = 'B', char C = 'C') {
    if (n == 1) {
        std::cout << "盘片" << n << ": " << A << "->" << C << "\n";
        return;
    }
    hanoi(n - 1, A, C, B);
    std::cout << "盘片" << n << ": " << A << "->" << C << "\n";
    hanoi(n - 1, B, A, C);
}
```
该算法的时间复杂度为
$$
\large
T(n) = 
\left\{
    \begin{array}{lr}
    O(1), \quad n = 1  \\\\
    2T(n-1)+1, \quad n > 1
    \end{array}
\right.
$$
当 $n>1$ 时，变形该递推式
$$
\large
\begin{align*}
T(n)
&= 2T(n-1)+1\\ 
&= 2[2T(n-2)+1]+1\\
&= 2^2T(n-2)+2+1\\
&= 2^2[2T(n-3)+1]+2+1\\
&= 2^3T(n-3)+2^2+2+1\\
&=\dots\\
&=2^{n-1}T(1)+2^{n-2}+\dots+2+1\\
&=2^{n-1}+2^{n-2}+\dots+2+1\\
&=2^n-1\\
\end{align*}
$$
当 $n=1$ 时，$T(1)=1$ 也满足此式，最后可以得到汉诺塔递归算法的时间复杂度 $T(n) = O(2^n)$
=== 尾递归
== 二分查找
```cpp
std::vector<int> v {1, 2, 3, 4, 5, 6};
// type 1
int l = 0, r = v.size() - 1, val = 3;
while (l <= r) {
    int mid = (r - l) / 2 + l;
    if (v[mid] == val) {
        std::cout << mid << '\n';
    } else if (v[mid] > val) {
        r = mid - 1;
    } else {
        l = mid + 1;
    }
}
// type 2
int ans = 0, val = 3;
for (int step = v.size() / 2; step >= 1; step /= 2) {
    while (ans + step < v.size() && v[ans + step] <= val) {
        ans += step;
    }
    if (v[ans] == val) {
        std::cout << ans << '\n';
    } else {
        std::cout << "no ans\n";
    }
}
```
=== stl中的二分查找函数
定义在<algorithm>头文件中

std::lower_bound(begin, end, x)：
在以begin和end迭代器标识的有序（按 < 关系有序）range中，寻找第一个不先序于x（即 >= x）的元素，返回该元素的迭代器

std::upper_bound(begin, end, x)：
在以begin和end迭代器标识的有序（按 < 关系有序）range中，寻找第一个先序于x（即 > x）的元素，返回指向该元素的迭代器

以上 2 个函数，如果未找到目标元素，则返回传入的 end 迭代器

std::equal_range(begin, end, x)：
同时进行std::lower_bound(begin, end, x) 和 std::upper_bound(begin, end, x)，以pair形式返回结果，其中first成员是std::lower_bound(begin, end, x)的返回值，second成员是std::upper_bound(begin, end, x)的返回值
second - first 可以得到等于 x 的元素的个数

std::binary_search(begin, end, x)：
在以begin和end迭代器标识的有序（按 < 关系有序）range中，查找是否存在x，返回bool值
== 递归
=== 计算机中的函数与数学函数的区别
计算机中的函数根据输入的参数的性质不同，可能对整体程序造成不同的影响，而数学函数总是能够得到相同的结果，例如，$x$是全局变量时与$x$是局部变量时，整个程序的表现可能是不同的，编程中也可以编写出与数学函数性质相同的函数，称为纯函数
=== 递归的概念
递归指的是函数调用自身的行为，这种行为可以被直接触发 (在函数定义中调用自身)，也可以被间接触发 (调用其他函数时，其他函数中包含了对该函数的调用)

递归可以将复杂的问题分解为简单的子问题并逐步解决，一个问题不能被无限分解，终止这种分解的条件称为基线条件

递归函数执行时，首先由操作系统将每一次函数调用压入调用栈中，当遇见基线条件后，从栈顶到栈底依次执行所有函数调用，得到结果

递归可以与循环互相转换，通常来说，使用递归的代码相较于循环具有良好的可读性，但会增加算法的时间和空间复杂度

若函数的递归调用只出现在最后，则该类型的递归称为尾递归
==== 经典例题——汉诺塔问题
移动盘子
```cpp
using State = std::map<char, std::vector<int>>; 
// 无视规则，将 n 个盘子从 from 柱移动到 to 柱上
State MoveDisks(State s, int n, char from, char to) {
    std::vector<int> temp(n);
    for (int i = 0; i < n; ++i) {
        temp[i] = s[from].back();
        s[from].pop_back();
    }
    for (int i = n - 1; i >= 0; --i) {
        s[to].push_back(temp[i]);
    }
    return s;
}
```
=== 搜索
利用递归进行的枚举称为搜索，相较于利用循环枚举来说，递归枚举具有代码简洁、适用范围广的优势，在使用循环枚举时我们需要明确知道具体的解，而搜索时只需要知道解的初始情况和最终情况，中间的所有解都会由递归函数自动生成

==== 搜索定义
  搜索是来自图的算法（用于遍历图的节点），因此在学习搜索算法之前最好先学习图数据结构
  在非图论题目中的应用是：找出问题解空间中所有的节点，它们之间通常会有一定的逻辑连接，这些连接就可以看作是图的边，而不同的解就可以看作是图的节点，这样我们就可以将问题使用图进行建模，从而进行dfs和bfs
==== 搜索算法的分类
  bfs -- 主要用于明确的图论问题中
  dfs -- 可以用于暴力搜寻普通问题的解，和图论问题的关联性不如bfs强
=== 分治法
==== 分治算法的时间复杂度
==== 主定理 ( Master Theorem )
设时间复杂度为 $T(n)$，则 
$$\large T(n) = aT(\frac{n}{b}) + f(n)$$
其中，$n$ 为问题的规模，$a$ 为子问题的个数，$frac{n}{b}$ 为每个子问题的大小，假设每个子问题的大小相同，$f(n)$ 为将原问题分解为子问题和将子问题合并为原问题的总时间复杂度

$$
Large
T(n)=
left{
    begin{array}{lr}
    O(n^{log_ba}),quad n^{log_ba} > f(n) \\\\
    O(f(n)),quad n^{log_ba} < f(n) \\\\
    O(n^{log_ba}logn),\quad n^{log_ba} = f(n)
    \end{array}
\right.
$$
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
贪心算法并非是某种具有固定代码模板的算法，而是指一种解决问题的策略，在这类问题中，我们需要通过简单的情形找出能够促成最优解的策略，即数学关系式，并使用归纳法证明其对任意有限规模的问题都成立，复杂的问题中通常包含不止一种表面上可能达成最优解的策略，在什么条件下选取什么策略，这也是我们需要证明的

因此，贪心算法的关键就在于找出策略并证明策略，贪心策略是否容易被找出、是否容易被证明，决定了一个贪心类问题的困难程度

动态规划
== 动态规划
和贪心算法类似，动态规划也是一种解决问题的策略，它结合了搜索、贪心、递推的优点，能够在优于搜索的时间复杂度内得到问题的最优解

动态规划是结合了递推法（保存每一步的状态）和贪心法（取局部最优解）的一种算法思想，由于这种特性，动态规划法能够根据保存的状态进行回溯，弥补了贪心算法不能回溯的缺点
=== 动态规划的无后效性
https://www.zhihu.com/question/43361359/answer/2305780848?utm_id=0

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
图由节点和边组成，在实际应用中，节点可以表示任意具体的对象，边可以表示对象之间的关系
=== 最短路径算法
==== 无权图的最短路径
+ 单源最短路径

+ 多源最短路径
bfs
==== 带权图的最短路径
== 哈希表
= 数学
== 组合数学
=== 加法原理
=== 乘法原理
=== 容斥原理
== 数论
== 素性检测
=== 试除法
代码实现如下
```cpp
bool IsPrime(int64_t x) {
    if (x < 2) {
         return false; 
    }
    for (int64_t i = 2; i <= x / i; ++i) {
        if (x % i == 0) { 
            return false; 
        }
    }
    return true;
}
```
== 判断回文数
代码实现如下
```cpp
bool IsPalindrome(int64_t x) {
    if (x < 0 || (x % 10 == 0 && x != 0)) { 
        return false; 
    }
    int64_t r = 0;
    while (x > r) {
        r = r * 10 + x % 10;
        x /= 10;
    }
    return x == r || x == r / 10;
}
```
== 进制转换
== 高精度算法
=== 高精度整数
==== 大整数的表示 <大整数的表示>
设$a$是$n$位正整数，$b$是$m$位正整数，$a_i, b_i$分别为$a, b$的第$i + 1$位，我们知道，对于十进制数$a, b$，有$0 <= a_i, b_i <= 9$，且第$i + 1$位的位权为$i$，$a, b$的数值与$a_i, b_i$有以下关系$ a = a_(n - 1)...a_3a_2a_1&a_0 = sum_(i = 0)^(n - 1)a_i dot 10^i\ b = b_(m - 1)...b_3b_2b_1&b_0 = sum_(i = 0)^(m - 1)b_i dot 10^i $

过大的整数无法使用基本整数类型进行存储和运算，只能以字符型数组或整形数组的形式去存储整数的每一位，其中整型数组便于在运算时处理进位、借位等问题，因此最合适的存储方法是将每一位倒序存储在整形数组中

输入时，可以将大整数作为```cpp std::string```整体输入，以便于获取整数的位数、大小、符号信息
  
设正整数$ a &:= 123456789987654321123456789,\ b &:= 3875109875159571357835819359817 $依次输入$a, b$，则将$a, b$转换为数组存储的代码实现如下
```cpp
std::vector<int> Transform(const std::string& nStr, int size = 0) {
    std::vector<int> n(nStr.size());
    for (int i = 0; i < nStr.size(); ++i) {
        n[i] = nStr[nStr.size() - 1 - i] - '0';
    }
    if (size) {
        n.resize(size);
    }
    return n;
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
==== 比较大整数 <比较大整数>
某些情况下，我们需要比较两个大整数$a, b$的大小关系，其中$a, b$均为非负整数

如果$a, b$位数不同，显然位数少的数更小，如果$a, b$位数相同，那么从高位到低位，找到的第一对不相等的$a_i, b_i$的大小关系就是$a, b$的大小关系

下列_Compare_函数中，返回值$-1, 0, 1$分别表示$a < b, a = b, a > b$
```cpp
int Compare(const std::vector<int>& a, const std::vector<int>& b) {
    int m = a.size();
    while (m > 1 && a[m - 1] == 0) { --m; }
    int n = b.size();
    while (n > 1 && b[n - 1] == 0) { --n; }

    if (m == n) {
        for (int i = m - 1; i >= 0; --i) {
            if (a[i] != b[i]) {
                if (a[i] < b[i]) { return -1; };
                if (a[i] > b[i]) { return 1; };
            }
        }
        return 0;
    }
    if (m < n) { return -1; };
    return 1;
}
```
==== 添加或删除大整数的前导$0$ <添加或删除大整数的前导0>
比第一位有效数字更高位的$0$叫作前导$0$，为了满足实际需求，会为大整数添加或删除前导$0$，因为大整数在数组中是倒序存储的，所以前导$0$就是数组末尾的连续$0$，添加或删除前导$0$就是在数组末尾添加或删除$0$

添加前导$0$只需要使用#link("https://en.cppreference.com/w/cpp/container/vector/resize")[*_std::vector::resize_*]函数

删除前导$0$时需要注意大整数为$0$的情况，这种情况下整个数组的元素都是$0$，要保证数组中至少有$1$个元素

代码实现如下
```cpp
void RemoveRZero(std::vector<int>& n) {
    while (n.size() > 1 && n.back() == 0) {
        n.pop_back();
    }
}
```
==== 四则运算
这一部分只考虑非负整数$a, b$的四则运算，包含负数的完整四则运算将在(*_@大整数类[]_*)讨论
===== 加法 <大整数加法>
+ 位数处理

    设$a n s := a + b$，其中$a, b$为非负整数，且位数至多为$k$位

    两个至多$k$位的非负整数相加，和的位数至多为$k + 1$位，因此，$a n s$数组的长度应当为$k + 1$，$a, b$数组的长度可以为各自位数，或统一为$k$，初始化代码见(*_@大整数的表示[]_*)
  
+ 运算过程

    模拟加法竖式，先将$a_i, b_i$逐位相加，即$a n s_i := a_i + b_i$，逐位相加的代码实现如下(未统一$a, b$位数)
    ```cpp
    std::vector<int> Add(const std::vector<int>& a, const std::vector<int>& b) {
        std::vector<int> ans(std::max(a.size(), b.size()) + 1);
        for (int i = 0; i < a.size(); ++i) { 
            ans[i] += a[i]; 
        } 
        for (int i = 0; i < b.size(); ++i) { 
            ans[i] += b[i]; 
        }
        return ans; 
    }
    ```
    在这一过程中会出现$a n s_i > 9$的情况，得到形如$n = 1 space 3 space 46 space 8$的数，其中$n_1 = 46$，这并不是我们熟知的标准十进制表示，实际上它等价于$n' = 1 space 7 space 6 space 8$，因为$46 times 10^1 = 4 times 10^2 + 6 times 10^1$，将$4$加到$n_2$上，就可以得到$n'$
    
    容易得到，任意$n_i$到$n'_i$的转换满足$ n'_(i + 1) &= n_(i + 1) + floor(n_i / 10)\ n'_i &= n_i mod 10 $当$0 <= n_i <= 9$时，该方程也成立，因此我们可以把加法和进位分开来处理，处理进位的代码实现如下
    ```cpp 
    for (int i = 0; i < k; ++i) {
        n[i + 1] += n[i] / 10;
        n[i] %= 10;
    }
    ```
    为了尽量避免运算过程中出现下标访问越界，需要引入变量```cpp carry```来保存前一位的进位，消去```cpp i + 1```，优化后的代码如下
    ```cpp 
    void Carry(std::vector<int>& n) {
        int carry = 0;
        for (int i = 0; i < n.size(); ++i) {
            n[i] += carry;
            carry = n[i] / 10;
            n[i] %= 10;
        }
    }
    ```

+ 输出处理

    删除$a n s$中的前导$0$(*_@添加或删除大整数的前导0[]_*)，然后倒序输出$a n s$数组

+ 复杂度分析

    时间复杂度为$O(n)$，空间复杂度为$O(n)$，其中$n$为$a, b$位数的较大值 
===== 减法 <大整数减法>
+ 位数处理

    设$a n s := a - b$，其中$a, b$为非负整数，且位数至多为$k$位

    两个至多$k$位的非负整数相减，差的位数至多为$k$位，因此，$a n s$数组的长度应当为$k$，$a, b$数组的长度可以为各自位数，或统一为$k$，初始化代码见(*_@大整数的表示[]_*)

+ 运算过程

    模拟减法竖式，在减法竖式中，要保证被减数大于等于减数，因此首先要考虑$a, b$的大小关系(*_@比较大整数[]_*)，如果$a < 
    b$，则应当先交换$a, b$，再进行计算，并且，这种情况下差为负数，输出时应当带有负号，使用一个```cpp bool ```类型的变量```cpp negative ```来表示差的正负情况
    
    代码实现如下
    ```cpp
    bool negative = false; // 标记差是否为负数
    if (Compare(a, b) < 0) {
        std::swap(a, b);
        negative = true;
    }
    ```
    接下来，先将$a_i, b_i$逐位相减，即$a n s_i := a_i - b_i$，逐位相减的代码实现如下(未统一$a, b$位数)
    ```cpp
    std::vector<int> Subtract(const std::vector<int>& a, const std::vector<int>& b) {
        std::vector<int> ans(std::max(a.size(), b.size()));
        for (int i = 0; i < a.size(); ++i) { 
            ans[i] += a[i]; 
        } 
        for (int i = 0; i < b.size(); ++i) {
            ans[i] -= b[i];
        }
        return ans;
    }
    ```
  
    在这一过程中会出现$a n s_i < 0$的情况，得到形如$n = 1 space 3 space -23 space 8$的数，其中$n_1 = -23$，和加法类似(*_@大整数加法[]_* - (2. 运算过程))，它等价于$n' = 1 space 0 space 7 space 8$，因为$-23 times 10^1 = -3 times 10^2 + 7 times 10^1 $，将$-3$加到$n_2$上，就可以得到$n'$，不难看出，借位相当于负的进位，当$n_i < 0$时，$n_i$到$n'_i$的转换和$n_i > 9$的情况是相同的，减法和借位也可以分开处理
    
    由于```cpp /```运算符的结果是向$0$取整的，对负数使用```cpp %```运算符求余数可能会得到负数，当余数为负数时，说明```cpp /```运算符求得的商比预期大$1$，正确结果应当再减去$1$，此时对应的余数为正数，加上模数$10$即可得到正确的余数
    
    改进后的进位处理代码实现如下
    ```cpp
    void Carry(std::vector<int>& n) {
        int carry = 0;
        for (int i = 0; i < n.size(); ++i) {
            n[i] += carry;
            carry = n[i] / 10 - (n[i] % 10 < 0);
            n[i] = n[i] % 10 + (n[i] % 10 < 0) * 10;
        }
    }
    ```
    该代码可以处理$n_i$为任意整数的情况

+ 输出处理
    
    删除$a n s$中的前导$0$(*_@添加或删除大整数的前导0[]_*)，然后判断是否应当输出负号，最后倒序输出$a n s$数组
    
    判断是否应当输出负号的代码实现如下
    ```cpp
    if (negative) { 
        std::cout << '-'; 
    }
    ```

+ 复杂度分析

    时间复杂度为$O(n)$，空间复杂度为$O(n)$，其中$n$为$a, b$位数的较大值
===== 乘法 <大整数乘法>
+ 位数处理

    设$a n s := a times b$，其中$a, b$为非负整数，且$a$为$m$位，$b$为$n$位

    一个$m$位的非负整数与一个$n$位的非负整数相乘，积的位数至多为$m + n$位，因此，$a n s$数组的长度应当为$m + n$，$a, b$数组的长度应当为各自的位数$m, n$，初始化代码见(*_@大整数的表示[]_*)
+ 运算过程

    观察下列$a times b$乘法竖式的计算过程，其中$a, b$分别为$6, 3$位，$c$是$a times b$的积
    $ a_5 #h(21pt) a_4 #h(21pt) a_3 #h(21pt) a_2 #h(20.5pt) a_1 #h(20.5pt) &a_0 \ 
    times #h(116pt) b_2 #h(22pt) b_1 #h(21pt) &b_0 \
    overline(#h(22pt) a_5b_0 #h(10.5pt) a_4b_0 #h(10.5pt) a_3b_0 #h(10pt) a_2b_0 #h(10.5pt) a_1b_0 #h(10.5pt) a_0) &overline(b_0) \
    a_5b_1 #h(10.5pt) a_4b_1 #h(10.5pt) a_3b_1 #h(10.5pt) a_2b_1 #h(10.5pt) a_1b_1 #h(10.5pt) a_0b_1 #h(21pt) \
    a_5b_2 #h(10.5pt) a_4b_2 #h(10.5pt) a_3b_2 #h(10.5pt) a_2b_2 #h(10.5pt) a_1b_2 #h(10.5pt) a_0b_2 #h(52.5pt) \
    overline(c_8 #h(22pt) c_7 #h(22pt) c_6 #h(21pt) c_5 #h(21pt) c_4 #h(21pt) c_3 #h(21.5pt) c_2 #h(21.5pt) c_1 #h(22pt)) &overline(c_0) $
    我们可以发现，将每个$b_i$乘上$a$得到的结果左移$i$位后加起来，也就是把每一个$a_i b_j$加到$c_(i + j)$上，就可以得到积$c$，因此，乘法实际上就是多次加法计算，此外，乘法满足交换律，所以$a, b$在乘法竖式中的上下位置可以交换，不影响$c$的值

    因此，计算$a times b$就是模拟乘法竖式，先得到未处理进位的积$c$，再像加法一样处理进位(*_@大整数加法[]_*)，就可以得到最终的结果$a n s$，计算$c$的代码实现如下
    ```cpp
    std::vector<int> Multiply(const std::vector<int>& a, const std::vector<int>& b) {
        std::vector<int> ans(a.size() + b.size());
        for (int i = 0; i < a.size(); ++i) {
            for (int j = 0; j < b.size(); ++j) {
                ans[i + j] += a[i] * b[j];
            }
        }
        return ans;
    }
    ```

+ 输出处理

    删除$a n s$中的前导$0$(*_@添加或删除大整数的前导0[]_*)，然后倒序输出$a n s$数组

+ 复杂度分析

    时间复杂度为$O(m n)$，空间复杂度为$O(m + n)$，其中$m, n$分别为$a, b$的位数

+ 大整数乘较小数时的优化

    如果乘法中的一个因子是可以使用基本整数类型存储的较小的数，那么无论这个较小的数实际有多少位，都可以被当成一个整体，即$1$位大整数参与运算，但需要注意，我们依然需要较小数的位数来确定积的位数

    该优化也就是所谓的“高精度乘低精度”，可以使乘法的时间复杂度降低到$O(n)$，其中$n$是大整数的位数
    
    代码实现如下
    ```cpp
    int GetDigit(int n) {
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

    std::vector<int> Multiply(const std::vector<int>& a, int b) {
        std::vector<int> ans(a.size() + GetDigit(b));
        for (int i = 0; i < a.size(); ++i) {
            ans[i] = a[i] * b;
        }
        return ans;
    }

    std::string s; // 大整数
    int b; // 较小数
    std::cin >> s >> b;
    std::vector<int> a = Transform(s);
    std::vector<int> ans = Multiply(a, b);
    Carry(ans);
    RemoveRZero(ans);
    for (int i = ans.size() - 1; i >= 0; --i) {
        std::cout << ans[i];
    }
    ```
===== 除法
+ 位数处理

    设$q$为$a div b$的商，$r$为$a div b$的余数，其中$a$为$m$位非负整数，$b$为$n$位正整数

    一个$m$位的非负整数除以一个$n$位的正整数，商的位数至多为$m - n + 1$位，余数的位数至多为$n$位，实际$a, b, q, r$数组的长度需要逐步分析，见(2. 运算过程)，初始化代码见(*_@大整数的表示[]_*)

+ 运算过程

    考虑下列$a div b$除法竖式中的试商过程，其中$a, b$分别为$6, 3$位
    $ q_5 #h(5pt) q_4 #h(5pt) q_3 #h(5pt) q_2 #h(4pt) q_1 #h(4pt) q_0 &\
    b_2b_1b_0 #h(4pt) overline(")" space a_5 space a_4 space a_3 space a_2 space a_1 space a_0) &\ $

    如果$a, b$均不是使用数组表示的大整数，那么该除法竖式的过程就是从高位到低位逐位试商，即依次求出$q_5$到$q_0$的值，因此，$q$的位数应当和$a$相同，均为$m$位
    
    首先，$q_5$是$a_5 div b_2b_1b_0$的商，显然为$0$，记余数为$r$, $r = r_0 = a_5$，接下来把$a_4$追加到$r$的末尾，得到$r = r_1r_0 = a_5a_4$，$q_4$是$r div b_2b_1b_0$的商，即$a_5a_4 div b_2b_1b_0$的商，显然，$q_4$也为$0$，继续将$a_3$追加到$r$末尾，得到$r = r_2r_1r_0 = a_5a_4a_3$，$q_3$就是$a_5a_4a_3 div b_2b_1b_0$的商，注意到，$q_3$有可能为正数，假设$q_3 > 0$且$b_2b_1b_0 divides.not a_5a_4a_3$，那么$r = a_5a_4a_3 - q_3 times b_2b_1b_0$，显然，$r$的位数至多与$b$的位数相同，记为$r'_2r'_1r'_0$，此时，该除法竖式如下所示

    $ q_3 #h(5pt) q_2 #h(4pt) q_1 #h(4pt) q_0 &\
    b_2b_1b_0 #h(4pt) overline(")" space a_5 space a_4 space a_3 space a_2 space a_1 space a_0) &\ 
    r'_2 #h(5pt) r'_1 #h(5pt) r'_0 #h(43pt) &\ $
   
    在求$q_2$之前，还需要在$r$末尾追加$a_2$，得到$r = r_3r_2r_1r_0 = r'_2r'_1r'_0a_2$，除法竖式如下所示

    因为$r'_2r'_1r'_0 < b_2b_1b_0$且$a_2 < 10$，所以$r'_2r'_1r'_0a_2 < 10 times b_2b_1b_0 => r_(n e x t) = r'a_i - q_i times b < b$，说明在整个除法过程中$r$的最大可能位数是$b$的位数$+ 1$，即$n + 1$位

    $ q_3 #h(5pt) q_2 #h(4pt) q_1 #h(4pt) q_0 &\
    b_2b_1b_0 #h(4pt) overline(")" space a_5 space a_4 space a_3 space a_2 space a_1 space a_0) &\ 
    r'_2 #h(5pt) r'_1 #h(4pt) r'_0 #h(4pt) a_2 #h(29pt) &\ $

    依此类推，可逐步求出所有$q_i$，得到$a div b$的商$q$

    如果$a, b$都是使用数组表示的大整数，则计算$a div b$需要模拟除法竖式，显然，我们不能对大整数进行除法试商

    我们知道，商实际上表示的是被除数中至多能拆分出多少个除数，据此，我们可以把除法试商转化为多次减法，记录下被除数在大于$0$的前提下至多能减去多少次除数，这个次数就是被除数除以除数的商
    
    例如，在计算$q_3$时，不断从$a_5a_4a_3$中减去$b_2b_1b_0$，差记录在$r$中，当$r < b_2b_1b_0$时，停止减法，此时的$r$就是我们要求的$r'_2r'_1r'_0$，减法的次数就是我们要求的$q_3$，该过程涉及到大整数$r, b$的比较(*_@比较大整数[]_*)和减法(*_@大整数减法[]_*)，因此$r$数组的长度应当为$n + 1$，$b$数组的长度可与$r$统一，也可为$b$的位数$n$，如果设置$b$数组的长度为$n$，在比较$r, b$时需要注意比较的位数，当$r$的最高位为$0$时，该$0$不应该参与比较

    此外，除法竖式是从高位向低位计算的，这与乘法(*_@大整数乘法[]_*)相反，在存储$q, r$时需要特别注意这一点

    综上所述，大整数$a, b$的除法代码实现如下(不考虑$b = 0$的情况)
    ```cpp
    struct DivisionResult {
        std::vector<int> q, r;
    };

    DivisionResult Divide(const std::vector<int>& a, const std::vector<int>& b) {
        std::vector<int> q(a.size()), r(b.size() + 1);
        for (int i = a.size() - 1; i >= 0; --i) {
            for (int j = r.size() - 1; j >= 1; --j) {
                r[j] = r[j - 1];
            }
            r[0] = a[i];
            while (Compare(r, b) >= 0) {
                for (int j = 0; j < b.size(); ++j) {
                    r[j] -= b[j];
                }
                Carry(r);
                ++q[i];
            }
        }
        return {q, r};
    }
    ```

+ 输出处理

    除法的结果有$q, r$两个，在输出之前都需要先删除前导$0$(*_@添加或删除大整数的前导0[]_*)，然后倒序输出

+ 复杂度分析
    
    $q$总共$m$位，需要进行$m$次求商操作，每次求商时，$r, b$之间需要进行不超过$9$次的$n + 1$位大整数减法，因此总时间复杂度为$O(m n)$，空间复杂度为$O(max(m, n))$，其中$m, n$分别为$a, b$的位数

+ 大整数除以较小数时的优化

    如果被除数是大整数，除数是可以使用基本整数类型存储的较小的数，那么商依然是大整数，并且保存商的数组长度应当和保存被除数的数组长度相同，而余数和除数一样，也是可以使用基本正数类型存储的较小的数，因此，可以对除数和余数使用除法试商，从而避免重复做时间复杂度为$O(n)$的大整数减法

    该优化也就是所谓的“高精度除以低精度”，可以使除法的时间复杂度降低到$O(n)$，其中$n$是被除数的位数

    代码实现如下
    ```cpp
    struct DivisionResult {
        std::vector<int> q;
        int r;
    };

    DivisionResult Divide(const std::vector<int>& a, int b) {
        std::vector<int> q(a.size());
        int r = 0;
        for (int i = a.size() - 1; i >= 0; --i) {
            r = r * 10 + a[i];
            q[i] = r / b;
            r %= b;
        }
        return {q, r};
    }

    std::string s; // 大整数
    int b; // 较小数
    std::cin >> s >> b;
    std::vector<int> a = Transform(s);
    DivisionResult ans = Divide(a, b);
    RemoveRZero(ans.q);
    for (int i = q.size() - 1; i >= 0; --i) {
        std::cout << q[i];
    }
    std::cout << '\n' << ans.r;
    ```
==== 大整数类 <大整数类>
===== 基本设计
实现输入输出(```cpp >>, << ```运算符)，实现加法、减法、乘法、除法和模运算(```cpp +, -, *, /, % ```运算符)，其中除法和模运算不考虑除数为$0$的情况，实现比较运算(```cpp ==, !=, <, <=, >, >= ```运算符)，所有运算都需要包含对负数的处理

每个大整数需要一个```cpp int ```数组成员倒序存储绝对值，一个```cpp bool ```变量存储正负信息，构造函数需要能够通过字符串构造大整数
===== 带负数的四则运算
+ 加法
    
    设$a n s$为$a + b$的和

    当$a >= 0 and b >= 0$或$a < 0 and b < 0$，即$a, b$同号时，$|a n s| = |a| + |b|$，$a n s$的符号与$a$相同

    当$a >= 0 and b < 0$或$a < 0 and b >= 0$时，若$|a| = |b|$，则$a n s = 0$，若$|a| > |b|$，则$|a n s| = |a| - |b|$，$a n s$的符号与$a$相同，若$|a| < |b|$, 则$|a n s| = |b| - |a|$，$a n s$的符号与$a$相反

+ 减法

    设$a n s$为$a - b$的差

    当$a >= 0 and b < 0$或$a < 0 and b >= 0$，即$a, b$异号时，$|a n s| = |a| + |b|$，$a n s$的符号与$a$相同

    当$a >= 0 and b >= 0$或$a < 0 and b < 0$时，若$|a| = |b|$，则$a n s = 0$，若$|a| > |b|$，则$|a n s| = |a| - |b|$，$a n s$的符号与$a$相同，若$|a| < |b|$, 则$|a n s| = |b| - |a|$，$a n s$的符号与$a$相反

+ 乘法

    设$a n s$为$a * b$的积

    $|a n s| = |a| * |b|$，若$a, b$其中之一为$0$，则$a n s = 0$，如果$a, b$同号，则$a n s$为正，否则为负

+ 除法

    设$q'$为$a div b$的商，要求向$-oo$取整，$|q|$为$|a| div |b|$的商，$r'$为$a div b$的余数，$|r|$为$|a| div |b|$的余数，其中$b != 0$
    
    当$a >= 0 and b >= 0$或$a < 0 and b < 0$时，$|q'| = |q|, |r'| = |r|$，$q$的符号为正，$r$的符号与$b$相同

    当$a >= 0 and b < 0$或$a < 0 and b >= 0$时，$|q'| = |q| + 1, |r'| = |b| - |r|$，$q$的符号为负，$r$的符号与$b$相同
===== 完整代码
```cpp
class BigInt {
private:
    std::vector<int> num;
    bool negative;

    static int GetDigit(int n) {
        n = std::abs(n);
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

    static void Carry(std::vector<int>& n) {
        int carry = 0;
        for (int i = 0; i < n.size(); ++i) {
            n[i] += carry;
            carry = n[i] / 10 - (n[i] % 10 < 0);
            n[i] = n[i] % 10 + (n[i] % 10 < 0) * 10;
        }
    }

    static void RemoveRZero(std::vector<int>& n) {
        while (n.size() > 1 && n.back() == 0) {
            n.pop_back();
        }
    }

    static int Compare(const std::vector<int>& a, const std::vector<int>& b) {
        int m = a.size();
        while (m > 1 && a[m - 1] == 0) { --m; }
        int n = b.size();
        while (n > 1 && b[n - 1] == 0) { --n; }

        if (m == n) {
            for (int i = m - 1; i >= 0; --i) {
                if (a[i] != b[i]) {
                    if (a[i] < b[i]) { return -1; };
                    if (a[i] > b[i]) { return 1; };
                }
            }
            return 0;
        }
        if (m < n) { return -1; };
        return 1;
    }

    static std::vector<int> Add(const std::vector<int>& a, const std::vector<int>& b) {
        std::vector<int> ans(std::max(a.size(), b.size()) + 1);
        for (int i = 0; i < a.size(); ++i) {
            ans[i] += a[i];
        }
        for (int i = 0; i < b.size(); ++i) {
            ans[i] += b[i];
        }
        return ans;
    }

    static std::vector<int> Subtract(const std::vector<int>& a, const std::vector<int>& b) {
        std::vector<int> ans(std::max(a.size(), b.size()));
        for (int i = 0; i < a.size(); ++i) {
            ans[i] += a[i];
        }
        for (int i = 0; i < b.size(); ++i) {
            ans[i] -= b[i];
        }
        return ans;
    }

public:
    BigInt(bool neg = false) : negative(neg) {}

    BigInt(const std::string& s) {
        negative = s[0] == '-';
        num.resize(s.size() - negative);
        for (int i = 0; i < s.size() - negative; ++i) {
            num[i] = s[s.size() - 1 - i] - '0';
        }
    }

    BigInt(const char* s) {
        *this = BigInt(std::string(s));
    }
    
    friend std::ostream& operator<<(std::ostream& os, const BigInt& n) {
        if (n.negative) {
            os << '-';
        }
        for (int i = n.num.size() - 1; i >= 0; --i) {
            os << n.num[i];
        }
        return os;
    } 

    friend std::istream& operator>>(std::istream& is, BigInt& n) {
        std::string s;
        is >> s;
        n = BigInt(s);
        return is;
    }

    friend bool operator==(const BigInt& a, const BigInt& b) {
        return a.negative == b.negative && BigInt::Compare(a.num, b.num) == 0;
    }

    friend bool operator!=(const BigInt& a, const BigInt& b) {
        return !(a == b);
    }

    friend bool operator<(const BigInt& a, const BigInt& b) {
        if (a.negative ^ b.negative) {
            return a.negative;
        }
        if (a.negative) {
            return BigInt::Compare(a.num, b.num) > 0;
        }
        return BigInt::Compare(a.num, b.num) < 0;
    }

    friend bool operator<=(const BigInt& a, const BigInt& b) {
        return a < b || a == b;
    }

    friend bool operator>(const BigInt& a, const BigInt& b) {
        return a != b && !(a < b);
    }

    friend bool operator>=(const BigInt& a, const BigInt& b) {
        return a > b || a == b;
    }

    friend BigInt operator-(const BigInt& n) {
        BigInt ans = n;
        ans.negative = !n.negative;
        return ans;
    }

    friend BigInt operator+(const BigInt& a, const BigInt& b) {
        BigInt ans;

        if (!(a.negative ^ b.negative)) {
            ans.negative = a.negative;
            ans.num = BigInt::Add(a.num, b.num);
        } else {
            if (BigInt::Compare(a.num, b.num) < 0) {
                ans.negative = !a.negative;
                ans.num = BigInt::Subtract(b.num, a.num);
            } else if (BigInt::Compare(a.num, b.num) > 0){
                ans.negative = a.negative;
                ans.num = BigInt::Subtract(a.num, b.num);
            } else {
                ans.num.resize(1);
            }
        }
        BigInt::Carry(ans.num);

        BigInt::RemoveRZero(ans.num);
        return ans;
    }

    friend BigInt operator-(const BigInt& a, const BigInt& b) {
        BigInt ans;

        if (a.negative ^ b.negative) {
            ans.negative = a.negative;
            ans.num = BigInt::Add(a.num, b.num);
        } else {
            if (BigInt::Compare(a.num, b.num) < 0) {
                ans.negative = !a.negative;
                ans.num = BigInt::Subtract(b.num, a.num);
            } else if (BigInt::Compare(a.num, b.num) > 0) {
                ans.negative = a.negative;
                ans.num = BigInt::Subtract(a.num, b.num);
            } else {
                ans.num.resize(1);
            }
        }
        BigInt::Carry(ans.num);

        BigInt::RemoveRZero(ans.num);
        return ans;   
    }

    friend BigInt operator*(const BigInt& a, const BigInt& b) {
        BigInt ans;
        if (a != BigInt("0") && b != BigInt("0")) { 
            ans.negative = a.negative ^ b.negative;
        }
        ans.num.resize(a.num.size() + b.num.size());

        for (int i = 0; i < a.num.size(); ++i) {
            for (int j = 0; j < b.num.size(); ++j) {
                ans.num[i + j] += a.num[i] * b.num[j];
            }
        }
        BigInt::Carry(ans.num);

        BigInt::RemoveRZero(ans.num);
        return ans;
    }

    friend BigInt operator*(const BigInt& a, int b) {
        BigInt ans;
        if (a != BigInt("0") && b != 0) {
            ans.negative = a.negative ^ (b < 0);
        }
        b = std::abs(b);
        ans.num.resize(a.num.size() + BigInt::GetDigit(b));

        for (int i = 0; i < a.num.size(); ++i) {
            ans.num[i] = a.num[i] * b;
        }
        BigInt::Carry(ans.num);

        BigInt::RemoveRZero(ans.num);
        return ans;
    }

    friend BigInt operator/(const BigInt& a, const BigInt& b) {
        BigInt q, r;
        q.num.resize(a.num.size());
        r.num.resize(b.num.size() + 1);

        for (int i = a.num.size() - 1; i >= 0; --i) {
            for (int j = r.num.size() - 1; j >= 1; --j) {
                r.num[j] = r.num[j - 1];
            }
            r.num[0] = a.num[i];
            while (BigInt::Compare(r.num, b.num) >= 0) {
                for (int j = 0; j < b.num.size(); ++j) {
                    r.num[j] -= b.num[j];
                }
                BigInt::Carry(r.num);
                ++q.num[i];
            }
        }

        if (a.negative ^ b.negative) {
            q.negative = true;
            q.num[0] += 1;
            BigInt::Carry(q.num);
        }

        BigInt::RemoveRZero(q.num);
        return q;
    }

    friend BigInt operator%(const BigInt& a, const BigInt& b) {
        BigInt r(b.negative);
        r.num.resize(b.num.size() + 1);

        for (int i = a.num.size() - 1; i >= 0; --i) {
            for (int j = r.num.size() - 1; j >= 1; --j) {
                r.num[j] = r.num[j - 1];
            }
            r.num[0] = a.num[i];
            while (BigInt::Compare(r.num, b.num) >= 0) {
                for (int j = 0; j < b.num.size(); ++j) {
                    r.num[j] -= b.num[j];
                }
                BigInt::Carry(r.num);
            }
        }

        if (a.negative ^ b.negative) {
            r.num = BigInt::Subtract(b.num, r.num);
            BigInt::Carry(r.num);
        }

        BigInt::RemoveRZero(r.num);
        return r;
    }

    friend BigInt operator/(const BigInt& a, int b) {
        bool b_neg = b < 0;
        b = std::abs(b);
        BigInt q;
        q.num.resize(a.num.size());
        int r = 0;
        for (int i = a.num.size() - 1; i >= 0; --i) {
            r = r * 10 + a.num[i];
            q.num[i] = r / b;
            r %= b;
        }

        if (a.negative ^ b_neg) {
            q.negative = true;
            q.num[0] += 1;
            BigInt::Carry(q.num);
        }

        BigInt::RemoveRZero(q.num);
        return q;
    }

    friend int operator%(const BigInt& a, int b) {
        bool b_neg = b < 0;
        b = std::abs(b);
        int r = 0;
        for (int i = a.num.size() - 1; i >= 0; --i) {
            r = r * 10 + a.num[i];
            r %= b;
        }
        if (a.negative ^ b_neg) {
            r = b - r;
        }
        return b_neg ? -r : r;
    }
};
```
=== 高精度浮点数
== 快速幂
= 综合应用 / 高级数据结构
= 前缀和、差分
为了方便计算，本章中数组的下标均从$1$开始，下标为$0$处的值均为$0$
== 前缀和
前缀和用于降低“多次求数组区间和”类问题的时间复杂度，$n$维数组的前缀和简称“$n$维前缀和”

以一维数组```cpp a ```为例，其前缀和数组```cpp p ```中```cpp p[i] ```定义为

$ p_i = sum_(k = 1)^(i)a_k $

显然，计算```cpp p[i] ```的递推公式为```cpp p[i] = p[i - 1] + a[i] ```

由一维前缀和的定义可得区间$[l, r]$内的和

$ S = sum_(k = l)^(r)a_k = p_r - p_(l - 1) $

通过上式可以将每次求和的时间复杂度优化为$O(1)$

若```cpp a ```为二维数组，那么其前缀和数组```cpp p ```中```cpp p[i][j] ```定义为$ p_(i j) = sum_(k_1 = 1)^(i)sum_(k_2 = 1)^(j)a_(k_1 k_2) $

由图1可知，计算```cpp p[i][j] ```的递推公式为```cpp p[i][j] = p[i][j - 1] + p[i - 1][j] - p[i - 1][j - 1] + a[i][j] ```

由图2可知，由点$(x_1, y_1), (x_2, y_2)$围成的长方形范围内的和

$ S = sum_(k_1 = x_1)^(x_2)sum_(k_2 = y_1)^(y_2)a_(k_1 k_2) = p_(x_2 y_2) - p_(x_1 y_2) - p_(x_2 y_1) + p_(x_1 y_1) $

通过上式可以将每次求和的时间复杂度优化为$O(1)$
== 差分
差分建立在前缀和的基础上，用于降低“多次在数组区间上加$x$，并求修改后的数组”类问题的时间复杂度，$n$维数组的差分简称“$n$维差分”

以一维数组```cpp a ```为例，将一维前缀和递推式中的```cpp p, a```数组分别看作```cpp a, d```数组，移项即可得到差分数组中```cpp d ```中```cpp d[i] ```的定义，即$d_i  = a_i - a_(i - 1)$

根据该定义，我们可以发现

$ sum_(k = 1)^i d_i = a_1 + (a_2 - a_1) + (a_3 - a_2) + ... + (a_i - a_(i - 1)) = a_i $

即原数组```cpp a ```是差分数组```cpp d ```的前缀和数组

因此，如果给$d_i$加上或减去常数$C$后，再通过对差分数组```cpp d ```做前缀和来更新原数组```cpp a ```，那么原数组```cpp a ```中从$a_i$开始的所有项都会被加上或减去$C$

若要给指定的区间$[l, r]$上的每个元素都加$C$，则只需要做$d_l + C$和$d_(r + 1) - C$后更新数组```cpp a ```，利用此性质，可以将对原数组的多次区间修改转化为先对差分数组进行多次修改，再更新原数组，从而降低了整体的时间复杂度

若```cpp a ```为二维数组，由二维前缀和递推式可得，二维差分数组```cpp d ```中```cpp d[i][j] ```定义为

$ d_(i j) = a_(i j) - a_(i j - 1) - a_(i - 1 j) + a_(i - 1 j - 1) $
和一维差分一样，对数组```cpp d ```做前缀和，可以得到原数组```cpp a```，即

$ sum_(k_1 = 1)^(i)sum_(k_2 = 1)^(j)d_(k_1 k_2) = a_(i j) $

此处省略展开计算证明的过程

如图3所示，如果要在点$(x_1, y_1), (x_2, y_2)$围成的长方形范围内整体加常数$C$，那么需要执行$d_(x_1 y_1) + C, d_(x_1 y_2 + 1) - C, d_(x_2 + 1 y_1) - C, d_(x_2 + 1 y_2 + 1) + C $后更新数组```cpp a ```
