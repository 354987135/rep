#set text(font: "Microsoft YaHei")
#set align(center)
#set text(16pt)
= GESP三级重点知识
#set align(left)
#set text(14pt)

关于数组的内容见../xxx/xxx
== 一维数组
+ 声明一维数组的语法

  *类型 数组名[长度];* \
  其中，*长度* 必须是 *大于0的整型常量表达式* \
  *正确*写法：\
  - ```cpp int a[10]; ```

  - ```cpp int a['a']; ```
  
  - ```cpp const int n = 5; 
  int a[n]; ```  
  *错误*写法：
  - ```cpp int a[]; ```

  - ```cpp int a[0]; ```

  - ```cpp int a[3.14]; ```

  - ```cpp
  int n; cin >> n;
  int a[n];
  ```

  - ```cpp
  int a; cin >> a;
  const int n = a;
  int a[n];
  ```
+ 初始化一维数组的语法
  
  指定长度和元素，从左到右依次赋值，多余的位置自动赋值为0
  ```cpp
  int a[5] = {1, 3, 4};
  ```
  相当于 ```cpp int a[5] = {1, 3, 4, 0, 0}; ```
  
  进行初始化时可以省略长度，编译器会自动推断出数组的长度
  ```cpp
  int a[] = {1, 3, 4};
  ```
  相当于```cpp int a[3] = {1, 3, 4}; ```
  
  赋值运算符也可以省略
  ```cpp
  int a[] {1, 3, 4};
  ```
  相当于```cpp int a[] = {1, 3, 4}; ```
+ 访问一维数组的元素
  
  数组中的元素从*0*开始编号，一直到*长度-1*，称为下标 \
  使用 [] 运算符和下标可以访问数组中的特定元素
  ```cpp
  int a[5] {1, 3, 4, 5, 8};
  cout << a[1] << ' ' << a[4];
  // 3 8
  ```
  [] 内的数字不能超过*长度-1*，否则称为*越界访问*，是*未定义行为*，即错误代码
== 进制和进制转换
  
  - 逢R进1的进位计数制，称为R进制
  - 计算机领域常用的进制：二进制、八进制、十六进制、十进制 \
    二进制：数位只能取0\~1，例如10011 \
    八进制：数位只能取0\~7，例如372 \
    十六进制：数位只能取0\~15，其中10\~15使用英文字母A\~F表示，大小写均可，例如1A8F
  - R进制转换为十进制的方法：*按位权展开求和*，位权从低位到高位递增，最右数位的位权是0 \
    例如 $("1A8F")_16$的各数位位权分别是3210，得到位权后按下列方法计算得到其十进制大小
    $ "ans" = 1*16^3+A*16^2+8*16^1+F*16^0 $
    $ = 1*16^3+10*16^2+8*16^1+15*16^0 $
    $ = 4096+2560+128+15 = (6799)_10 $
  代码实现：\
  ```cpp
  string num = "1A8F";
  int R = 16, w = 1, ans = 0;
  for (int i = num.size() - 1; i >= 0; --i) {
      if (isdigit(num[i])) {
          ans += (num[i] - '0') * w;
      } else {
          ans += (num[i] - 'A' + 10) * w;
      }
      w *= R;
  }
  cout << ans;
  ```
  - 十进制转换为R进制的方法：*除R取余*\
    将原数除以R，得到商和余数，余数就是该数在R进制下的个位，将第一次得到的商继续除以R，得到的余数就是该数在R进制下的十位，依此类推，直到原数除以R的商为0 \
    代码实现：
    ```cpp
    int N = 6799, R = 16;
    string ans;
    while (N > 0) {
        if (N % R < 10) {
            ans += N % R + '0';
        } else {
            ans += N % R - 10 + 'A';
        }
        N /= R;
    }
    ```
    此时得到的ans存储的是*倒序*的，即F8A1，只需要倒序将其输出即可得到1A8F