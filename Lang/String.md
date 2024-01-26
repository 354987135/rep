# 字符
C++ 中的字符系统继承自 C 语言，若无特别说明，字符均是`char`类型，在 C 语言中，`char`类型默认为`signed char`，能存储 -128~127 范围内的整数，其中 0~127 范围内的每个整数都代表一个字符，这张整数和字符对应的表称为 ASCII 码表，在表上，32~126 是可显示字符，0~31 和 127 是控制字符，不可显示

字符实际上是以整数形式存储的，但我们可以使用形如`'A'`的写法来表示字符字面量，而不必记住每个字符对应的整数，例如，`char c = 'A'`就是`char c = 65`，使用这种表示方法时，单引号中必须有并且只能有一个字符，控制字符由于不能显示，不容易使用这样的方法表示，因此，C 语言规定了转义符`\`来帮助表示字符，例如，空字符可以用`'\0'`表示，换行符可以用`'\n'`表示，这样表示的时候虽然单引号内包含了多个字符，但编译器会把包括反斜杠在内的整个序列当成一个字符处理 ( 称为转义序列，只有特定的组合才能组成转义序列 )，转义序列主要用于表示控制字符，可显示字符也可以用对应的转义序列表示，但通常不需要这样，除了一些会被当成语法组成部分的字符，例如单引号字符，存储单引号字符时，不能写`char c = '''`，必须写`char c = '\''`
## 常见的字符操作方法
对于常用的字符，即数字和英文字母`'0'~'9'`，`'a'~'z'`，`'A'~'Z'`，这些字符本身连续并且有序，它们对应的整数也是连续并且有序的，因此我们可以利用这个特性对字符进行判定和转换操作
### 判断一个字符是否为数字、小写英文字母、大写英文字母
```cpp
char c;
if ('0' <= c && c <= '9') // 判断 c 是否为数字
if ('a' <= c && c <= 'z') // 判断 c 是否为小写英文字母
if ('A' <= c && c <= 'Z') // 判断 c 是否为大写英文字母
```
### 将数字字符转换为对应的整数
```cpp
char c = '9';
int a = c - '0';
// a 的值为 9
```
### 英文字母字符的大小写转换
```cpp
char c1 = 'C';
c1 = c1 - 'A' + 'a';
// 此时 c1 的值变为 'c'

char c2 = 'c';
c2 = c2 - 'a' + 'A';
// 此时 c2 的值变为 'C'
```
### 英文字母字符的加解密
#### Caesar 密码
给定英文字母字符`c`，在字母表上将它向左或向右移动`n`个单位，可以得到一个新的字符，求出该字符

该问题的关键在于对边界情况的处理，使用模运算可以轻易将运算后超出字母表的结果重新映射到正确的位置
```cpp
char c1 = 'A';
c1 = (c1 - 'A' - 3 + 26) % 26 + 'A';
// 字符 'A' 向左偏移 3 个单位，变为 'X'

char c2 = 'Z';
c2 = (c2 - 'A' + 3) % 26 + 'A';
// 字符 'Z' 向右偏移 3 个单位，变为 'C'
```
## 处理字符的函数
C 语言头文件`<ctype.h>` ( https://en.cppreference.com/w/c/string/byte ) 中定义了一系列处理单个字符的函数，C++ 继承了这些函数，C++ 版的头文件为`<cctype>` ( https://en.cppreference.com/w/cpp/header/cctype )

其中`is`开头的函数可以用来判断字符性质 ( 即判断字符是否属于某类型 )，这些函数的返回值类型是`int`，而不是`bool`，以`islower(c)`函数为例，该函数用于判断字符`c`是否为小写英文字母，如果`c`是小写英文字母，这个函数返回一个非 0 的整数，如果`c`是其他字符，这个函数返回整数 0，因此，在跟`if`语句联用时，不能写`if(islower(c) == 1)`或`if(islower(c) == true)`，可以写`if(!(islower(c) == 0))`，但最好的写法是`if(islower(c))`

其中`to`开头的 2 个函数用于英文字母的大小写转换，这 2 个函数的返回值类型是`int`而不是`char`，需要根据情况进行类型转换，以`toupper(c)`为例，如果字符`c`是小写英文字母，那么这个函数会返回字符`c`对应的大写英文字母的整数值，如果字符`c`是其他字符，那么这个函数会返回字符`c`的整数值
## 字符的输入方法
使用`std::cin`和`>>`运算符进行常规输入，读取单个字符，以空格、换行符等作为分隔符，不会读入空格和换行符等分隔符
```cpp
char c;
while (std::cin >> c) {
    std::cout << c;
}
// 输入 h e ll o w
// 输出 hellow
```
如果需要读入空格、换行符等特殊字符，使用`std::cin.get(c)`成员函数，读取单个字符到字符变量`c`中
```cpp
char c;
while (std::cin.get(c)) {
    std::cout << c;
}
// 输入 h e ll o w
// 输出 h e ll o w 
```
由于`std::cin`的`>>`运算符不会读取空格和换行符等分隔符，一次性输入一串字符时，末尾的空格和换行符等分隔符会被留在缓冲区内，如果紧接着使用`std::cin.get()`，读取的就是尾部留下的空格或换行符等分隔符，而不是下一行的字符

这种情况的标准解决方法是使用`std::cin.ignore()`成员函数，它的作用是从缓冲区读取字符并丢弃，因此可以用来去除末尾的多余字符，该成员函数的第一个参数是一个整数，表示需要忽略的字符数量，第二个参数是一个字符，表示读取到该字符就停止

如果我们不清楚具体需要去除多少个多余的字符，但希望将缓冲区内剩余的字符全部去除，那么可以这样写：`std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');`，其中`std::numeric_limits<std::streamsize>::max()`表示缓冲区的最大长度，需要包含头文件`<limits>`才能获取，`'\n'`表示读取到换行符后停止读取

如果我们明确知道需要去除`n`个字符，那么可以直接写`std::cin.ignore(n);`
# C 语言字符串
C 语言使用字符数组保存字符串，在 C 语言中，编译器只能知道整个数组占用的内存大小，不能知道数组具体保存了多少个有效元素，也就是说，对于一个普通的字符数组，我们无法得知字符数组中保存了多少个字符，但对于一个字符串来说，我们必须知道它包含多少个字符，对此，C 语言的解决方法是使用空字符`'\0'`来表示字符串的结束

在字符数组中，任取一个空字符之前的字符作为开始 ( 通常是字符数组的第一个字符 )，向后一直到空字符，这之间的所有字符 ( 包括空字符 )，可以组成一个子字符数组 ( 有时就是原字符数组本身 )，这个数组就称为 C 语言字符串，并用这个数组的数组名标记，C 语言字符串的长度就是除空字符`'\0'`以外的字符的数量

例如，现在有一个字符数组`c`，`char c[] = {'a', 'b', 'c', '\0', 'd'}`

- 从字符`'a'`开始，可以得到 C 语言字符串`s1`，`char s1[] = {'a', 'b', 'c', '\0'}`，它的长度为 3

- 从字符`'b'`开始，可以得到 C 语言字符串`s2`，`char s2[] = {'b', 'c', '\0'}`，它的长度为 2

- 从字符`'c'`开始，可以得到 C 语言字符串`s3`，`char s3[] = {'c', '\0'}`，它的长度为 1

- 从字符`'\0'`开始，可以得到 C 语言字符串`s4`，`char s4[] = {'\0'}`，它是一个空字符串，长度为 0

字符数组`c`可以直接当作字符串`s1`使用

`std::cout`的`<<`运算符支持通过字符指针 ( 即 C 语言字符串第一个字符的地址 ) 直接输出完整字符串
```cpp
char c[] = {'a', 'b', 'c', '\0', 'd'};
std::cout << c << '\n';
// 输出 abc

char* p = &c[0];
std::cout << p << '\n';
// 输出 abc

p = &c[1];
std::cout << p << '\n';
// 输出 bc

p = &c[2];
std::cout << p << '\n';
// 输出 c

p = &c[3];
std::cout << p << '\n';
// 空字符串，无输出或输出一个空格 (由编译器实现决定)
```
使用双引号`""`包含的字符序列是 C 语言字符串字面量，例如`"hello"`就是一个 C 语言字符串字面量，我们不需要在双引号的最后写出空字符，这个空字符是编译器自动添加的，也可以认为它是隐藏在最后一个字符之后，也就是说，`"hello"`实际上是`{'h', 'e', 'l', 'l', 'o', '\0'}`

C 语言字符串字面量是常量，它的类型是`const char[]`，不能对字面量本身进行修改，但我们可以使用字符数组来保存它的拷贝再进行修改，即`char s[] = "hello"`，然后可以修改 C 语言字符串`s`，如果不想修改，可以使用`const char[]"`来保存，我们还可以使用字符指针直接保存 C 语言字面量本身，因为是保存字面量本身，所以只能使用`const char*`，不能使用`char*`，即`const char* s = "hello"`
## C 语言字符串的输入方法
使用`std::cin`和`>>`运算符进行常规输入，可以一次性将多个字符整体读取，以空格、换行符等作为分隔符，不会读入空格和换行符等分隔符，并且这串字符的末尾还会被自动添加上一个空字符，因此输入之前需要保证有一块足够大的内存空间来存储这些字符，如果空间不足，多余的字符会被写到这块内存的后面，造成对内存的越界访问，是未定义行为
```cpp
// C++20 以前
char s1[5];
std::cin >> s1;
std::cout << s1;
// 输入 abcd
// 输出 abcd

char* s2 = new char[5];
std::cin >> s2;
std::cout << s2;
// 输入 abcd
// 输出 abcd
delete[] s2;
```
从 C++20 开始，`std::cin`会保证输入的字符加上一个空字符不超过目标字符数组的大小，多余的字符会被留在缓冲区内，并且不能再向`char*`输入字符串
```cpp
// C++20 以后
char s[5];
while (std::cin >> s) {
    std::cout << s << '\n';
}
// 输入 abcdefghi
// 输出  
//      abcd
//      efgh
//      i

char* s2 = new char[5];
// std::cin >> s2; 编译错误
delete[] s2;
```
如果需要将空格也作为字符串的一部分读取，需要使用`std::cin.getline()`成员函数，它会读取缓冲区中的字符，直到读取到换行符后停止，并且这个换行符会被丢弃，此外，读取到的这串字符后面还会被添加一个空字符，该成员函数的第一个参数是用来保存字符串的内存的首地址 ( 字符数组名或指向动态分配的内存的指针 )，第二个参数是读取字符的数量，需要考虑到末尾空字符
```cpp
char s1[10];
std::cin.getline(s1, 10); // 输入 abc efg hij klm
std::cout << s1;
// 输出 abc efg h

char* s2 = new char[10];
std::cin.getline(s2, 10); // 输入 abc efg hij klm
std::cout << s2;
// 输出 abc efg h
```
由于`std::cin`的`>>`运算符不会读取空格和换行符等分隔符，一次性输入一串字符时，末尾的空格和换行符等分隔符会被留在缓冲区内，如果紧接着使用`std::cin.getline()`，读取的就是尾部留下的换行符，而不是下一行的字符，和读取字符时一样，使用`std::cin.ignore()`成员函数可以解决这个问题
## 处理字符数组的常用函数
C 语言通过`<string.h>`头文件 ( https://en.cppreference.com/w/c/string/byte ) 提供了许多操作字符数组的函数，C++ 继承了这些函数，C++ 版本的头文件为`<cstring>` ( https://en.cppreference.com/w/cpp/header/cstring ) 

其中`str`开头的函数专门用于 C 语言字符串的处理，`mem`开头的函数本质上是用于将内存按字节处理，可以用于非字符类型的数据，但这里我们只讨论针对字符数组的用法

- `strlen(s)`，获取 C 语言字符串`s`的长度

如果`s`是不包含末尾空字符的普通字符数组，或是空指针，则行为未定义
```cpp
const char* s = "hello";
std::cout << strlen(s) << '\n';
// 输出 5
```
- `strcmp(s1, s2)`，判断 C 语言字符串`s1`，`s2`的字典序关系

若`s1`的字典序小于`s2`，返回负值，若`s1`的字典序大于`s2`，返回正值，若`s1`和`s2`的字典序相同，即两字符串相等，返回 0

如果`s1`或`s2`是不包含末尾空字符的普通字符数组，或是空指针，则行为未定义
```cpp
const char* s1 = "hello";
const char* s2 = "hello";
std::cout << strcmp(s1, s2) << '\n';
// 输出 0
```
- `strcpy(s2, s1)`，复制 C 语言字符串`s1`的内容 ( 包括末尾空字符 )，放入字符数组`s2`或指针`s2`所指的内存中，从第一个字符开始覆盖

如果`s2`的空间不足`strlen(s1) + 1`，则行为未定义

如果复制时源内存与目标内存存在重叠，例如`strcpy(s, s)`，则行为未定义
```cpp
const char* s = "hello";
char s1[6];
strcpy(s1, s);
std::cout << s1 << '\n';
// 输出 hello
```
- `strcat(s2, s1)`，将 C 语言字符串`s1`的内容 ( 包括末尾空字符 )，拼接到 C 语言字符串`s2`末尾，`s2`的末尾空字符会被`s1[0]`覆盖

如果`s2`所指的内存空间不足`strlen(s2) + strlen(s1) + 1`，则行为未定义，因此在拼接两个字符串时通常需要分配新的内存空间

如果拼接时源内存与目标内存存在重叠，例如`strcpy(s, s)`，则行为未定义
```cpp
const char* s1 = "hello";
const char* s2 = "world";
char s3[strlen(s1) + strlen(s2) + 1];
strcpy(s3, s1);
strcat(s3, s2);
std::cout << s3 << '\n';
// 输出 helloworld
```
- `strchr(s, c)`，从 C 语言字符串`s`的第一个字符开始向后寻找字符`c`第一次出现的位置，返回指向该位置的指针，如果找不到则返回空指针

- `strrchr(s, c)`，从 C 语言字符串`s`的最后一个字符开始向前寻找字符`c`第一次出现的位置，返回指向该位置的指针，如果找不到则返回空指针

如果`s`不包含末尾空字符，或为空指针，则行为未定义
```cpp
const char* s = "BBaBaBB";
char* first = strchr(s, 'a');
std::cout << first << '\n';
// 输出 aBaBB
char* last = strrchr(s, 'a');
std::cout << last << '\n';
// 输出 aBB
```
- `strpbrk(s2, s1)`，从 C 语言字符串`s2`的第一个字符开始向后寻找，遇到任意一个字符数组`s1`中的字符就停止寻找 ( 不计末尾空字符 )，返回指向该字符的指针，如果找不到则返回空指针

`s1`中字符的顺序不影响结果

如果`s1`中没有字符或只有空字符，则行为未定义

如果`s2`不包含末尾空字符，或为空指针，则行为未定义
```cpp
const char* s1 = "!,"; // s1 中包含'!'字符和','字符
const char* s2 = "Hello,World! C++";
char* p = strpbrk(s2, s1);
std::cout << p << '\n';
// 输出 ,World! C++
char* p2 = strpbrk(p + 1, s1);
std::cout << p2 << '\n';
// 输出 ! C++
```
- `strspn(s2, s1)`，从 C 语言字符串`s2`的第一个字符开始向后寻找最长前缀子串，该子串的所有字符都由 C 语言字符串`s1`中的字符组成 ( 不计末尾空字符 )，返回该子串的长度，如果找不到则返回`strlen(s2)`

- `strcspn(s2, s1)`，和`strspn(s2, s1)`一样寻找最长前缀子串并返回长度，但对该子串的要求变为不包含 C 语言字符串`s1`中的字符

如果`s1`，`s2`不包含末尾空字符，或为空指针，则行为未定义
```cpp
const char* s1 = "abcd";
const char* s2 = "b";
const char* s3 = "aabba1234bab34554abccdcd";
int i1 = strspn(s3, s1);
std::cout << i1 << '\n';
// 输出 5，满足要求的最长前缀为："aabba"
int i2 = strcspn(s3, s2);
std::cout << i2 << '\n';
// 输出 2，满足要求的最长前缀为："aa"
```
- `strstr(s2, s1)`，在 C 语言字符串`s2`中寻找一个和 C 语言字符串`s1`相同的子串 ( 不计末尾空字符 )，返回指向该子串第一个字符的指针，如果找不到则返回空指针

如果`s1`，`s2`不包含末尾空字符，或为空指针，则行为未定义
```cpp
const char* s1 = "XYYX";
const char* s2 = "ajniafXYYXfoooma";
char* p = strstr(s2, s1);
std::cout << p << '\n';
// 输出 XYYXfoooma
```
- `strtok(s2, s1)`，将 C 语言字符串`s1`中的字符作为分隔符，分割 C 语言字符串`s2`，分割出第一个子串后就停止分割，返回指向该子串第一个字符的指针，分割后的`s2`的剩余部分会被保存到一个静态变量`buffer`中 ( 由该函数自动处理，初始为空指针 )，如果`s2`不能分割出子串，返回空指针，并将`buffer`设为空指针

如果参数`s2`传入空指针，相当于调用`strtok(buffer, s1)`，即继续分割上次分割后剩余的字符串

`s2`必须是可修改的类型，即`char []`或`char*`，不能是`const char*`或`const char[]`，因为每次分割操作都会向`s2`写入空字符

如果`s1`，`s2`必须包含末尾空字符，并且`s1`不能为空指针，否则行为未定义
```cpp
const char* s1 = ",";
char s2[] = "abababa,cccccd,eeeeef";
char* p = strtok(s2, s1);
while (p != nullptr) {
    std::cout << p << std::endl;
    p = strtok(nullptr, s1);
}
// 输出  
//      abababa
//      cccccd
//      eeeeef
```
## mem函数
`<string.h>`头文件中还有一些mem开头的函数，详细内容在Memory.md中

- `memchr(s, c, n)`，在字符数组`s`的前`n`个字符中寻找字符`c`第一次出现的位置，返回指向该地址的`void`指针，如果找不到则返回空指针

如果`n > sizeof s`，则行为未定义
```cpp
char s[] = {'h', '\0', 'l', 'l', 'w'};
char* c = (char*)memchr(s, 'w', sizeof s);
std::cout << *c;
// 输出 w
```
- `memcmp(s1, s2, n)`，比较字符数组`s1`和字符数组`s2`的前`n`个字符的字典序关系，返回值情况和`strcmp(s1, s2)`类似

如果`n > std::min(sizeof s1, sizeof ptr2)`，则行为未定义
```cpp
char s1[] = {'a', 'b', 'c'};
char s2[] = {'a', 'c', 'b'};
if (memcmp(s1, s2, 3) < 0) {
    std::cout << "s1\n";
} else {
    std::cout << "s2\n";
} 
// 输出 s1
```
- `memset(s, c, n)`，向字符数组`s`的前`n`个字节写入字符`c`

如果`n > sizeof s`，则行为未定义
```cpp
char s[5];
memset(s, 'c', sizeof s);
memset(s + 2, 'e', 2);
for (int i = 0; i < 5; i++) {
    std::cout << s[i] << ' ';
}
// 输出 c c e e c
```
该函数还主要被用于将整数数组初始化为零或无穷大值`0x3f3f3f3f`
```cpp
int arr2[5];
memset(arr2, 0, sizeof arr2);
for (int i = 0; i < 5; i++) {
    std::cout << arr2[i] << ' ';
}
// 输出 0 0 0 0 0

int arr3[5];
memset(arr3, 0x3f, sizeof arr3);
for (int i = 0; i < 5; i++) {
    std::cout << arr3[i] << ' ';
}
// 输出 1061109567 1061109567 1061109567 1061109567 1061109567
```
- `memcpy(s2, s1, n)`，复制字符数组`s1`的前`n`个字符到指针`s2`所指内存中

如果`s1`或`s2`为空指针，则行为未定义

如果`n > std::min(sizeof s1, sizeof s2)`，则行为未定义

如果`s1`和`s2`指针所指的内存出现重叠，则行为未定义
```cpp
char s1[] = "hello";
char s2[3];
memcpy(s2, s1, sizeof s2);
for (int i = 0; i < 3; i++) {
    std::cout << s2[i];
}
// 输出 hel
```
- `memmove(s2, s1, n)`，移动字符数组`s1`的前`n`个字符到指针`s2`所指内存中

如果`s1`或`s2`为空指针，则行为未定义

如果`n > std::min(sizeof s1, sizeof s2)`，则行为未定义

`s1`和`s2`所指的内存可以重叠，如果出现重叠，则`s1`所指的内容会先被复制到一片新的内存空间中，然后再从这块新的内存空间复制到`s2`所指内存中
```cpp
char s1[] = "123456789";
memmove(s1 + 3, s1, 6);
std::cout << s1;
// 输出 123123456
```
我们可以看到，即便有库函数的支持，C 语言字符串的使用依然非常不方便，并且非常容易引发各种错误，在 C++ 中，处理字符串更好的选择是标准库`std::string`类型
# `std::string`类
`std::string`类定义在`<string>`头文件中 ( https://en.cppreference.com/w/cpp/string/basic_string )，是 C++ 标准库提供的动态`char`字符数组容器，它是经过封装的 C 语言字符串，通过成员函数提供了丰富的功能
## 构造函数
- `std::string()`

默认构造函数，构造空字符串
- `std::string(n, c)`

使用`n`个字符`c`构造字符串
- `std::string(c_s)`

使用 C 语言字符串`c_s`构造字符串

如果`c_s`没有末尾空字符，即`c_s`是普通字符数组，则行为未定义

如果`c_s`是空指针，则抛出`std::logic_error`异常
- `std::string(c_s, n)`

使用字符数组`c_s`的前`n`个字符构造字符串

如果`n`超出`c_s`的内存范围，则行为未定义

如果`c_s`是空指针，则抛出`std::logic_error`异常
```cpp
const char c_s[] {'a', 'b', 'c'};

std::string str;
// str 是空字符串

std::string str0(10, '*');
std::cout << str0 << '\n';
// 输出 **********

std::string str1("hello\0world");
std::cout << str1 << '\n';
// 输出 hello

std::string str2("hello\0world", 7);
std::cout << str2 << '\n';
// 输出 hellow 或 hello w (空字符的输出结果由编译器实现决定)

std::string str3(c_s, 2);
std::cout << str3 << '\n';
// 输出 ab
```
使用`=`运算符初始化字符串时可以隐式调用构造函数`std::string(c_s)`
```cpp
std::string str = "hello";
std::cout << str << '\n';
// 输出 hello
```
但`std::string`字符串不能被隐式转换为 C 语言字符串，如果需要获取对应的 C 语言字符串，必须调用`c_str()`或`data()`成员函数，它们返回一个`const char*`指针，指向对应的 C 语言字符串的首字符，如果需要修改内容，则应该先使用`strcpy()`函数 ( 定义在`<cstring>`头文件中 ) 拷贝，再进行修改
```cpp
std::string s = "hello";
const char* c_s = s.c_str();
std::cout << c_s << '\n';
// 输出 hello
```
- `std::string(str)`

使用`std::string`字符串`str`构造字符串
- `std::string(str, pos)`

截取`std::string`字符串`str`从下标`pos`开始到末尾的子串构造字符串

如果`pos > str.size()`，则抛出`std::out_of_range`异常
- `std::string(str, pos, n)`

截取`std::string`字符串`str`从下标`pos`开始长度为`n`的子串构造字符串

如果`pos > str.size()`，则抛出`std::out_of_range`异常

如果`n > str.size() - pos`，则只会截取到`str`末尾
```cpp
std::string s = "hello world";

std::string str1(s);
std::cout << str1 << '\n';
// 输出 hello world

std::string str2(s, 4);
std::cout << str2 << '\n';
// 输出 o world

std::string str3(s, 3, 6);
std::cout << str3 << '\n';
// 输出 lo wor
```
- `std::string(begin, end)`

使用`begin`迭代器和`end`迭代器截取的子串构造字符串

`begin`表示起始位置的迭代器，`end`表示结束位置的迭代器，截取的范围是`[begin, end)`
```cpp
const char c_s[] = "abc#de#gfhi";
const std::string s("qwert#abcd");

std::string str1(std::begin(c_s) + 3, std::end(c_s) - 2);
std::cout << str1 << '\n';
// 输出 #de#gfh

std::string str2(s.begin() + 1, s.begin() + 5);
std::cout << str2 << '\n';
// 输出 wert
```
## `std::string`字符串字面量
可以通过重载`operator""`运算符来定义`std::string`字面量，引号后面写上符合标识符命名规则的名字，并且必须以下划线开头，例如`_s`
```cpp
std::string operator""_s(const char* s, std::size_t len) {
    return std::string(s, len);
}

auto str = "hello"_s;
// str 是 std::string 类型
```
从 C++14 开始，在标准库`std::literals::string_literals`命名空间中已经预定义了`operator""s`，可以通过`using namespace std::literals::string_literals;`或`using namespace std::literals;`或`using namespace std;`来使用它
```cpp
using namespace std::literals::string_literals;

auto str = "world"s;
// str 是 std::string 类型
```
## `std::string`字符串的输入方法
使用`std::cin`进行常规输入，以空格、换行符等作为分隔符，不会读入空格和换行符等分隔符
```cpp
std::string s;
std::cin >> s;
std::cout << s;
// 输入 hello world
// 输出 hello
```
如果需要将空格也作为字符串的一部分读取，需要使用`std::getline()`函数 ( 定义在`<string>`头文件中 )，它会读取缓冲区中的字符，直到读取到换行符后停止，并且这个换行符会被丢弃，该函数的第一个参数是输入流，通常是`std::cin`，第二个参数是目标`std::string`变量
```cpp
std::string s;
std::getline(std::cin, s); 
std::cout << s;
// 输入 hel lo wor ld
// 输出 hel lo wor ld
```
由于`std::cin`的`>>`运算符不会读取空格和换行符等分隔符，一次性输入一串字符时，末尾的空格和换行符等分隔符会被留在缓冲区内，如果紧接着使用`std::getline()`，读取的就是尾部留下的换行符，而不是下一行的字符，和使用`std::cin.getline()`成员函数读取 C 语言字符串时一样，使用`std::cin.ignore()`成员函数可以解决这个问题
## `std::string`字符串的基本操作
### 访问字符
- `[]`运算符

和 C 语言字符串一样使用下标访问字符串中保存的字符，没有边界检查，对于`std::string`字符串来说，该运算符的特别之处是，`[size()]`是有定义的行为，会返回`char()`，即空字符，但该位置只能访问，不能修改，对该位置进行修改是未定义行为，当下标`> size()`时属于越界访问，是未定义行为
```cpp
std::string s("hello");

std::cout << s[4] << '\n';
// 输出 o

std::cout << (s[s.size()] == '\0') << '\n';
// 输出 1
```
- `s.at(i)`

和`[]`运算符类似，访问当前字符串中下标为`i`的字符，不同之处是该函数包含边界检查，因此效率低于`[]`运算符，当检查到访问的下标`>= size()`时，抛出`std::out_of_range`异常
```cpp
std::string s("hello");

std::cout << s.at(1) << '\n';
// 输出 e

try {
    std::cout << (s.at(s.size()) == '\0') << '\n';
} catch (const std::out_of_range& e) {
    std::cout << e.what() << '\n';
}
// 输出异常信息
```
- `s.front()`

获取`s`的第一个字符

如果`s`为空字符串，则行为未定义
- `s.back()`

获取`s`的最后一个字符

如果`s`为空字符串，则行为未定义
```cpp
std::string s("hello");
std::cout << s.front() << '\n';
// 输出 h
std::cout << s.back() << '\n';
// 输出 o
```
### 查看、修改基本属性
- `s.empty()`
  
判断`s`是否为空，如果为空，返回`true`，否则返回`false`
- `s.size()`

返回`s`的长度，即字符的个数
- `s.resize(n)`

修改`s`的长度为`n`，如果`n < s.size()`，那么`s`缩减为包含前`n`个字符的字符串，如果`n > s.size()`，那么多出来的部分使用空字符填充

- `s.resize(n, c)`

修改`s`的长度为`n`，如果`n < s.size()`，那么`s`缩减为包含前`n`个字符的字符串，如果`n > s.size()`，那么多出来的部分使用字符`c`填充
```cpp
std::string s("hello");

std::cout << "size = " << s.size() << '\n';
// 输出 size = 5

s.resize(3);
std::cout << "size = " << s.size() << '\n';
std::cout << s << '\n';
// 输出
//     size = 3
//     hel

s.resize(10, '+');
std::cout << "size = " << s.size() << '\n';
std::cout << s << '\n';
// 输出
//     size = 10
//     hel+++++++
```
### 字典序比较
- `>, >=, <, <=, ==, !=`运算符

返回`bool`值，C 语言字符串可以参与比较，但两侧操作数必须至少有一个是`std::string`类型

```cpp
char c_s1[] = "abcd1";
char c_s2[] = "abcd2";
std::string s1("abcd1");
std::string s2("abcd2");

std::cout << "FT"[s1 > s2] << '\n';
// 输出 F

std::cout << "FT"[c_s1 == s1] << '\n';
// 输出 T
```
- `s.compare(str)`

将`s`和`str`进行比较

`str`可以是`std::string`字符串，也可以是 C 语言字符串
- `s.compare(pos1, n1, str)`

截取`s`从下标`pos1`开始长度为`n1`的子串和`str`进行比较

`str`可以是`std::string`字符串，也可以是 C 语言字符串
- `s.compare(pos1, n1, str, pos2, n2)`

截取`s`从下标`pos1`开始长度为`n1`的子串和`str`从下标`pos2`开始长度为`n2`的子串进行比较
- `s.compare(pos1, n1, c_s, n2)`

取`s`从下标`pos1`开始长度为`n1`的子串和字符数组`c_s`从头开始长度为`n2`的子串进行比较

`compare()`成员函数返回值为`int`类型的整数，其中负值，0，正值分别表示字典序的`<`，`=`，`>`关系
```cpp
char c_s1[] = "abcd1";
char c_s2[] = "abcd2";
std::string s1("abcd1");
std::string s2("abcd2");

std::cout << "FT"[s1.compare(s2) < 0] << '\n';
// 输出 T

std::cout << "FT"[s1.compare(0, 4, s2, 0, 4) == 0] << '\n';
// 输出 T

std::cout << "FT"[s1.compare(c_s2) > 0] << '\n';
// 输出 F
```
### 赋值
- `=`运算符

可以使用字符、C 语言字符串、`std::string`字符串进行赋值
```cpp
std::string s;

s = 'A';
std::cout << s << '\n';
// 输出 A

s = "abcd";
std::cout << s << '\n';
// 输出 abcd

s = std::string(s.begin(), s.end() - 2);
std::cout << s << '\n';
// 输出 ab
```
- `s.assign(n, c)`
- `s.assign(str)`
- `s.assign(str, pos)`
- `s.assign(str, pos, n)`
- `s.assign(c_s)`
- `s.assign(c_s, n)`
- `s.assign(begin, end)`
  
使用特定内容对`s`赋值，具体内容由不同重载的参数决定，各重载中参数的含义和构造函数相同，此处不再赘述
```cpp
const char c_s[] = "abcdefghi";
std::string str(c_s);

std::string s;
s.assign(5, '#');
std::cout << s << '\n';
// 输出 #####

s.assign(str, 5, 2);
std::cout << s << '\n';
// 输出 fg

s.assign(c_s, 5);
std::cout << s << '\n';
// 输出 abcde

s.assign(std::begin(c_s) + 2, std::end(c_s) - 2);
std::cout << s << '\n';
// 输出 cdefgh
```
### 拼接字符串
- `+`运算符

将字符、C 语言字符串、`std::string`字符串拼接起来，并返回`std::string`类型的字符串，该运算符的两侧操作数必须至少有一个是`std::string`类型
```cpp
std::string s;
s = '*' + std::string("abc") + "hello" + '*';
std::cout << s << '\n';
// 输出 *abchello*
```
- `+=`运算符

在`std::string`字符串的末尾添加字符、C 语言字符串、`std::string`字符串
```cpp
std::string s;
s += '+';
std::cout << s << '\n';
// 输出 +
s += "what";
std::cout << s << '\n';
// 输出 +what
s += std::string(10, '#');
std::cout << s << '\n';
// 输出 +what##########
```
- `s.append(n, c)`
- `s.append(str)`
- `s.append(str, pos)`
- `s.append(str, pos, n)`
- `s.append(c_s)`
- `s.append(c_s, n)`
- `s.append(begin, end)`

在`s`的末尾添加特定内容，具体内容由不同重载的参数决定，各重载中参数的含义和构造函数相同，此处不再赘述
```cpp
const char c_s[] = "abcdefgh";
std::string str(c_s);

std::string s;
s.append(3, '8').append(str, 2, 3).append(c_s, 3).append(str.begin() + 3, str.end() - 1);
std::cout << s << '\n';
// 输出 888cdeabcdefg
```
### 其他简单操作
- `s.clear()`
 
将`s`变为空字符串
- `s.push_front(c)`

在`s`的末尾添加一个字符`c`
- `s.pop_back()`

在`s`的末尾删除一个字符

如果`s`是空字符串，则行为未定义
## `std::string`字符串的高级操作
### 获取子字符串
- `s.substr(pos, n = s.npos)`

截取从`s`的`pos`下标开始长度为`n`的子串并返回，不修改`s`

`n`默认为`s.npos`，即`static_cast<std::size_t>(-1)`

如果`n > s.size() - pos`，则表示截取到字符串末尾

如果`pos > s.size()`，则抛出`std::out_of_range`异常
```cpp
std::string s("bcdea12345");

std::cout << s.substr(3) << '\n';
// 输出 ea12345

std::cout << s.substr(3, 4) << '\n';
// 输出 ea12
```
### 查找
- `s.find(c, pos = 0)`

从`s`的`pos`下标开始向后查找字符`c`第一次出现的位置，返回该位置的下标

`pos`默认为 0

如果找不到字符`c`，则返回 `s.npos`
- `s.find(str, pos = 0)`

从`s`的`pos`下标开始向后查找字符串`str`第一次出现的位置，返回该字符串第一个字符位置的下标

`pos`默认为 0

`str`可以是`std::string`类型，也可以是 C 语言字符串

如果找不到字符串`str`，则返回 `s.npos`
- `s.find(c_s, pos, n)`

截取字符数组`c_s`的前`n`个字符为子串，从`s`的`pos`下标开始向后查找该子串第一次出现的位置，返回该子串第一个字符位置的下标

如果`n`超过`c_s`的内存范围，则行为未定义

如果找不到该子串，则返回 `s.npos`
- `s.rfind(c, pos = s.npos)`
- `s.rfind(str, pos = s.npos)`
- `s.rfind(c_s, pos, n)`

从`s`的`pos`下标开始向前查找

如果`pos > s.size()`，表示从末尾开始

其余性质和`find()`相同
```cpp
char c_s[] {'1', '2', '3', 'a'};
std::string s("abcd1234xyz abcd1234xyz");

std::cout << s.find('c') << '\n';
// 输出 2

std::cout << s.find("xyz") << '\n';
// 输出 8

std::cout << s.find(c_s, 0, 3) << '\n';
// 输出 4

std::cout << s.rfind('c') << '\n';
// 输出 14

std::cout << s.rfind("xyz") << '\n';
// 输出 20

std::cout << s.rfind(c_s, s.npos, 3) << '\n';
// 输出 16
```
- `s.find_first_of(c, pos = 0)`

和`s.find(c, pos = 0)`相同
- `s.find_first_of(str, pos = 0)`

从`s`的`pos`下标开始向后查找第一个属于`str`的字符，返回该位置的下标

`pos`默认为 0

`str`可以是`std::string`类型，也可以是 C 语言字符串

如果找不到字符串`str`，则返回 `s.npos`

`str`中字符的排列顺序不影响结果
- `s.find_first_of(c_s, pos, n)`

截取字符数组`c_s`的前`n`个字符为子串，从`s`的`pos`下标开始向后查找第一个属于该子串的字符，返回该位置的下标

如果找不到字符串`str`，则返回 `s.npos`
- `s.find_first_not_of(c, pos = 0)`

从`s`的`pos`下标开始向后查找第一个不等于`c`的字符，返回该位置的下标
- `s.find_first_not_of(str, pos = 0)`

从`s`的`pos`下标开始向后查找第一个不属于`str`的字符，返回该位置的下标

其余性质和`s.find_first_of(str, pos = 0)`相同
- `s.find_first_not_of(c_s, pos, n)`

截取字符数组`c_s`的前`n`个字符为子串，从`s`的`pos`下标开始向后查找第一个不属于该子串的字符，返回该位置的下标

其余性质和`s.find_first_of(c_s, pos, n)`相同
- `s.find_last_of(c, pos = s.npos)`
- `s.find_last_of(str, pos = s.npos)`
- `s.find_last_of(c_s, pos, n)`
- `s.find_last_not_of(c, pos = s.npos)`
- `s.find_last_not_of(str, pos = s.npos)`
- `s.find_last_not_of(c_s, pos, n)`

从`s`的`pos`下标开始向前查找

如果`pos > s.size()`，表示从末尾开始

其余性质和`find_first_of()`，`find_first_not_of()`相同
```cpp
char c_s[] {'C', 'b', 'A', 'x', 'c'};
std::string str = "xbACa";
std::string s = "xAbbac";

std::cout << s.find_first_of(str) << '\n';
// 输出 0

std::cout << s.find_first_of(c_s, 0, 3) << '\n';
// 输出 1

std::cout << s.find_first_not_of('x') << '\n';
// 输出 1

std::cout << s.find_first_not_of(str) << '\n';
// 输出 5

std::cout << s.find_first_not_of(c_s, 0, 5) << '\n';
// 输出 4

std::cout << s.find_last_of('a') << '\n';
// 输出 4

std::cout << s.find_last_of(str) << '\n';
// 输出 4

std::cout << s.find_last_of(c_s, s.npos, 3) << '\n';
// 输出 3

std::cout << s.find_last_not_of('a') << '\n';
// 输出 5

std::cout << s.find_last_not_of(str) << '\n';
// 输出 5

std::cout << s.find_last_not_of(c_s, s.npos, 4) << '\n';
// 输出 5
```
C++20 以上可用：
- `s.starts_with(str)`

判断`s`是否以`str`为前缀，返回布尔值

`str`可以是`std::string`字符串，也可以是 C 语言字符串，也可以是单个字符
- `s.ends_with(str)`

判断`s`是否以`str`为后缀，返回布尔值

`str`可以是`std::string`字符串，也可以是 C 语言字符串，也可以是单个字符
```cpp
std::string s("abc, 11239084, xyz");

std::cout << s.starts_with("abc") << '\n';
// 输出 1
std::cout << s.ends_with("abc") << '\n';
// 输出 0
```
### 插入
- `s.insert(pos, n, c)`

在`s`下标为`pos`的位置插入`n`个字符`c`
- `s.insert(pos, str)`
  
在`s`下标为`pos`的位置插入`str`

`str`可以是`std::string`字符串，也可以是 C 语言字符串
- `s.insert(pos1, str, pos2, n)`

在`s`下标为`pos1`的位置插入从`str`的`pos2`下标开始截取的长度为`n`的子串
- `s.insert(pos, c_s, n)`

在`s`下标为`pos`的位置插入字符数组`c_s`的开头`n`个字符
- `s.insert(begin, c)`

`begin`迭代器指向`s`中某个位置，在此位置之前插入字符`c`
- `s.insert(begin, n, c)`

`begin`迭代器指向`s`中某个位置，在此位置之前插入`n`个字符`c`
- `s.insert(begin, src_begin, src_end)`

`begin`迭代器指向`s`中某个位置，在此位置之前插入一段通过迭代器`src_begin`和`src_end`截取的内容

`src_begin`表示起始位置的迭代器，`src_end`表示结束位置的迭代器，截取的范围是`[src_begin, src_end)`
```cpp
std::string s;

s.insert(0, 3, '#');
std::cout << s << '\n';
// 输出 ###

s.insert(3, std::string("abc"), 0, 2);
std::cout << s << '\n';
// 输出 ###ab

s.insert(0, "hello", 3);
std::cout << s << '\n';
// 输出 hel###ab

s.insert(s.begin(), 2, '+');
std::cout << s << '\n';
// 输出 ++hel###ab

std::string s2("ABCD");
s.insert(s.begin(), s2.begin(), s2.begin() + 3);
std::cout << s << '\n';
// 输出 ABC++hel###ab
```
### 删除
- `s.erase(pos, n)`

删除`s`中从下标`pos`开始的`n`个字符

`n`默认为`s.npos`

如果`n > s.size() - pos`，那么只会删除到末尾

如果`pos > str.size()`，则抛出`std::out_of_range`异常
- `s.erase(target)`

`target`迭代器指向`s`中的某个位置，删除该位置的单个字符

如果`s`是空字符串，或`target`超出范围，则行为未定义
- `s.erase(begin, end)`

删除`s`中迭代器`begin`和`end`之间的内容，删除的范围是`[begin, end)`

如果`begin`或`end`超出范围，则行为未定义
```cpp
std::string src("hello abcde");
std::string s;

s = src;
s.erase(3);
std::cout << s << '\n';
// 输出 hel

s = src;
s.erase(3, 4);
std::cout << s << '\n';
// 输出 helbcde

s = src;
s.erase(s.begin() + 5);
std::cout << s << '\n';
// 输出 helloabcde

s = src;
s.erase(s.begin() + 5, s.begin() + 8);
std::cout << s << '\n';
// 输出 hellocde
```
### 替换
#### `s.replace(pos, n, str)`
使用`str`替换`s`中从下标`pos`开始的`n`个字符

如果`n > s.size() - pos`，那么只会替换到末尾

`str`可以是`std::string`字符串，也可以是 C 语言字符串

如果`pos > s.size()`，则抛出`std::out_of_range`异常
#### `s.replace(pos, n1, n2, c)`
使用`n2`个字符`c`替换`s`中从下标`pos`开始的`n1`个字符

如果`n1 > s.size() - pos`，那么只会替换到末尾
#### `s.replace(pos, n1, c_s, n2)`
使用字符数组`c_s`的前`n2`个字符替换`s`中从下标`pos`开始的`n1`个字符

如果`n1 > s.size() - pos`，那么只会替换到末尾

如果`n`超出字符数组`c_s`的范围，则行为未定义
#### `s.replace(pos1, n1, str, pos2, n2)`
截取`std::string`字符串`str`中从下标`pos2`开始长度为`n2`的子串，替换`s`中从下标`pos1`开始的`n1`个字符

如果`n1 > s.size() - pos1`，那么只会替换到末尾，如果`n2 > str.size() - pos2`，那么只会截取到末尾

如果`pos1 > s.size() || pos2 > str.size()`，则抛出`std::out_of_range`异常
#### `s.replace(begin, end, str)`
使用`str`替换`s`中迭代器`begin`和`end`之间的内容，替换的范围是`[begin, end)`

`str`可以是`std::string`字符串，也可以是 C 语言字符串

如果`begin`或`end`超出范围，则行为未定义
#### `s.replace(begin, end, n, c)`
使用`n`个字符`c`替换`s`中迭代器`begin`和`end`之间的内容，替换的范围是`[begin, end)`

如果`begin`或`end`超出范围，则行为未定义
#### `s.replace(begin, end, c_s, n)`
使用字符数组`c_s`的前`n2`个字符替换`s`中迭代器`begin`和`end`之间的内容，替换的范围是`[begin, end)`

如果`begin`或`end`超出范围，则行为未定义

如果`n`超出字符数组`c_s`的范围，则行为未定义
#### `s.replace(begin, end, src_begin, src_end)`
使用一段通过迭代器`src_begin`和`src_end`截取的字符串替换`s`中迭代器`begin`和`end`之间的内容，截取的范围是`[src_begin, src_end)`，替换的范围是`[begin, end)`

如果`src_begin`或`src_end`或`begin`或`end`超出范围，则行为未定义
```cpp
std::string s;
std::string src("asdfghjk");

s = "AABCC";
s.replace(2, 1, "12345");
std::cout << s << '\n';
// 输出 AA12345CC

s = "AABCC";
s.replace(s.begin() + 2, s.end() - 2, "45678", 3);
std::cout << s << '\n';
// 输出 AA456CC

s = "AABCC";
s.replace(1, 3, 3, '#');
std::cout << s << '\n';
// 输出 A###C

s = "AABCC";
s.replace(s.begin() + 2, s.end() - 2, src.begin(), src.begin() + 3);
std::cout << s << '\n';
// 输出 AAasdCC
```
### 字符串和数字的互相转换
- `std::to_string(s)`

返回`std::string`字符串`s`对应的数字

该函数主要对整数使用，转换浮点数非常不精确，尽量不要对浮点数使用

https://en.cppreference.com/w/cpp/string/basic_string/to_string

- `std::stoi()`，`std::stol()`，`std::stoll()`，`std::stoul()`，`std::stoull()`，`std::stof()`，`std::stod()`，`std::stold()`函数

将字符串转换为对应的整数，通过函数名可以判断返回类型，如果所转换的字符串内容大于了返回类型，则会抛出`std::out_of_range`异常

函数，将字符串转换为对应的浮点数，但这些函数不能指定生成的浮点数的精度 ( 位数 )

https://en.cppreference.com/w/cpp/string/basic_string/stol

https://en.cppreference.com/w/cpp/string/basic_string/stoul


上列函数实际上都是调用c语言库函数实现的转换(详见cppref)，因此会有诸多问题，此处我们只需要知道，所有整数字面量都能够正确进行转换并达到预期效果，几乎所有浮点数的转换都不可靠，应当使用sstream，详见iolibs.md

C++17 使用`<charconv>`代替`std::to_string()`
使用`<sstream>`代替`std::stoi()`等函数
### `string_view`
C++17 标准引入了`string_view`类，它是一个只读类，提供更高效的查找、切片等功能


修改：在样例代码的注释上写明调用的是哪个重载、将所有边界条件放到一段的最后讨论，避免重复

### 正则表达式
<regex>