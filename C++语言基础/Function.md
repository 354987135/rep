## 函数原型、模板
## 返回值类型推断
auto，decltype(auto)
## 返回值优化
复制消除

临时对象

生命周期延长
## 函子 functor
## 仿函数
## 函数对象
## lambda 表达式
## 函数指针
## 完美转发
`std::forward()`
## 函数模板
```cpp
#include <iostream>
#include <algorithm>

int* create_arr(int len) {
    int* p = new int[len];
    for (int i = 0; i < len; i++) {
        p[i] = i;
    }
    return p;
}//指针也是类型，因此函数可以返回指针，编写一个返回int*的函数

int main() {
    int* (*fun_ptr)(int len);
    //声明函数指针
    fun_ptr = &create_arr;
    //给函数指针赋值
    int* arr6 = (*fun_ptr)(10);
    //通过函数指针调用函数
    for (int i = 0; i < 10; i++) {
        std::cout << arr6[i] << " ";
    }
    std::cout << "\n";
    delete[] arr6;
    arr6 = nullptr;

    int arr7[9] { 9, 6, 4, 2, 8, 7, 3, 1, 5 };
    std::sort(arr7, arr7 + 9);
    for (int i = 0; i < 9; i++) {
        std::cout << arr7[i] << " ";
    }
    std::cout << "\n";
    //std::sort()默认升序排序

    std::sort(arr7, arr7 + 9, compare);
    for (int i = 0; i < 9; i++) {
        std::cout << arr7[i] << " ";
    }
    std::cout << "\n";
    //使用自定义函数bool compare(int a, int b);进行排序，此处的参数compare就是通过函数指针传进去的
}
```