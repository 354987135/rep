#include <bits/stdc++.h>
using namespace std;

int SearchL1(double x, const vector<int>& a) {
    // >= x的第一个数的下标
    int l = 0, r = a.size() - 1;
    while (l <= r) {
        int mid = (l + r) / 2;
        if (a[mid] >= x) {
            r = mid - 1;
        } else {
            l = mid + 1;
        }
    }           
    return l;
 // 这个下标位置不一定是x，但是如果有x，就是x的下标
 // 要在主函数里判断
}

int SearchL2(double x, const vector<int>& a) {
    int l = 0, r = a.size();
    while (l < r) {
        int mid = (l + r) / 2;
        if (a[mid] >= x) {
            r = mid;
        } else {
            l = mid + 1;
        }
    }
    return l;
}

int SearchR1(double x, const vector<int>& a) { 
    int l = 0, r = a.size() - 1;
    while (l <= r) {
        int mid = (l + r) / 2;
        if (a[mid] <= x) {
            l = mid + 1;
        } else {
            r = mid - 1;
        }
    }           
    return l;
}

int SearchR2(double x, const vector<int>& a) {
    int l = 0, r = a.size();
    while (l < r) {
        int mid = (l + r) / 2;
        if (a[mid] <= x) {
            l = mid + 1;
        } else {
            r = mid;
        }
    }
    return l;
}



int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, q;
    cin >> n >> q;
    vector<int> a(n);
    for (int i = 0; i < n; ++i) {
        cin >> a[i];
    }
    for (int i = 0; i < q; ++i) {
        int x;
        cin >> x;
        // int pos = lower_bound(a.begin(), a.end(), x) - a.begin();
        // int pos = upper_bound(a.begin(), a.end(), x) - a.begin();
        // int pos = SearchL2(x, a);
        // int pos = SearchR2(x, a);
        int posL = SearchL1(x, a);
        int posR = SearchR1(x, a);
        // int posL = lower_bound(a.begin(), a.end(), x) - a.begin();
        // int posR = upper_bound(a.begin(), a.end(), x) - a.begin();
        if (posL < a.size() && a[posL] == x) { // >= 的第一个数
            cout << posL + 1 << ' ';
        } else {
            cout << -1 << ' ';
        }
        if (0 <= posR - 1 && posR - 1 < a.size() && a[posR - 1] == x) { // >的第一个数
            cout << posR << '\n'; // upper bound 最后 l 会比目标下标大 1
        } else {
            cout << -1 << '\n';
        }
    }
    // 7 14 11 3 14 11 -1 -1 14 14 14 2 2 5 -1
}