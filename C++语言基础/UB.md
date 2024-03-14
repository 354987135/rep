# 常见 UB
https://en.cppreference.com/w/cpp/language/ub
可以从cppreference上查询到

# 上述页面并未列出的 UB
- 宏名和关键字相同
  典型例子：
  ```cpp
    #define int long long
  ```
https://en.cppreference.com/w/cpp/preprocessor/replace#.E4.BF.9D.E7.95.99.E5.AE.8F.E5.90.8D

"Reserved macro names"节 