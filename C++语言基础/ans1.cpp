#include <bits/stdc++.h>

using namespace std;

struct Point {
    int x, y;

    bool operator<(const Point& x2) { // 运算符重载
        if (x < x2.x) { return true; } 
        if (x > x2.x) { return false; }
        return y < x2.y;
    }

};

bool operator>(const Point& x1, const Point& x2) { // 运算符重载
    if (x1.x > x2.x) { return true; } 
    if (x1.x < x2.x) { return false; }
    return x1.y > x2.y;
}
// istream& operator<<(Point& p, istream& in) {
//     in >> p.x >> p.y;
//     return in;
// }
// bool Cmp(const Point& x1, const Point& x2) {
//     return x1.x < x2.x && x1.y < x2.y;
// }

bool Cmp (const Point& x1, const Point& x2) { 
    if (x1.x < x2.x) { return true; } // true 表示 x1 排在 x2 左边
    if (x1.x > x2.x) { return false; } // false 表示 x1 排在 x2 右边(或理解为不动)
    return x1.y < x2.y;
    // 想要排序的关键词的顺序就是if 的顺序
}

int main() {
    vector<Point> a = {{1, 2}, {1, 1}, {0, 0}, {3, 3}};
    sort(begin(a), end(a), greater<Point>()); // 如果要用greater，必须重载 > 运算符，且必须是全局函数
    for (auto& p : a) { // 范围 for 循环
        cout << p.x << ' ' << p.y << ", ";
    }
    // cout << '\n' << (Point(1, 2) < Point(1, 1));
}

// std::advance, std::distance, std::begin, std::end
// 封装：隐藏细节