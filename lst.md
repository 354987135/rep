# 链表与数组的联系
链表和数组都属于线性表，线性表是用来存储相同类型数据元素的数据结构，顺序存储的线性表称为数组，链式存储的线性表称为链表

顺序存储时，数据元素在内存中实际的存储位置是连续的，可以通过指针的加减运算来随机访问数组内的数据元素

链式存储时，数据元素在内存中实际的存储位置可以是连续的，也可以是不连续的，一般来说默认是不连续的，必须明确知道下一个数据元素存储的地址才能访问到下一个数据元素

不同的存储方式有不同的性能，在访问数据元素时，数组优于链表，在插入和删除数据元素时，链表优于数组
### 单链表的概念和定义
单链表，即单向链表，由若干个单链表节点组成，每个节点中包含数据元素和 $1$ 个指针，该指针保存直接后继的地址，因此，通过当前节点只能访问下一个节点，不能访问前一个节点

由此，我们可以定义一个最基本的单链表节点，其中第一个构造函数用于创建空节点，第二个构造函数用于创建含数据元素的节点
```cpp
struct SingleNode {
    int data;
    SingleNode* next;

    SingleNode() : data(), next() {}
    SingleNode(int e) : data(e), next() {}
};
```
析构函数可选，用于当节点内存被释放时打印出被删除的节点
```cpp
~SingleNode() { std::cout << "Node " << this->data << " deleted\n"; }
```
单链表中的重要术语
#### 头指针
头指针表示单链表中指向第一个节点的指针，通常用 $head$ 命名，可以通过 $head$ 指针是否为空指针来判断单链表是否为空链表

由于单链表节点只能访问其直接后继的特性，对单链表某个节点进行操作之前，需要先从头指针出发往后遍历寻找该节点，不能像数组一样使用下标随机访问节点
#### 头节点
有时候为了方便操作，会在单链表第一个节点之前再设置一个不存储数据元素的特殊节点，称为头节点

添加头节点后，头节点就是单链表的第一个节点，因此头指针指向头节点
#### 首元节点
单链表中第一个保存数据元素的节点称为首元节点，如果单链表没有头节点，那么头指针就指向首元节点

由此，我们可以定义一个单链表类，其中构造函数用于创建不带头节点的空链表
```cpp
struct SingleList {
    SingleNode* head;

    SingleList() : head() {}
};
```
### 单链表的其他成员函数
下列成员函数默认处理不含头节点的单链表，处理含头节点的单链表时需要进行一定的修改
#### 打印单链表
从头指针开始向后遍历并打印每个节点的数据元素，每个数据元素之间用一个空格隔开

$while$ 循环的条件已经避免了对空链表的操作，不需要单独处理单链表为空的情况
```cpp
void Print() {
    SingleNode* cur = this->head;
    while (cur != nullptr) {
        std::cout << cur->data << ' ';
        cur = cur->next;
    }
    std::cout << '\n';
}
```
#### 在头部插入节点
在插入节点之前，首先要创建一个新的节点，将其命名为 $newNode$

将新节点的 $next$ 指针指向原来的第一个节点，再更新头指针即可，该方法可以处理空链表
```cpp
void InsertAtHead(int data) {
    SingleNode* newNode = new SingleNode(data);
    newNode->next = this->head;
    this->head = newNode;
}
```
#### 在尾部插入节点
当单链表为空时，情况和在头部插入节点相同

当单链表非空时，将尾部节点的 $next$ 指针指向新节点即可

在此之前，必须要先找到并标记尾部节点，将该标记命名为 $cur$，利用尾部节点的 $next$ 指针是空指针这个特征，循环 $cur=cur\to next$，更新 $cur$ 指针的值，直到 $cur\to next$ 为空指针，此时循环结束，$cur$ 指针保存的就是尾部节点的地址
```cpp
void InsertAtTail(int data) {
    if (this->head == nullptr) {
        InsertAtHead(data);
        return;
    }
    SingleNode* newNode = new SingleNode(data);
    SingleNode* cur = this->head;
    while (cur->next != nullptr) {
        cur = cur->next;
    }
    cur->next = newNode;
}
```
#### 在特定位置 $index$ 处插入节点
当 $index=0$ 时，情况和在头部插入节点相同

当 $index<0$ 时，无法在该位置插入节点，不做任何操作

当 $index>0$ 且 $index\le$ 单链表长度时，需要使用 $cur$ 指针找到 $index-1$ 位置的节点并修改它的 $next$ 指针，在循环更新 $cur$ 指针的同时，使用变量 $i$ 进行计数，当计数 $i=index-1$ 时停止循环，此时 $cur$ 指针就指向了 $index-1$ 位置的节点，将新节点的 $next$ 指针指向原来 $index$ 位置的节点，然后再将 $index-1$ 位置节点的 $next$ 指针指向新节点

