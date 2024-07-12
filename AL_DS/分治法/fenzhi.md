# 基于分治法的快速幂算法
```cpp
int64_t QuickPow(int64_t a, int64_t x) {
    if (x == 0) {
        return 1;
    }
    int64_t t = QuickPow(a, x / 2);
    if (x % 2 == 0) {
        return t * t;
    }
    return t * t * a;
}
```
有时候我们还需要对幂进行取模，将其与快速幂结合，称为快速幂取模，利用了公式
$$ (a \times b) \operatorname{mod} c = ((a \operatorname{mod} c) \times (b \operatorname{mod} c)) \operatorname{mod} c $$
```cpp
int64_t QuickPowMod(int64_t a, int64_t x, int64_t k) {
    if (x == 0) {
        return 1;
    }
    int64_t t =  QuickPowMod(a, x / 2, k);
    if (x % 2 == 0) {
        return ((t % k) * (t % k)) % k;
    }
    return (((t % k) * (t % k)) % k * (a % k)) % k;
}
```