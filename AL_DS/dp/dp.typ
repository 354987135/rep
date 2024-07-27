#set text(font: ("Linux Libertine", "Noto Sans SC"), size: 12.5pt)

#show raw: set text(font: ("Fira Code", "Noto Sans SC"), features: (calt: 0), lang: "cpp")


#show raw.where(block: false, lang: "cpp"): box.with(
  fill: luma(240),
  inset: (x: 2pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt
)

// #show heading.where(): set heading(numbering: "1.")

#let spacing = h(0.25em, weak: true)
#show math.equation.where(block: false): it => spacing + it + spacing

= 动态规划的基本概念
动态规划是一种解决问题的思想，通常用于解决有限集合中的最优化问题、计数问题、存在性问题等，在这些问题中，我们通常只需要知道结果，不需要知道中间过程具体是怎样的，动态规划的思想可以帮助我们省略“枚举具体过程”这一操作，转而关心过程之间是如何发生改变的，从而降低时间开销






递推需要使用递推式，例如爬楼梯问题中的 $f(n) = f(n - 1) + f(n - 2)$，在这样一个递推式中，每一项都称为“状态”，这是一个抽象的概念，对于爬楼梯问题来说，$f(n)$表示的状态是“从起点到第$n$级台阶需要走的次数”，而第$n$级台阶可以从第$n-1$级或第$n-2$级达到，因此我们说，状态$f(n)$可以由其前2个状态，即$f(n-1), f(n-2)$转移得到，通过引入状态的概念，我们就把递推式称为状态转移方程，即当前状态可以通过它之前的一个或多个状态得到，利用动态规划法解决问题的基本步骤就是从问题中找出并正确描述状态，并找出状态转移的规则

状态之间的递推式称为状态转移方程

= 利用动态规划解决问题的基本步骤
1. 确定状态，并用`dp`数组描述
2. 确定状态转移方程
3. 确定边界条件
4. 根据状态转移方程递推并更新`dp`数组
5. 根据问题的约束条件从`dp`数组中取出答案
= 常见的动态规划问题模型
== 线性DP
线性DP，即状态转移方程为特定变量的线性函数的DP问题，
=== 一维线性DP
=== 爬楼梯
=== 最长上升子序列 (LIS)

=== 最长公共子序列 (LCS)

=== 背包DP
=== 0-1背包问题
==== 问题描述
有$n$种物品，每种物品都有自己的重量$w$和价值$v$，且数量只有$1$个，用一个负重限制为$m$的背包装载物品，问能取得的价值最大为多少？
==== 状态分析
令`dp[i][j]`表示的状态为：对前```cpp i```个物品，使用```cpp j```个单位的背包负重，能取得的最大价值

对于第```cpp i```个物品来说，前`i - 1`个物品已经考虑完毕，此时有装与不装两种选择，如果不装，那么使用的背包负重在考虑第```cpp i```个物品前后并未改变，均为`j`，且背包中物品的最大价值相比只考虑前`i - 1`个物品时也没有改变，因此状态转移方程为`dp[i][j] = dp[i - 1][j]`；如果装，那么在考虑第`i`个物品后，使用的背包负重`j`中包含了第`i`个物品的重量```cpp w[i]```，考虑之前使用的背包负重应为`j - w[i]`，最大价值相比考虑之前增加了第`i`个物品的价值`v[i]`，因此状态转移方程为`dp[i][j] = dp[i - 1][j - w[i]] + v[i]`，显然，若当前背包空间`j < w[i]`，则无法选择装物品`i`

综上所述，该问题的状态转移方程为
```cpp 
dp[i][j] = j < w[i] ? dp[i - 1][j]
    : std::max(dp[i - 1][j], dp[i - 1][j - w[i]] + v[i])
```
==== 边界条件分析
若背包负重为$0$，则显然最大价值为$0$，即`dp[i][0] = 0`；若不选任何物品，则最大价值也为$0$，即`dp[0][j] = 0`
==== 0-1背包问题的优化

=== 完全背包问题
==== 问题描述
在0-1背包问题的基础上，将每种物品数量改为无限个