当 $index>$ 单链表长度时，也无法在该位置进行插入，可以合并到 $index<0$ 的分支中去

应该如何检测 $index$ 是否 $>$ 单链表长度？在上一种情况的循环条件中添加 $cur\ne nullptr$，如果 $index-1$ 位置超过了单链表的最后一个元素，$cur$ 指针就会被更改为空指针，在循环结束后设置分支，将这种情况与 $index<0$ 的情况一起处理
```cpp
void InsertAtIndex(int index, int data) {
    if (index == 0) {
        InsertAtHead(data);
        return;
    }
    SingleNode* newNode = new SingleNode(data);
    SingleNode* cur = this->head;
    for (int i = 0; i < index - 1 && cur != nullptr; i++) {
        cur = cur->next;
    }
    if (index < 0 || cur == nullptr) {
        return;
    }
    newNode->next = cur->next;
    cur->next = newNode;
}
```
#### 在头部删除节点
删除节点不仅需要调整指针，还需要释放被删除节点的内存

当单链表为空时，不需要做任何操作

当单链表非空时，将头指针指向下一个节点，然后释放原来节点的内存即可

要注意，更新头指针时第一个节点的地址会丢失，必须要有第一个节点的地址才能释放第一个节点的内存，因此要先使用 $pre$ 指针保存头部节点的地址 ( 也可以先保存下一个节点的地址，释放第一个节点的内存后再更新头指针 )
```cpp
void DeleteAtHead() {
    if (this->head == nullptr) {
        return;
    }
    SingleNode* pre = this->head;
    this->head = this->head->next;
    delete pre;
}
```
#### 在尾部删除节点
当单链表为空或只有一个节点时，情况和在头部删除节点时相同

当单链表存在 $2$ 个及以上节点时，先释放尾部节点的内存，再修改尾部节点前一个节点的 $next$ 指针为空指针即可

同样使用 $cur$ 指针来寻找并标记目标节点，因为尾部节点的特征是 $cur\to next=nullptr$，所以尾部节点前一个节点的特征就是 $cur\to next\to next=nullptr$
```cpp
void DeleteAtTail() {
    if (this->head == nullptr || this->head->next == nullptr) {
        DeleteAtHead();
        return;
    }
    SingleNode* cur = this->head;
    while (cur->next->next != nullptr) {
        cur = cur->next;
    }
    delete cur->next;
    cur->next = nullptr;
}
```
#### 在特定位置 $index$ 处删除节点
当 $index=0$ 时，情况和在头部删除节点相同

当 $index<0$ 时，无法在该位置删除节点，不做任何操作

当 $index>0$ 且 $index<$ 单链表长度时，和插入节点相同，需要使用 $cur$ 指针找到 $index-1$ 位置的节点，修改其 $next$ 指针，然后释放 $index$ 位置节点的内存 ( 和在头部删除节点一样，顺序可以调换 )

当 $index\ge$ 链表长度时，也无法在该位置删除节点，可以合并到 $index<0$ 的分支中去

使用和插入节点时相同的方法检测 $index\ge$ 单链表长度的情况，并在循环结束后与 $index<0$ 的情况合并处理
```cpp
void DeleteAtIndex(int index) {
    if (index == 0) {
        DeleteAtHead();
        return;
    }
    SingleNode* cur = this->head;
    for (int i = 0; i < index - 1 && cur->next != nullptr; i++) {
        cur = cur->next;
    }
    if (index < 0 || cur->next == nullptr) {
        return;
    }
    SingleNode* next;
    next = cur->next;
    cur->next = cur->next->next;
    delete next;
}
```
#### 删除所有值为 $val$ 的节点
由于包含值 $val$ 的节点可能出现在头部节点处，删除头部节点会导致头指针的改变，发生这种情况的次数是不确定的，如果对每个节点都进行判断就太过繁琐，更简洁的办法是，先假设不需要删除头部节点，直接从第 $2$ 个节点开始处理，到最后再单独判断头部节点是否需要被删除

具体来说，使用 $cur$ 指针来标记每个节点，$cur$ 指针的初值就是头指针的值，判断 $cur\to next$ 所指节点元素是否等于 $val$，只要满足条件就一直进行删除操作，当条件不满足时，将 $cur$ 指针后移，如果 $cur$ 指针指向尾部节点，即 $cur\to next=nullptr$ 时，后面不再有节点可以被删除，停止循环

