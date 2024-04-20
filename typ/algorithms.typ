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
== 二分查找
== 递归
=== 计算机中的函数与数学函数的区别
计算机中的函数根据输入的参数的性质不同，可能对整体程序造成不同的影响，而数学函数总是能够得到相同的结果，例如，$x$是全局变量时与$x$是局部变量时，整个程序的表现可能是不同的，编程中也可以编写出与数学函数性质相同的函数，称为纯函数
=== 递归的概念
递归指的是函数调用自身的行为，递归可以将复杂的问题分解为简单的子问题并逐步解决，一个问题不能被无限分解，终止这种分解过程(即终止递归)的条件称为基线条件

递归函数执行时，首先由操作系统将每一次函数调用压入调用栈中，当遇见基线条件后，从栈顶到栈底依次执行所有函数调用，得到结果

递归可以与循环互相转换，通常来说，使用递归的代码相较于循环具有良好的可读性，但会增加算法的时间和空间复杂度

若函数的递归调用只出现在最后，则该类型的递归称为尾递归
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
贪心算法并非一种具有固定模板的算法，而是一种解决问题的策略
动态规划
== 动态规划
和贪心算法类似，动态规划也是一种解决问题的策略，它结合了搜索、贪心、递推的优点
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
== 数论
== 排列组合
== 素性检测
== 判断回文数
== 进制转换
== 高精度算法
=== 高精度整数
==== 大整数的表示 <大整数的表示>
设$a$是$n$位正整数，$b$是$m$位正整数，$a_i, b_i$分别为$a, b$的第$i + 1$位，我们知道，对于十进制数$a, b$，有$0 <= a_i, b_i <= 9$，且第$i + 1$位的位权为$i$，$a, b$的数值与$a_i, b_i$有以下关系$ a = a_(n - 1)...a_3a_2a_1&a_0 = sum_(i = 0)^(n - 1)a_i dot 10^i\ b = b_(m - 1)...b_3b_2b_1&b_0 = sum_(i = 0)^(m - 1)b_i dot 10^i $

过大的整数无法使用基本整数类型进行存储和运算，只能以字符型数组或整形数组的形式去存储整数的每一位，其中整型数组便于在运算时处理进位、借位等问题，因此最合适的存储方法是将每一位倒序存储在整形数组中

输入时，可以将大整数作为```cpp std::string```整体输入，以便于获取整数的位数、大小、符号信息
  
