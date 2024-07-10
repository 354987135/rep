# 分治法实现快速幂

```cpp
int pow(int a, int x) {
    if (x == 1) {
        return a;
    }
    int c = pow(a, x / 2);
    if (x % 2 == 0) {
        return c * c;
    }
    return c * c * a;
}

```