最后判断头部节点是否满足删除的条件，如果需要删除，就执行在头部删除节点的操作
```cpp
void DeleteVal(int val) {
    SingleNode* cur = this->head;
    while (cur->next != nullptr) {
        if (cur->next->data == val) {
            SingleNode* next;
            next = cur->next;
            cur->next = cur->next->next;
            delete next;
        } else {
            cur = cur->next;
        }
    }
    if (this->head->data == val) {
        DeleteAtHead();
    }
}
```
#### 反转单链表
例如对于单链表 $1\to 2\to 3$，将其变换为 $3\to 2\to 1$ 的操作称为反转单链表，即每个节点都要将原本指向下一个节点的指针改为指向上一个节点

我们需要知道当前节点上一个节点的地址，才能将当前节点指向其上一个节点，使用一个指针 $pre$ 来保存这个地址，特别地，当前节点为第一个节点时，它没有上一个节点，所以 $pre$ 指针的初值为 $nullptr$

此外，在改变当前节点的 $next$ 指针的过程中，当前节点下一个节点的地址会丢失，因此在这个操作之前，需要使用另一个指针 $next$ 来保存当前节点下一个节点的地址

在循环一开始就会对 $next$ 指针进行赋值操作，所以它实际上不需要设置初值，默认初始化为空指针即可

完成对当前节点的修改后，继续对下一个节点执行相同的操作，下一个节点的上一个节点就是当前节点，因此先将 $pre$ 指针更新为当前节点的地址，然后将 $cur$ 指针更新为下一个节点的地址，该地址就是 $next$ 指针保存的地址

从头部节点开始，循环对每个节点执行上述操作，循环结束时 $cur$ 指向原先尾部节点的后方，$pre$ 指针指向尾部节点，该节点就是反转后的头部节点，因此最后头指针更新为 $pre$ 指针保存的地址，就完成了对整个单链表的反转操作
```cpp
void Reverse() {
    SingleNode* pre = nullptr;
    SingleNode* next = nullptr;
    SingleNode* cur = this->head;
    while (cur != nullptr) {
        next = cur->next;
        cur->next = pre;
        pre = cur;
        cur = next;
    }
    this->head = pre;
}
```
#### 单链表和单向循环链表之间的转换
在单链表的基础上，将尾部节点的 $next$ 指针指向单链表的第一个节点，形成一个头尾相连的环，就构成了一个单向循环链表，单向循环链表是否添加头节点要根据实际情况选择，如果需要添加头节点，应该先在单链表中添加头节点，再将其转换为循环链表

将单向循环链表还原为单链表时，只需要将尾部节点的 $next$ 指针修改为空指针即可

如果单链表为空，且没有头节点，则无法进行转换 ( 或说不需要进行转换 )

为了方便转换，可以在单链表中添加一个名为 $isCircular$ 的 $bool$ 类型变量，用于记录当前单链表是否为循环链表，默认值为 $false$
```cpp
void Transform() {
    if (this->head == nullptr) {
        return;
    }
    SingleNode* cur = this->head;
    if (!isCircular) {
        while (cur->next != nullptr) {
            cur = cur->next;
        }
        cur->next = this->head;
        isCircular = true;
    }
    if (isCircular) {
        while (cur->next != this->head) {
            cur = cur->next;
        }
        cur->next = nullptr;
        isCircular = false;
    }
}
```
#### 打印单向循环链表
打印不含头节点的单向循环链表时，$cur$ 指针一开始指向第一个节点，即 $cur=head$，如果希望打印完最后一个节点再停止循环的话，循环条件就是 $cur\ne head$，这与初始条件冲突，因此只能改为 $cur\to next\ne head$，这样会导致最后一个节点不能在循环中被打印，要在循环结束后单独打印这个节点

如果是含头节点的单向循环链表，一开始令 $cur=head\to next$，并把循环条件设为 $cur\ne head$，就不会出现上述问题

可以在单链表的 $Print()$ 成员函数最前面添加下列代码，用于单向循环链表的打印
```cpp
if (this->head == nullptr) {
    return;
}
if (isCircular) {
    SingleNode* cur = this->head;
    while (cur->next != this->head) {
        std::cout << cur->data << ' ';
        cur = cur->next;
    }
    std::cout << cur->data << '\n';
    return;
}
```
### 使用标准库单链表容器
标准库实现了单链表容器 $std::forward\_list$，该容器定义在 $<forward\_list>$ 头文件中，它接受一个模板参数，表示单链表中存储元素的类型

