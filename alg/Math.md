## 组合数学
### 容斥原理


## 快速幂算法
```cpp
std::uint64_t IntFastPow(std::uint64_t base, std::uint64_t exp) {
    std::int64_t ans = 1;
    while(exp > 0) {
        if (exp % 2 == 1) {
            ans *= base;
        }
        base *= base;
        exp >>= 1;
    }
    return ans;
}
```
## 高精度算法
### 十进制浮点类型 decimal

## 随机数
```cpp
std::random_device rd;
std::mt19937 engine(rd());

int GetRdInt(int start, int end) {
    std::uniform_int_distribution<int> dist(start, end);
    return dist(engine);
}

double GetRdDouble(double start, double end) {
    std::uniform_real_distribution<double> dist(start, end);
    return dist(engine);
}
```
# 位运算
```cpp
void Swap(int& a, int& b)
{
    //如果a和b指向同一块内存则结果为0
    a = a ^ b;
    b = a ^ b;
    a = a ^ b;
}
```
取出一个整数n末尾的1，即保留n的补码最右侧的一位1，其他位为0：
$$
    \Large
    n\,\&\,(\sim n + 1) 
$$
例1：n为负数
$$
\Large
\begin{align*}
    n &= 11110101 \quad \text{$-11$ 的补码}\\
    \sim n &= 00001010 \quad \text{各位全部取反}\\
    \sim n + 1 &= 00001011 \quad \text{取反后$+1$}\\
    n\,\&\,(\sim n + 1) &= 00000001 \quad \text{取出末位 $1$}
\end{align*}
$$
例2：n为正数
$$
\Large
\begin{align*}
    n &= 01011000 \quad \text{$88$ 的补码}\\
    \sim n &= 10100111 \quad \text{各位全部取反}\\
    \sim n + 1 &= 10101000 \quad \text{取反后$+1$}\\
    n\,\&\,(\sim n + 1) &= 00001000 \quad \text{取出末位 $1$}
\end{align*}
$$
```cpp
#include <iostream>
#include <cstdint>
#include <bitset>
int main() {
    std::int8_t n1 = -11, n2 = 88;
    std::bitset<8> bs1 = n1 & (~n1 + 1);
    std::bitset<8> bs2 = n2 & (~n2 + 1);
    std::cout << bs1 << ' ' << bs2;
    //输出: 00000001 00001000
}
```
## 判断回文数
回文数定义：

根据定义很容易知道，如果考虑负号，那么负数不是回文数，如果一个数以 0 结尾，那么它不是回文数，0 是唯一的例外

如果一个数是回文数，那么它的右半边反转后应该等于左半边，因此我们可以基于这个思路编写算法
```cpp
bool IsPalindrome(std::int64_t x) {
    if (x < 0 || (x % 10 == 0 && x != 0)) {
        return false;
    }
    std::int64_t rightHalf = 0;
    while (x > rightHalf) {
        rightHalf = rightHalf * 10 + x % 10;
        x /= 10;
    }
    return x == rightHalf || x == rightHalf / 10;
}
```
# 博弈论
