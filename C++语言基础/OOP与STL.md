# OOP基础
## 结构体、union 的语法及使用
OOP基础(类、结构体、联合体的概念及语法，成员变量、成员函数、构造函数、运算符重载)(1773)

结构体+自定义排序（2225，2227，2219,2220，2224，2228 搜结构体）
贪心 2223
## STL中的迭代器

std::advance, std::distance, std::begin, std::end

封装：隐藏细节

不同容器的迭代器具有不同的属性，迭代器一定支持 == 和 != 运算符，但不一定支持 < 运算符，如果使用迭代器遍历，中间要使用 !=，防止无法比较

std::greater<int>() 降序排列的简便写法

reverse() fill()
STL算法库函数（min, max, swap, sort--如何自定义排序规则，lower_bound(), upper_bound()）、


STL容器(std::string, std::vector(为什么不推荐使用内置数组？不含有长度信息，不能相互复制，传参不方便), std::pair, std::set, std::map及其unordered版本)、


文件类型的概念(文本文件)，文件读写(fstream)，文件重定向(freopen("txt.out", 'w', stdout)...)，