创建存储 $int$ 类型数据元素的空单链表，使用 $empty()$ 成员函数可以判断该单链表是否为空
```cpp
std::forward_list<int> list1;
std::cout << (list1.empty() ? "empty\n" : "not empty\n");
// 输出 empty
```
使用统一初始化创建单链表，并用 $front()$ 成员函数或 $begin()$ 迭代器获取第一个元素，其中 $begin()$ 迭代器代表单链表的头指针，它只支持 $++$ 运算符，不支持加减运算，$++$ 运算符代表移动到下一个元素
```cpp
std::forward_list<int> list {4, 8, 9, 5, 3, 2};
std::cout << list.front() << '\n';
// 输出 4
auto cur = list.begin();
std::cout << *cur << '\n';
// 输出 4
cur++;// 相当于 cur = cur->next
std::cout << *cur << '\n';
// 输出 8
// std::cout << *(list.begin() + 1) << '\n';
// 编译错误
``` 
利用迭代器打印所有元素
```cpp
void Print(const std::forward_list<int>& list) {
    for (auto cur = list.begin(); cur != list.end(); cur++) {
        std::cout << *cur << ' ';
    }
    std::cout << '\n';
}
```
也可以使用范围 $for$ 循环打印所有元素
```cpp
void Print(const std::forward_list<int>& list) {
    for (const auto& e : list) {
        std::cout << e << ' ';
    }
    std::cout << '\n';
}
```
在头部、尾部或特定位置 $index$ 处插入元素均使用 $insert\_after()$ 成员函数，该函数可以处理空链表

在头部插入时，使用 $before\_begin()$ 迭代器

在尾部插入时，使用 $std::distance(before\_begin(), end())-1$ 获取 $before\_begin()$ 迭代器与尾部元素迭代器之间的距离，并保存到变量 $shift$ 中，然后使用 $std::next(before\_begin(), shift)$ 获取尾部元素的迭代器，$std::distance()$ 和 $std::next()$ 函数都定义在 $<iterator>$ 头文件中

在特定位置 $index$ 处插入时，使用 $std::next(before\_begin(), index)$ 获取 $index-1$ 位置的迭代器，$index$ 的取值必须满足 $0\le index\le$ 单链表长度 ( 即 $std::distance(begin(), end())$ )，否则行为未定义
```cpp
std::forward_list<int> list;
list.insert_after(list.before_begin(), 40);
Print(list);
// 输出 40

int shift = std::distance(list.before_begin(), list.end()) - 1;
list.insert_after(std::next(list.before_begin(), shift), 80);
Print(list);
// 输出 40 80

int index = 2;
list.insert_after(std::next(list.before_begin(), index), 120);
Print(list);
// 输出 40 80 120
```
有单独针对头部插入元素的成员函数 $push\_front()$，该函数可以处理空链表
```cpp
std::forward_list<int> list;
list.push_front(10);
Print(list);
// 输出 10
```
在头部、尾部或特定位置 $index$ 处删除元素，均使用 $erase\_after()$ 成员函数，删除前必须保证该位置有元素，否则行为未定义

在头部删除时，使用 $before\_begin()$ 迭代器，单链表不能为空，否则行为未定义

在尾部删除时，使用 $std::distance(before\_begin(), end())-2$ 获取 $before\_begin()$ 迭代器与尾部元素前一个元素的迭代器之间的距离，并保存到变量 $shift$ 中，然后使用 $std::next(before\_begin(), shift)$ 获取尾部元素前一个元素的迭代器，单链表不能为空，否则行为未定义

在特定位置 $index$ 处删除时，使用 $std::next(before\_begin(), index)$ 获取 $index-1$ 位置的迭代器，$index$ 的取值必须满足 $0\le index<$ 单链表长度 ( 即 $std::distance(begin(), end())-1$ )，否则行为未定义
```cpp
std::forward_list<int> list {3, 9, 2, 5};
list.erase_after(list.before_begin());
Print(list);
// 输出 9 2 5

int shift = std::distance(list.before_begin(), list.end()) - 2;
list.erase_after(std::next(list.before_begin(), shift));
Print(list);
// 输出 9 2

int index = 1;
list.erase_after(std::next(list.before_begin(), index));
Print(list);
// 输出 9
```
有单独针对头部删除元素的成员函数 $pop\_front()$，使用时必须保证单链表不为空，否则行为未定义
```cpp
std::forward_list<int> list {3, 8};
list.pop_front();
Print(list);
// 输出 8
```
删除所有等于指定值 $val$ 的元素，使用 $remove()$ 成员函数，该函数可以处理空链表
```cpp
std::forward_list<int> list {4, 8, 3, 5, 3, 2};
int val = 3;
list.remove(val);
Print(list);
// 输出 4 8 5 2
```
去除连续的重复元素，使用 $unique()$ 成员函数，该函数可以处理空链表
```cpp
std::forward_list<int> list {1, 1, 1, 3, 1, 1, 2, 2, 8};
list.unique();
Print(list);
// 输出 1 3 1 2 8
``` 
反转单链表，使用 $reverse()$ 成员函数，该函数可以处理空链表
```cpp
std::forward_list<int> list {4, 8, 9, 5, 3, 2};
list.reverse();
Print(list);
// 输出 2 3 5 9 8 4
```
对单链表元素进行排序，使用 $sort()$ 成员函数，该函数可以处理空链表

