#include <iostream>
using namespace std;
int main() {
 // 一维数组的声明:
// 数据类型 变量名[长度];
// 数据类型: 可以是基本数据类型(int, double等)
// 变量名: 符合标识符命名规则即可

// identifier 直译 标识符 : 某某的名字(比如说变量的名字)
// 1. 不能以数字开头, 不能以特殊字符(+ - *)开头
//   只能以大小写英文字母, 下划线开头
// 2. 可以把数字放在中间或者最后, 
//   但是特殊字符不能出现在任何位置
// 3. _ 开头的标识符是给编译器, 标准库等使用的
//   我们在声明变量的时候, 不应该用下划线开头
//   总结下来: 英文字母开头, 中间和末尾可以加数字或下划线
//   _ 开头虽然不应该使用, 但是可以通过编译
// 

// 长度:
// 1. 必须是正整数
//   这一点很好理解, 因为数组是存储多个对象容器
// 2. 必须是常量表达式
//   数组的内存必须在编译的时候就分配好, 
//   在程序运行的过程中, 数组的长度不能发生改变的

   // int n = 5;
   // 常量表达式: 
   //   1. 在编译过程中就能够确定值
   //   2. 在程序运行过程中不会发生改变
   // 
   // n + 1 是不是一个常量表达式?
   // n + 1 不是一个常量表达式
   // 用 n + 1 作为长度声明一个数组就是不正确的
   // 但是我们会发现在devc++中这样的语句可以通过编译
   // 因为我们devc++用的是gcc编译器
   // 让这条语句通过编译的功能, 是gcc的扩展功能
   // 虽然这条语句能够正常运行, 但是它不符合C++标准
   // C++ 有 3 大编译器: gcc, clang, msvc
   // int a[n + 1];

   // const int n = 5;
   // const 修饰类型的, 变量 n 的类型是常量类型
   // 可以简称 n 是一个常量
   // 常量: 一经确定就不能再修改的量
   // n + 1

   // 常量:
   // 1. 常量
   //   - 经确定就不能再修改的量 
   // 2. 常量表达式
   //   - 在编译过程中就能够确定值
   //   - 在程序运行过程中不会发生改变

   // const 类型的变量不一定是常量表达式

   // int m;
   // cin >> m;
   // const int n = m; // 在这里 n 就不是常量表达式

   // constexpr int i = n + 1;
// 

// 一维数组的初始化:
// 初始化: 声明的同时赋值
 // int a[3] = {2, 3, 4};
 // 2 3 4
 // 如果对数组进行了初始化, 那么可以省略长度信息
 // int a2[] = {2, 3, 4};
 // 2 3 4
 // 如果不省略长度信息, 那么剩下没初始化的位置都会变为 0
 // int a3[10] = {2, 3, 4};
 // 2 3 4 0 0 0 0 0 0 0
 // 利用这个特点, 可以将一个数组所有元素都初始化为 0
 // int a4[5] = {0};
 // 0 0 0 0 0
 // 实际上在初始化的时候, = 是可以省略的
 // int a5[3] {2, 3, 4};
 // 2 3 4
 // 特别地, 当将所有元素都初始化为 0 的时候
 //   = 和 0 都可以省略
 // int a6[10] {};

 // 访问数组的元素
 // [] 下标运算符, 索引运算符
 // 在数组中, 元素的序号称为下标或索引
 // 这个序号是从 0 开始的
 // 第 1 个元素的下标是 0
 // 因此, a[10] 的最后一个元素下标应该是 9
 // 如果对数组 a 取下标为 10 的元素, 会发生什么?
 // 假设取 a[10], 这个行为叫做 越界访问
 // 会发生什么是不确定的, 
 //   这叫做未定义行为(undefined behavior, UB)
 // 未定义行为: 
 //   C++标准中没有规定这样的代码会产生什么效果
 //   编译器有可能把它编译成可以正确运行的代码
 //   也可能编译成不能正确运行的代码
 //   假设编译器把它编译为访问数组元素的代码
 //   那么有可能访问到其他程序的内存上去
 //   这样就有可能引发其他程序的问题, 甚至操作系统的问题
 //   要避免数组越界访问

 //   数组的应用:
 //   查找元素(找最大 最小值):
 //   最大值初始值: 必须要小于数组中的所有数
 //   最小值初始值: 必须要大于数组中的所有数
 //   0x3f3f3f3f 大约是 10亿 多
 
 //   数组下标的利用
 //   利用数组下标做统计
 // 1 2 1 1 2 3 4 1 2 5 3 2 1 4 2 6 2
 // 这一列数中：有1 ~ 6，6种不同的数字
 // 现在要求统计这些数字每个出现了多少次
 // 最朴素的办法：设置 6 个变量
 // int a[10]
 // 可以让数组的每个位置代表一个数字
 // 刚好我们的整数可以作为下标，这样就更方便了
 // a[1] 表示 1 出现的次数
 // a[2] 表示 2 出现的次数
 // ...
 // a[6] 表示 6 出现的次数
 // 这样就可以使用一个数组统计多个不同的数出现的次数
int a[7] {};
// 1 2 1 1 2 
// 3 4 1 2 5 
// 3 2 1 4 2 
// 6 2
 for (int i = 0; i < 17; ++i) {
  int x;
  cin >> x;
  ++a[x];
 } 
 
 for (int i = 1; i <= 6; ++i) {
  // cout << i << " 出现的次数 = " << a[i] << '\n';
  for (int j = 0; j < a[i]; ++j) {
   cout << i << ' ';
  }
 }

 // 统计之后还可以做到一件事，就是排序
 // 计数排序
 // 
}


判断题：
1. 数组的长度可以是变量
2. 数组变量名可以包含+号
3. 删除数组中的元素可以使数组的长度改变
4. 对于数组 int a[10], 执行 a[100] = 10 没有问题
5. 已知 n 的类型是 const int, 则 n 一定是常量表达式