设正整数$ a &:= 123456789987654321123456789,\ b &:= 3875109875159571357835819359817 $依次输入$a, b$，则将$a, b$转换为数组存储的代码实现如下
```cpp
std::vector<int> Transform(const std::string& numStr, int size = 0) {
    std::vector<int> num(numStr.size());
    for (int i = numStr.size() - 1; i >= 0; --i) {
        num[numStr.size() - 1 - i] = numStr[i] - '0';
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
==== 比较大整数 <比较大整数>
某些情况下，我们需要比较两个大整数$a, b$的大小关系

如果$a, b$位数不同，显然位数少的数更小，如果$a, b$位数相同，那么从高位到低位，找到的第一对不相等的$a_i, b_i$的大小关系就是$a, b$的大小关系

以小于关系为例，小于关系的代码实现如下
```cpp
bool LessThan(const std::vector<int>& a, const std::vector<int>& b) {
    if (a.size() == b.size()) {
        for (int i = a.size() - 1; i >= 0; --i) {
            if (a[i] != b[i]) {
                return a[i] < b[i];
            }
        }
    }
    return a.size() < b.size();
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
这一部分只考虑非负整数$a, b$的四则运算，包含负数的完整四则运算将在(_@大整数类[]_)讨论
===== 加法 <大整数加法>
+ 位数处理

    设$a n s := a + b$，其中$a, b$为非负整数，且位数至多为$k$位

    两个至多$k$位的非负整数相加，和的位数至多为$k + 1$位，因此，$a n s$数组的长度应当为$k + 1$，$a, b$数组的长度应当统一为$k$，初始化代码见(_@大整数的表示[]_)
  
+ 运算过程

    模拟加法竖式，先将$a_i, b_i$逐位相加，即$a n s_i := a_i + b_i$，逐位相加的代码实现如下
    ```cpp
    for (int i = 0; i < k; ++i) { 
        ans[i] = a[i] + b[i]; 
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
    为了尽量避免运算过程中出现下标访问越界，需要引入变量```cpp car```来保存前一位的进位，消去```cpp i + 1```，优化后的代码如下
    ```cpp 
    void Carry(std::vector<int>& n) {
        int car = 0;
        for (int i = 0; i < n.size(); ++i) {
            n[i] += car;
            car = n[i] / 10;
            n[i] %= 10;
        }
    }
    ```

+ 输出处理

    删除$a n s$中的前导$0$(_@添加或删除大整数的前导0[]_)，然后倒序输出$a n s$数组

+ 复杂度分析

    时间复杂度为$O(n)$，空间复杂度为$O(n)$，其中$n$为$a, b$位数的较大值 
===== 减法 <大整数减法>
+ 位数处理

    设$a n s := a - b$，其中$a, b$为非负整数，且位数至多为$k$位

    两个至多$k$位的非负整数相减，差的位数至多为$k$位，因此，$a n s, a, b$数组的长度都应当统一为$k$，初始化代码见(_@大整数的表示[]_)

+ 运算过程

    模拟减法竖式，在减法竖式中，要保证被减数大于等于减数，因此首先要考虑$a, b$的大小关系(_@比较大整数[]_)，如果$a < 
    b$，则应当先交换$a, b$，再进行计算，并且，这种情况下差为负数，输出时应当带有负号，使用一个```cpp bool ```类型的变量```cpp negative ```来表示差的正负情况
    
    代码实现如下
    ```cpp
    bool negative = false; // 标记差是否为负数
    if (LessThan(a, b)) {
        std::swap(a, b);
        negative = true;
    }
    ```
    接下来，先将$a_i, b_i$逐位相减，即$a n s_i := a_i - b_i$，逐位相减的代码实现如下
    ```cpp
    for (int i = 0; i < k; ++i) { 
        ans[i] = a[i] - b[i]; 
    } 
    ```
  
    在这一过程中会出现$a n s_i < 0$的情况，得到形如$n = 1 space 3 space -23 space 8$的数，其中$n_1 = -23$，和加法类似(_@大整数加法[] - (2. 运算过程)_)，它等价于$n' = 1 space 0 space 7 space 8$，因为$-23 times 10^1 = -3 times 10^2 + 7 times 10^1 $，将$-3$加到$n_2$上，就可以得到$n'$，不难看出，借位相当于负的进位，当$n_i < 0$时，$n_i$到$n'_i$的转换和$n_i > 9$的情况是相同的，减法和借位也可以分开处理
    
    由于```cpp /```运算符的结果是向$0$取整的，对负数使用```cpp %```运算符求余数可能会得到负数，当余数为负数时，说明```cpp /```运算符求得的商比预期大$1$，正确结果应当再减去$1$，此时对应的余数为正数，加上模数$10$即可得到正确的余数
    
    改进后的进位处理代码实现如下
    ```cpp
    void Carry(std::vector<int>& n) {
        int car = 0;
        for (int i = 0; i < n.size(); ++i) {
            n[i] += car;
            car = n[i] / 10 - (n[i] % 10 < 0);
            n[i] = n[i] % 10 + (n[i] % 10 < 0) * 10;
        }
    }
    ```
    该代码可以处理$n_i$为任意整数的情况

+ 输出处理
    
    删除$a n s$中的前导$0$(_@添加或删除大整数的前导0[]_)，然后判断是否应当输出负号，最后倒序输出$a n s$数组
    
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

    一个$m$位的非负整数与一个$n$位的非负整数相乘，积的位数至多为$m + n$位，因此，$a n s$数组的长度应当为$m + n$，$a, b$数组的长度应当为各自的位数$m, n$，初始化代码见(_@大整数的表示[]_)
+ 运算过程

    观察下列$a times b$乘法竖式的计算过程，其中$a, b$分别为$6, 3$位，$c$是$a times b$的积
    $ a_5 #h(21pt) a_4 #h(21pt) a_3 #h(21pt) a_2 #h(20.5pt) a_1 #h(20.5pt) &a_0 \ 
    times #h(116pt) b_2 #h(22pt) b_1 #h(21pt) &b_0 \
    overline(#h(22pt) a_5b_0 #h(10.5pt) a_4b_0 #h(10.5pt) a_3b_0 #h(10pt) a_2b_0 #h(10.5pt) a_1b_0 #h(10.5pt) a_0) &overline(b_0) \
    a_5b_1 #h(10.5pt) a_4b_1 #h(10.5pt) a_3b_1 #h(10.5pt) a_2b_1 #h(10.5pt) a_1b_1 #h(10.5pt) a_0b_1 #h(21pt) \
    a_5b_2 #h(10.5pt) a_4b_2 #h(10.5pt) a_3b_2 #h(10.5pt) a_2b_2 #h(10.5pt) a_1b_2 #h(10.5pt) a_0b_2 #h(52.5pt) \
    overline(c_8 #h(22pt) c_7 #h(22pt) c_6 #h(21pt) c_5 #h(21pt) c_4 #h(21pt) c_3 #h(21.5pt) c_2 #h(21.5pt) c_1 #h(22pt)) &overline(c_0) $
    我们可以发现，将每个$b_i$乘上$a$得到的结果左移$i$位后加起来，也就是把每一个$a_i b_j$加到$c_(i + j)$上，就可以得到积$c$，因此，乘法实际上就是多次加法计算，此外，乘法满足交换律，所以$a, b$在乘法竖式中的上下位置可以交换，不影响$c$的值

    因此，计算$a times b$就是模拟乘法竖式，先得到未处理进位的积$c$，再像加法一样处理进位(_@大整数加法[]_)，就可以得到最终的结果$a n s$，计算$c$的代码实现如下
    ```cpp
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            ans[i + j] += a[i] * b[j];
        }
    }
    ```

+ 输出处理

    删除$a n s$中的前导$0$(_@添加或删除大整数的前导0[]_)，然后倒序输出$a n s$数组

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

    std::string s; // 大整数
    int b; // 较小数
    std::cin >> s >> b;
    std::vector<int> a = Transform(s), ans(s.size() + GetDigit(b));

    for (int i = 0; i < s.size(); ++i) {
        ans[i] = a[i] * b;
    }
    Carry(ans);
    RemoveRZero(ans);
    for (int i = ans.size() - 1; i >= 0; --i) {
        std::cout << ans[i];
    }
    ```