$sort()$ 成员函数提供的排序是稳定排序，默认升序排序，并且也可以像定义在 $<algorithm>$ 头文件中的 $std::sort()$ 函数一样自定义排序规则，但不能直接使用 $std::sort()$ 函数，因为 $std::forward\_list$ 容器的迭代器不支持随机访问 
```cpp
std::forward_list<int> list {4, 8, 9, 5, 3, 2};
list.sort();
Print(list);
// 输出 2 3 4 5 8 9
list.sort(std::greater<int>());
Print(list);
// 输出 9 8 5 4 3 2
```
### 数组模拟单链表
### 双链表的概念和定义
双链表，即双向链表，由若干个双链表节点组成，每个节点中包含数据元素和 $2$ 个指针，一个保存直接后继的地址，另一个保存直接前驱的地址，这样一来，通过当前节点既可以访问上一个节点，也可以访问下一个节点

由此，我们可以定义一个最基本的双链表节点，其中第一个构造函数用于创建空节点，第二个构造函数用于创建含数据元素的节点
```cpp
struct DoubleNode {
    int data;
    DoubleNode* pre;
    DoubleNode* next;

    DoubleNode() : data(), pre(), next() {}
    DoubleNode(int e) : data(e), pre(), next() {}
};
```
析构函数可选，用于当节点内存被释放时打印出被删除的节点
```cpp
~DoubleNode() { std::cout << "Node " << this->data << " deleted\n"; }
```
双链表和单链表一样，也有头指针、头节点、首元节点的概念，并且由于双链表能够从当前节点向前访问，双链表还会设置一个尾指针，即指向尾部节点的指针，使得我们可以直接对双链表的尾部进行操作

此外，双链表通常还会设置 $size$ 变量，用于保存双链表内元素的个数，当 $size=0$ 时，表示双链表为空

由此，我们可以定义一个双链表类，其中构造函数用于创建不带头节点的空链表
```cpp
struct DoubleList {
    std::size_t size;
    DoubleNode* head;
    DoubleNode* tail;

    DoubleList() : size(), head(), tail() {}
};
```
### 双链表的其他成员函数
下列成员函数默认处理不含头节点的双链表，处理含头节点的双链表时需要进行一定的修改
#### 打印双链表
双链表含有头尾指针，因此打印双链表可以分为从头至尾打印和从尾至头打印，该函数通过参数 $fromTail$ 控制打印顺序，如果从头至尾打印双链表，就从头指针开始向后遍历，如果从尾至头打印双链表，就从尾指针开始向前遍历，默认从头至尾打印每个节点的数据元素，并且每个数据元素之间用一个空格隔开

$while$ 循环的条件已经避免了对空链表的操作，不需要单独处理双链表为空的情况
```cpp
void Print(bool fromTail = false) {
    if (fromTail) {
        DoubleNode* cur = this->tail;
        while (cur != nullptr) {
            std::cout << cur->data << ' ';
            cur = cur->pre;
        }
        std::cout << '\n';
        return;
    }
    DoubleNode* cur = this->head;
    while (cur != nullptr) {
        std::cout << cur->data << ' ';
        cur = cur->next;
    }
    std::cout << '\n';
}
```
#### 在头部插入节点
在插入节点之前，首先要创建一个新的节点，将其命名为 $newNode$，完成插入操作后，要将 $size$ 变量加 $1$

当双链表为空时，将头指针和尾指针都指向新节点即可

当双链表非空时，将新节点的 $next$ 指针指向原来的第一个节点，同时将原来的第一个节点的 $pre$ 指针指向新节点，最后更新头指针，尾指针保持不变
```cpp
void InsertAtHead(int data) {
    DoubleNode* newNode = new DoubleNode(data);
    if (this->size == 0) {
        this->head = newNode;
        this->tail = newNode;
        this->size++;
        return;
    }
    newNode->next = this->head;
    this->head->pre = newNode;
    this->head = newNode;
    this->size++;
}
```
#### 在尾部插入节点
当双链表为空时，情况和在头部插入节点时相同

当双链表非空时，将尾部节点的 $next$ 指针指向新节点，再将新节点的 $pre$ 指针指向原来的尾部节点，最后更新尾指针，头指针保持不变

```cpp
void InsertAtTail(int data) {
    if (this->size == 0) {
        InsertAtHead(data);
        return;
    }
    DoubleNode* newNode = new DoubleNode(data);
    this->tail->next = newNode;
    newNode->pre = this->tail;
    this->tail = newNode;
    this->size++;
}
```
#### 在特定位置 $index$ 处插入节点
当 $index<0$ 或 $index>$ 双链表长度时，无法在该位置插入节点，不做任何操作

当 $index=0$ 时，情况和在头部插入节点时相同

当 $index=$ 双链表长度时，情况和在尾部插入节点时相同

