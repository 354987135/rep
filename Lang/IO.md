## 标准 I/O 流
https://en.cppreference.com/w/cpp/io/basic_ios/operator_bool
`std::cin`读到文件结束符时，fail() 返回 true，因此while(std::cin >> n) {} 循环条件为false
### I/O重定向
在默认情况下，`std::cin`和`std::cout`只能通过控制台输入和输出数据，但是有时候我们希望程序从指定文件输入，然后输出到指定文件中，例如算法竞赛的输入输出，这就需要将输入输出流重定向到指定的文件上

C库函数`freopen() (<cstdio>)`可以实现将输入输出流重定向到文件的操作，并且对C++的标准输入输出流`std::cin`和`std::cout`也适用

`freopen()`接受3个参数，第1个参数是指定文件名，默认目录和当前程序相同，如果在其他目录，需要在前面加上文件的路径，第 $2$ 个参数是文件的读写规则，$\text{r}$ 代表只读，并且要求文件必须提前存在，$\text{w}$ 代表写入，如果文件不存在，将会先创建这个文件再进行写入，第 $3$ 个参数是需要重定向的流，$\text{stdin}$ 代表标准输入流，$\text{stdout}$ 代表标准输出流

下面的程序会从当前目录的 $\text{test.in}$ 中读取数据，并且将结果写入到 $\text{test.out}$ 中
```cpp
#include<iostream>
#include<cstdio>
int main() {
    freopen("test.in", "r", stdin);
    freopen("test.out", "w", stdout);
    std::cin >> a >> b;
    std::cout << a + b;
}
```
其中 $test.in$ 的文件内容如下
```
300 400
```
运行程序后 $test.in$ 文件中的内容如下
```
700
```
$\text{freopen()}$ 虽然方便易用，但是当流被重定向到文件后，没有任何办法可以将流恢复到原来的状态，并且如果对一个流进行反复的重定向操作时极有可能得到非预期的结果导致错误，因此 $\text{freopen()}$ 仅适用于算法竞赛这样只需要一次重定向的场景，更好的办法是使用 $\text{C++}$ 标准的文件流和 $\text{I/O}$ 流进行操作
```cpp
#include <iostream>
#include <fstream>
int main() {
    fstream file;
}
```
## 文件 I/O 流
### 文本文件、二进制文件的概念
## 字符串 I/O 流
`<sstream>`