===== 除法
+ 位数处理

    设$q$为$a div b$的商，$r$为$a div b$的余数，其中$a$为$m$位非负整数，$b$为$n$位正整数

    一个$m$位的非负整数除以一个$n$位的正整数，商的位数至多为$m - n + 1$位，余数的位数至多为$n$位，实际$a, b, q, r$数组的长度需要逐步分析，见(2. 运算过程)，初始化代码见(_@大整数的表示[]_)

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
    
    例如，在计算$q_3$时，不断从$a_5a_4a_3$中减去$b_2b_1b_0$，差记录在$r$中，当$r < b_2b_1b_0$时，停止减法，此时的$r$就是我们要求的$r'_2r'_1r'_0$，减法的次数就是我们要求的$q_3$，该过程涉及到大整数$r, b$的比较(_@比较大整数[]_)和减法(_@大整数减法[]_)，因此$r, b$数组的长度都应当为$n + 1$

    此外，除法竖式是从高位向低位计算的，这与乘法(_@大整数乘法[]_)相反，在存储$q, r$时需要特别注意这一点

    综上所述，大整数$a, b$的除法代码实现如下
    ```cpp
    for (int i = a.size() - 1; i >= 0; --i) {
        // 将 r 数组的元素整体右移 1 位，将 r[0]，即 r 的末尾空出来，用于计算q[i]之前在末尾追加 1 位 a[i]
        for (int j = r.size() - 1; j >= 1; --j) {
            r[j] = r[j - 1];
        }
        r[0] = a[i];

        while (!LessThan(r, b)) {
            for (int j = 0; j < r.size(); ++j) {
                r[j] -= b[j];
            }
            Carry(r);
            ++q[i];
        } // 计算
    }
    ```