当 $0<index<$ 双链表长度时，和单链表的操作不同，单链表需要找到的是 $index-1$ 位置的节点，而双链表需要找到的就是 $index$ 位置的节点，找到该位置并用 $cur$ 指针保存后，将新节点的 $next$ 指针指向 $cur$ 指针所指节点，同时新节点的 $pre$ 指针指向 $cur\to pre$ 指针所指节点，然后将 $cur\to pre\to next$ 指针指向新节点，最后将 $cur\to pre$ 指针指向新节点
```cpp
void InsertAtIndex(int index, int data) {
    if (index < 0 || index > this->size) {
        return;
    }
    if (index == 0) {
        InsertAtHead(data);
        return;
    }
    if (index == this->size) {
        InsertAtTail(data);
        return;
    }
    DoubleNode* cur = this->head;
    for (int i = 0; i < index; i++) {
        cur = cur->next;
    }
    DoubleNode* newNode = new DoubleNode(data);
    newNode->next = cur;
    newNode->pre = cur->pre;
    cur->pre->next = newNode;
    cur->pre = newNode;
    this->size++;
}
```
#### 在头部删除节点
删除节点不仅需要调整指针，还需要释放被删除节点的内存，最后要将 $size$ 变量减 $1$

当双链表为空时，不需要做任何操作

当双链表只有一个节点时，删除头部节点后，头尾指针应该同时修改为空指针

当双链表存在 $2$ 个及以上节点时，将第一个节点下一个节点的 $pre$ 指针修改为空指针，然后更新头指针到下一个节点，最后释放原来第一个节点的内存 ( 也可以先把头指针指向下一个节点，然后修改 $head\to pre$ 为空指针 )
```cpp
void DeleteAtHead() {
    if (this->size == 0) {
        return;
    }
    if (this->size == 1) {
        delete this->head;
        this->head = nullptr;
        this->tail = nullptr;
        this->size--;
        return;
    }
    DoubleNode* target = this->head;
    this->head->next->pre = nullptr;
    this->head = this->head->next;
    delete target;
    this->size--;
}
```
#### 在尾部删除节点
当双链表为空或只有一个节点时，情况和在头部删除节点时相同

当双链表存在 $2$ 个及以上节点时，将尾部节点上一个节点的 $next$ 指针修改为空指针，然后更新尾指针到上一个节点，最后释放原来尾部节点的内存 ( 也可以先把尾指针指向上一个节点，然后修改 $tail\to next$ 为空指针 )
```cpp
void DeleteAtTail() {
    if (this->size <= 1) {
        DeleteAtHead();
        return;
    }
    DoubleNode* target = this->tail;
    this->tail->pre->next = nullptr;
    this->tail = this->tail->pre;
    delete target;
    this->size--;
}
```
#### 在特定位置 $index$ 处删除节点
当 $index<0$ 或 $index\ge$ 双链表长度时，无法在该位置删除节点，不做任何操作

当 $index=0$ 时，等同于在头部删除节点

当 $index=$ 双链表长度 $-1$ 时，情况和在尾部删除节点时相同

当 $0<index<$ 双链表长度 $-1$ 时，和插入节点时相同，需要使用 $cur$ 指针找到并保存 $index$ 位置的节点，将该节点下一个节点的 $pre$ 指针指向该节点的上一个节点，然后将该节点上一个节点的 $next$ 指针指向该节点的下一个节点，最后释放 $cur$ 指针所指节点的内存
```cpp
void DeleteAtIndex(int index) {
    if (index < 0 || index >= this->size) {
        return;
    }
    if (index == 0) {
        DeleteAtHead();
        return;
    }
    if (index == this->size - 1) {
        DeleteAtTail();
        return;
    }
    DoubleNode* cur = this->head;
    for (int i = 0; i < index; i++) {
        cur = cur->next;
    }
    cur->next->pre = cur->pre;
    cur->pre->next = cur->next;
    delete cur;
    this->size--;
}
```
#### 反转双链表
反转双链表的操作和反转单链表是类似的，只是双链表一次需要修改两个指针，并且要更新尾指针
```cpp
void Reverse() {
    DoubleNode* pre = nullptr;
    DoubleNode* next = nullptr;
    DoubleNode* cur = this->head;
    this->tail = this->head;
    while (cur != nullptr) {
        next = cur->next;
        cur->next = pre;
        cur->pre = next;
        pre = cur;
        cur = next;
    }
    this->head = pre;
}
```
#### 双链表和双向循环链表之间的转换
在双链表的基础上，将最后一个节点的 $next$ 指针指向第一个节点，同时将第一个节点的 $pre$ 指针指向最后一个节点，形成一个头尾相连的环，就构成了一个双向循环链表，双向循环链表是否添加头节点要根据实际情况选择，如果需要添加头节点，应该先在双链表中添加头节点，再将其转换为循环链表

