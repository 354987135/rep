#include <bits/stdc++.h>

using namespace std;

struct Point {
    int x, y;

    bool operator<(const Point& x2) {
        if (x < x2.x) { return true; }
        if (x > x2.x) { return false; }
        return y < x2.y;
    }
};

// bool Cmp(const Point& x1, const Point& x2) {
//     return x1.x < x2.x && x1.y < x2.y;
// }

bool Cmp (const Point& x1, const Point& x2) {
    if (x1.x < x2.x) { return true; }
    if (x1.x > x2.x) { return false; }
    return x1.y < x2.y;
}

int main() {
    vector<Point> a = {{1, 2}, {1, 1}, {0, 0}, {3, 3}};
    sort(begin(a), end(a));
    for (auto& p : a) {
        cout << p.x << ' ' << p.y << ", ";
    }
    // cout << '\n' << (Point(1, 2) < Point(1, 1));
}

// std::advance, std::distance, std::begin, std::end
// 封装：隐藏细节