+ 输出处理

    除法的结果有$q, r$两个，在输出之前都需要先删除前导$0$(_@添加或删除大整数的前导0[]_)，然后倒序输出

+ 复杂度分析
    
    $q$总共$m$位，需要进行$m$次求商操作，每次求商时，$r, b$之间需要进行不超过$9$次的$n + 1$位大整数减法，因此总时间复杂度为$O(m n)$，空间复杂度为$O(max(m, n))$，其中$m, n$分别为$a, b$的位数

+ 大整数除以较小数时的优化

    如果被除数是大整数，除数是可以使用基本整数类型存储的较小的数，那么商依然是大整数，并且保存商的数组长度应当和保存被除数的数组长度相同，而余数和除数一样，也是可以使用基本正数类型存储的较小的数，因此，可以对除数和余数使用除法试商，从而避免重复做时间复杂度为$O(n)$的大整数减法

    该优化也就是所谓的“高精度除以低精度”，可以使除法的时间复杂度降低到$O(n)$，其中$n$是被除数的位数

    代码实现如下
    ```cpp
    std::string s; // 大整数
    int b; // 较小数
    std::cin >> s >> b;
    int r = 0; // 余数
    std::vector<int> a = Transform(s), q(a.size());

    for (int i = a.size() - 1; i >= 0; --i) {
        r = r * 10 + a[i];
        q[i] = r / b;
        r %= b;
    }

    RemoveRZero(q);
    for (int i = q.size() - 1; i >= 0; --i) {
        std::cout << q[i];
    }
    std::cout << '\n' << r;
    ```
==== 大整数类 <大整数类>
===== 基本设计
实现输入输出(```cpp >>, << ```运算符)，实现加法、减法、乘法、除法和模运算(```cpp +, -, *, /, % ```运算符)，实现比较运算(```cpp < ```运算符)，并包含对负数的处理

每个大整数需要一个```cpp int ```数组成员倒序存储绝对值，一个```cpp bool ```变量存储正负信息
===== 带负数的四则运算
+ 加法
    
    设$a n s := a + b$

    当$a >= 0 and b >= 0$或$a < 0 and b < 0$时，$|a n s| = |a| + |b|$，$a n s$的符号与$a$相同

    当$a >= 0 and b < 0$或$a < 0 and b >= 0$时，若$|a| >= |b|$，则$|a n s| = |a| - |b|$，$a n s$的符号与$a$相同，若$|a| < |b|$, 则$|a n s| = |b| - |a|$，$a n s$的符号与$a$相反

+ 减法

    设$a n s := a - b$

    当$a >= 0 and b < 0$或$a < 0 and b >= 0$时，$|a n s| = |a| + |b|$，$a n s$的符号与$a$相同

    当$a >= 0 and b >= 0$或$a < 0 and b < 0$时，若$|a| >= |b|$，则$|a n s| = |a| - |b|$，$a n s$的符号与$a$相同，若$|a| < |b|$, 则$|a n s| = |b| - |a|$，$a n s$的符号与$a$相反