将双向循环链表还原为双链表时，只需要将 $tail\to next$ 指针和 $head\to pre$ 指针都修改为空指针即可

如果双链表为空，并且没有头节点，则无法进行转换 ( 或说不需要进行转换 )

为了方便转换，可以在双链表中添加一个名为 $isCircular$ 的 $bool$ 类型变量，用于记录当前双链表是否为循环链表，默认值为 $false$
```cpp
void Transform() {
    if (this->size == 0) {
        return;
    }
    if (!isCircular) {
        this->tail->next = this->head;
        this->head->pre = this->tail;
        isCircular = true;
    }
    if (isCircular) {
        this->tail->next = nullptr;
        this->head->pre = nullptr;
        isCircular = false;
    }
}
```
#### 打印双向循环链表
与打印单向循环链表的方式和注意点相同，双向循环链表可以从头部或尾部开始打印，可以在双链表的 $Print()$ 成员函数最前面添加下列代码，用于双向循环链表的打印
```cpp
if (this->size == 0) {
    return;
}
if (isCircular) {
    if (fromTail) {
        DoubleNode* cur = this->tail;
        while (cur->pre != this->tail) {
            std::cout << cur->data << ' ';
            cur = cur->pre;
        }
        std::cout << cur->data << '\n';
        return;
    }
    DoubleNode* cur = this->head;
    while (cur->next != this->head) {
        std::cout << cur->data << ' ';
        cur = cur->next;
    }
    std::cout << cur->data << '\n';
    return;
}
```
### 使用标准库双链表容器
标准库也实现了双链表容器 $std::list$，该容器实际上是循环双链表，而不是普通双链表，也就是说它的迭代器是循环的，该容器定义在`<list>`头文件中，它接受一个模板参数，表示双链表中存储的数据元素的类型

创建存储 $int$ 类型数据元素的空双链表，使用 $empty()$ 成员函数可以判断该双链表是否为空
```cpp
std::list<int> list1;
std::cout << (list1.empty() ? "empty\n" : "not empty\n");
// 输出 empty
```
使用统一初始化创建双链表，使用 $size()$ 成员函数可以获取双链表中的元素个数

使用 $front()$ 成员函数或 $begin()$ 迭代器，可以获取第一个元素，其中 $begin()$ 迭代器是正向迭代器，方向是从头到尾 ( 从左到右 )，代表双链表的头指针，它只支持 $++$ 和 $--$ 运算符，不支持加减运算，$++$ 运算符代表移动到右边的下一个元素，$--$ 运算符代表移动到左边的上一个元素

使用 $back()$ 成员函数或 $rbegin()$ 迭代器，可以获取最后一个元素，其中 $rbegin()$ 迭代器是反向迭代器，方向是从尾到头 ( 从右到左 )，代表双链表的尾指针，同样只支持 $++$ 和 $--$ 运算符，不支持加减运算，$++$ 运算符代表移动到左边的下一个元素，$--$ 运算符代表移动到右边的上一个元素
```cpp
std::list<int> list {3, 1, 8, 9, 2, 5};
std::cout << list.size() << '\n';
// 输出 6

std::cout << list.front() << '\n';
// 输出 3
std::cout << *list.begin() << '\n';
// 输出 3
auto cur = list.begin();
cur++; // 相当于 cur = cur->next
std::cout << *cur << '\n';
// 输出 1
cur--; // 相当于 cur = cur->pre
std::cout << *cur << '\n';
// 输出 3
// std::cout << *(list.begin() + 1);
// 编译错误

std::cout << list.back() << '\n';
// 输出 5
std::cout << *list.rbegin() << '\n';
// 输出 5
auto rcur = list.rbegin();
rcur++; // 相当于 rcur = rcur->pre
std::cout << *rcur << '\n';
// 输出 2
rcur--; // 相当于 rcur = rcur->next
std::cout << *rcur << '\n';
// 输出 5
// std::cout << *(list.rbegin() + 1);
// 编译错误
```
利用正向迭代器从头至尾打印所有元素
```cpp
void PrintFromHead(const std::list<int>& list) {
    for (auto cur = list.begin(); cur != list.end(); cur++) {
        std::cout << *cur << ' ';
    }
    std::cout << '\n';
}
```
也可以使用范围 $for$ 循环从头至尾打印所有元素
```cpp
void PrintFromHead(const std::list<int>& list) {
    for (const auto& e : list) {
        std::cout << e << ' ';
    }
    std::cout << '\n';
}
```
利用反向迭代器从尾至头打印所有元素
```cpp
void PrintFromTail(const std::list<int>& list) {
    for (auto rcur = list.rbegin(); rcur != list.rend(); rcur++) {
        std::cout << *rcur << ' ';
    }
    std::cout << '\n';
}
```
在头部、尾部或特定位置 $index$ 处插入元素，均使用 $insert()$ 成员函数，该函数可以处理空链表

