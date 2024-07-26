#include <bits/stdc++.h>
using namespace std;

bool IsPrime(int n) { // 试除法判断一个数是否为素数
    if (n < 2) { return false; } // 1 不是素数
    for (int i = 2; i <= n / i; ++i) {
        // 要求是i <= sqrt(n)
        // 两边平方得i * i <= n , 但是i * i可能会溢出
        // 因为i > 0，所以可以除过去，变成i <= n / i
        if (n % i == 0) { return false; }
    }
    return true;
}

int main() {
    int M, N;
    cin >> M >> N;
    bool first = true, has = false;
    for (int i = M; i <= N; ++i) {
        if (IsPrime(i)) {
            int before = i, after = 0;
            while (before > 0) {
                after = after * 10 + before % 10;
                before /= 10;
            }
            if(IsPrime(after)) {
                has = true;
                if (first) {
                    cout << i;
                    first = false;
                } else {
                    cout << ',' << i;
                }
            }
        }
    }
    if (!has) {
        cout << "NO";
    }
}


// lambda