+ 乘法

    设$a n s := a * b$

    $|a n s| = |a| * |b|$，如果$a, b$同号，则$a n s$为正，否则为负

+ 除法

    设$q$为$a div b$的商，$r$为$a div b$的余数，要求$r >= 0$，且$b != 0$

    $|q|$为$|a| div |b|$的商，$|r|$为$|a| div |b|$的余数，当$r < 0$时需要修正$q, r$使得$r$满足$r >= 0$
    
    当$a >= 0 and b >= 0$时，$q >= 0, r >= 0$
    
    当$a >= 0 and b < 0$时，$q < 0, r >= 0$

    当$a < 0 and b >= 0$时，$q < 0, r < 0$，需要将$r$加上$b$，同时将$q$减去$1$，使得$r >= 0$

    当$a < 0 and b < 0$时，$q >= 0, r < 0$，需要将$r$减去$b$，同时将$q$加上$1$，使得$r >= 0$
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
        int car = 0;
        for (int i = 0; i < n.size(); ++i) {
            n[i] += car;
            car = n[i] / 10 - (n[i] % 10 < 0);
            n[i] = n[i] % 10 + (n[i] % 10 < 0) * 10;
        }
    }

    static void RemoveRZero(std::vector<int>& n) {
        while (n.size() > 1 && n.back() == 0) {
            n.pop_back();
        }
    }

    static std::vector<int> Add(const std::vector<int>& a, const std::vector<int>& b) {
        std::vector<int> ans(std::max(a.size(), b.size()) + 1);
        for (int i = 0; i < a.size(); ++i) {
            ans[i] = a[i] + b[i];
        }
        return ans;
    }

    static std::vector<int> Subtract(const std::vector<int>& a, const std::vector<int>& b) {
        std::vector<int> ans(std::max(a.size(), b.size()));
        for (int i = 0; i < a.size(); ++i) {
            ans[i] = a[i] - b[i];
        }
        return ans;
    }

public:
    BigInt(bool neg = false) : negative(neg) {}
    BigInt(const std::string& s, int size = 0) {
        negative = s[0] == '-';
        num.resize(size ? size : s.size() - negative);
        for (int i = s.size() - 1; i >= negative; --i) {
            num[s.size() - 1 - i] = s[i] - '0';
        }
    }
    
    friend bool operator<(const BigInt& a, const BigInt& b) {
        if (a.negative ^ b.negative) {
            return a.negative;
        }

        if (a.num.size() == b.num.size()) {
            for (int i = a.num.size() - 1; i >= 0; --i) {
                if (a.num[i] != b.num[i]) {
                    return a.num[i] < b.num[i] ^ a.negative;
                }
            }
            return false;
        }
        return a.num.size() < b.num.size() ^ a.negative;
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

    friend BigInt operator+(const BigInt& a, const BigInt& b) {
        BigInt ans;
    


        BigInt::Carry(ans.num);
        BigInt::RemoveRZero(ans.num);
        return ans;
    }

    friend BigInt operator-(const BigInt& a, const BigInt& b) {
        BigInt ans;



        BigInt::Carry(ans.num);
        BigInt::RemoveRZero(ans.num);
        return ans;   
    }

    friend BigInt operator*(const BigInt& a, const BigInt& b) {
        BigInt ans(a.negative ^ b.negative);
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
        BigInt ans(a.negative ^ (b < 0));
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
        return {};
    }

    friend BigInt operator%(const BigInt& a, const BigInt& b) {
        return {};
    }

    friend BigInt operator/(const BigInt& a, int b) {
        return {};
    }

    friend int operator%(const BigInt& a, int b) {
        return {};
    }
};
```
=== 高精度浮点数
== 快速幂
= 综合应用 / 高级数据结构
== 组合数学
=== 加法原理
=== 乘法原理
=== 容斥原理
加减法位数修改、函数化、比较函数compare、小于关系重写