在头部插入时，使用 $begin()$ 迭代器

在尾部插入时，使用 $end()$ 迭代器

在特定位置 $index$ 处插入时，使用 $std::next(begin(), index)$ 获取目标位置的迭代器，$index$ 的取值无限制，$std::next()$ 函数定义在 $<iterator>$ 头文件中

当双链表为空时，无论 $index$ 取何值，获取的都是 $begin()$ 迭代器

当双链表非空，并且 $index\ge 0$ 时，获取的是 $index\,\%\,(size()+1)$ 位置的迭代器

当双链表非空，并且 $index<0$ 时，获取的是 $size() + 1 - (-index)\,\%\,(size()+1)$ 位置的迭代器

一般来说只取 $0\le index\le size()$，其他值无实际意义
```cpp
std::list<int> list;
list.insert(list.begin(), 10);
PrintFromHead(list);
// 输出 10

list.insert(list.end(), 30);
PrintFromHead(list);
// 输出 10 30

int index = 2;
list.insert(std::next(list.begin(), index), 50);
PrintFromHead(list);
// 输出 10 30 50
```
有单独针对头部和尾部插入元素的成员函数 $push\_front()$ 和 $push\_back()$，它们都可以处理空链表
```cpp
std::list<int> list;
list.push_front(10);
PrintFromHead(list);
// 输出 10

list.push_back(100);
PrintFromHead(list);
// 输出 10 100
```
在头部、尾部或特定位置 $index$ 处删除元素，均使用 $erase()$ 成员函数，删除前必须保证该位置有元素，否则行为未定义

在头部删除时，使用 $begin()$ 迭代器，双链表不能为空，否则行为未定义

在尾部删除时，使用 $std::next(end(), -1)$ 获取尾部元素的迭代器，双链表不能为空，否则行为未定义

在特定位置 $index$ 处删除时，使用 $std::next(begin(), index)$ 获取目标位置的迭代器，双链表不能为空，$index$ 的取值无限制，但要保证 $std::next(begin(), index)\ne end()$，否则行为未定义

和插入时一样，当 $index\ge 0$ 时，获取的是 $index\,\%\,(size()+1)$ 位置的迭代器

当 $index<0$ 时，获取的是 $size() + 1 - (-index)\,\%\,(size()+1)$ 位置的迭代器

一般来说只取 $0\le index\le size() - 1$，其他值无实际意义
```cpp
std::list<int> list {1, 9, 2, 5};
list.erase(list.begin());
PrintFromHead(list);
// 输出 9 2 5

list.erase(std::next(list.end(), -1));
PrintFromHead(list);
// 输出 9 2

int index = 1;
list.erase(std::next(list.begin(), index));
PrintFromHead(list);
// 9
```
有单独针对头部和尾部删除元素的成员函数 $pop\_front()$ 和 $pop\_back()$，使用时必须保证双链表不为空，否则行为未定义
```cpp
std::list<int> list {6, 2, 9, 0};
list.pop_front();
PrintFromHead(list);
// 输出 2 9 0

list.pop_back();
PrintFromHead(list);
// 输出 2 9
```
删除所有等于指定值 $val$ 的元素，使用 $remove()$ 成员函数，该函数可以处理空链表
```cpp
std::list<int> list {3, 4, 3, 5, 3, 2};
int val = 3;
list.remove(val);
PrintFromHead(list);
// 输出 4 5 2
```
去除连续的重复元素，使用 $unique()$ 成员函数，该函数可以处理空链表
```cpp
std::list<int> list {1, 1, 1, 3, 1, 1, 2, 2, 8};
list.unique();
PrintFromHead(list);
// 输出 1 3 1 2 8
```
反转双链表，使用 $reverse()$ 成员函数，该函数可以处理空链表
```cpp
std::list<int> list {4, 8, 9, 5, 3, 2};
list.reverse();
PrintFromHead(list);
// 输出 2 3 5 9 8 4
```
对双链表元素进行排序，使用 $sort()$ 成员函数，该函数可以处理空链表

$sort()$ 成员函数提供的排序是稳定排序，默认升序排序，并且也可以像定义在 $<algorithm>$ 头文件中的 $std::sort()$ 函数一样自定义排序规则，但不能直接使用 $std::sort()$ 函数，因为 $std::list$ 容器的迭代器不支持随机访问 
```cpp
std::list<int> list {5, 2, 12, 8, 1, 9};
list.sort();
PrintFromHead(list);
// 输出 1 2 5 8 9 12
list.sort(std::greater<int>());
PrintFromHead(list);
// 输出 12 9 8 5 2 1
```
### 数组模拟双链表