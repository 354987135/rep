# 树的基本概念
大多数文档的语境下的“树”特指有根树，即将树中一个特定的顶点指定为根节点，得到的有向图，也就是说，有根树的边有方向，节点之间存在前驱和后继关系
## 空树
没有任何节点的树称为空树
## 根节点
一棵树的起始节点称为根节点，它是一棵树中唯一一个没有前驱节点的节点
## 父节点
一个节点的前驱节点称为父节点，除根节点外，任意节点都有且只有一个父节点
## 子节点
一个节点的后继节点称为子节点 ( 或孩子 )，一个节点可以没有子节点，也可以有多个子节点，没有子节点的节点称为叶节点 ( 或叶子 )，拥有共同父节点的子节点称为兄弟节点 ( 或兄弟 )
## 层次和树的高度
根节点所在层次是第 1 层，根节点的孩子所在的层次是第 2 层……依此类推，除根节点外，任意节点所在的层次等于其父节点所在的层次 +1，一棵树中节点所在层次的最大值称为这棵树的高度 ( 或深度 )
## 祖先
一个节点的父节点、父节点的父节点……依此类推，一直向上，直到根节点，都称为该节点的祖先
## 后代
一个节点的子节点、子节点的子节点……依此类推，一直向下，直到叶节点，都称为该节点的后代
## 路径
从一个节点出发，到达它的某个后代需要经过若干条边，这些边连成的线称为路径，路径上边的数量称为路径长度，路径长度 = 路径上经过的节点数量 -1
## 子树
在树中任取一个节点作为根节点，该节点和它的所有后代可以构成一棵树，这棵树就称为原树的子树
## 节点的度
节点的子树数量称为节点的度，一棵树中节点的度的最大值称为这棵树的度
## 森林
若干棵互不相交的树组成的集合称为森林
# 树的存储方式
根据树的基本概念可以知道，树的节点有明确的前驱和后继关系，因此通常使用链表进行存储

每个节点可以有多个后继节点，但至多只能有一个前驱节点，根据节点中存储信息的不同，可以分出不同的方法来表示树
## 表示树的常用方法
### 双亲表示法
每个节点只保存数据和其父节点的信息，不保存其子节点的信息

这种表示方法的便于寻找节点的祖先，但不便于寻找节点的后代
```cpp
template <typename T>
struct TreeNode {
    T data;
    TreeNode<T>* parent;
};
```
### 孩子表示法
每个节点只保存数据和其所有子节点的信息，不保存父节点的信息

这种表示方法便于寻找节点的后代，但不便于寻找节点的祖先
```cpp
template <typename T>
struct TreeNode {
    T data;
    std::vector<TreeNode<T>*> chilren;
};
```
### 双亲孩子表示法
结合双亲表示法和孩子表示法，每个节点中保存其父节点的信息和所有子节点的信息

这种表示方法既有双亲表示法的优点，又有孩子表示法的优点
```cpp
template <typename T>
struct TreeNode {
    T data;
    TreeNode<T>* parent;
    std::vector<TreeNode<T>*> chilren;
};
```
### 孩子兄弟表示法
每个节点只保存其第一个子节点和第一个兄弟的信息

该表示法用于将一棵树转换为二叉树
```cpp
template <typename T>
struct TreeNode {
    T data;
    TreeNode<T>* firstChild;
    TreeNode<T>* firstSibling;
};
```
## 使用数组模拟链表进行存储
如果使用整数序号来代表每个节点，那么我们可以借助数组的下标来保存节点，数组的对应下标位置则保存该节点的数据元素和双亲、孩子的序号，从而实现树的存储，利用下标访问就可以模拟类似链表指针的跳转行为

下列代码使用数组存储双亲表示法表示的树
```cpp
struct TreeNode {
    int data;
    int parent;
};

std::vector<TreeNode> tree(4);
tree[1] = {20, -1};
tree[2] = {30, 1};
tree[3] = {40, 1};
```
下列代码使用数组存储孩子表示法表示的树
```cpp
struct TreeNode {
    int data;
    std::vector<int> children;
};

std::vector<TreeNode> tree(5);
tree[1] = {10, {2, 3, 4}};
tree[2] = {20, {5, 6}};
tree[4] = {40, {7}};
```
# 二叉树
## 二叉树的基本概念
任意节点都至多有 2 棵子树的树称为二叉树，这 2 棵子树存在左右次序关系，分别称为左子树和右子树

二叉树的基本形态有 5 种：没有任何节点的空二叉树、仅有根节点的二叉树、左子树为空的二叉树、右子树为空的二叉树、左右子树都不为空的二叉树
### 满二叉树
如果一棵二叉树高度为 $h$，节点数为 $2^{h}-1$，则称该二叉树为满二叉树
### 完全二叉树
如果一棵二叉树不是满二叉树，但只有最后一层没有填满节点，并且最后一层的节点都尽量靠左排列，则称该二叉树称为完全二叉树，满二叉树都是完全二叉树
## 二叉树的存储
### 使用链表存储二叉树
二叉树通常使用孩子表示法进行存储，每个节点需要包含一个数据元素、一个指向左孩子的指针、一个指向右孩子的指针，这种结构叫做二叉链表
```cpp
template<typename T>
struct BinaryTreeNode {
    T data;
    BinaryTreeNode<T>* left;
    BinaryTreeNode<T>* right;

    // 创建二叉树节点，数据元素的值为 e
    BinaryTreeNode(T e) : data(e), left(), right() {}
};
```
可以额外定义一个二叉树类，将根节点和操作二叉树的函数封装在一起
```cpp
template<typename T>
struct BinaryTree {
    BinaryTreeNode<T>* root;

    // 创建空二叉树
    BinaryTree() : root() {}
};
```
利用上述定义创建一棵高度为 3 的满二叉树 1234567
```cpp
BinaryTree tree;
tree.root = new BinaryTreeNode(1);
tree.root->left = new BinaryTreeNode(2);
tree.root->right = new BinaryTreeNode(3);
tree.root->left->left = new BinaryTreeNode(4);
tree.root->left->right = new BinaryTreeNode(5);
tree.root->right->left = new BinaryTreeNode(6);
tree.root->right->right = new BinaryTreeNode(7);
```
### 使用数组存储二叉树
二叉树每个节点的子节点数量至多为 2 个，因此我们可以使用确定的规则将二叉树的每个节点存储在数组中，对于高度为 $h$ 的二叉树，数组长度应该设为 $2^h$，使用整数序号 $i$ 标记二叉树 $1\sim h$ 层的每个节点 ( 包括空节点 )，并存储到数组的对应下标 $i$ 处

具体来说，$i=1$ 处存储二叉树的根节点，当 $i>1$ 时，节点 $i$ 的父节点存储在 $\lfloor \frac{i}{2}\rfloor$ 处，左孩子存储在 $2i$ 处，右孩子存储在 $2i+1$ 处
## 二叉树的重要性质
- 若二叉树高度为 $h$，则该树至多有 $2^{h}-1$ 个节点，第 $i$ 层上至多有 $2^{i-1}$ 个节点

- 若一棵非空二叉树有 $n$ 个节点，则这棵树中的边数 $e=n-1$

- 若一棵使用二叉链表存储的二叉树有 $n$ 个节点，则该树中的空指针总数为 $n+1$ 个 

- 若一棵二叉树有 $l$ 个叶节点，有 $n_2$ 个度为 $2$ 的节点，则存在数量关系 $l=n_2+1$

- 若一棵完全二叉树有 $n$ 个节点，则这棵树中的叶节点数 $l=\lfloor \frac{n+1}{2}\rfloor$，高度 $h=\lfloor log_2n \rfloor+1$
## 二叉树的遍历 
我们不能随机访问二叉树的节点，而是需要从根节点开始遍历二叉树寻找到目标节点后才能进行访问，二叉树有两种基本遍历方式，第一种是深度优先遍历 ( depth first search, dfs )，第二种是宽度优先遍历 ( breadth first search, bfs )

进行深度优先遍历时，按照根节点被访问的顺序的不同，可以分为 3 种情况：先序遍历 ( 或前序遍历 )、中序遍历、后序遍历，而宽度优先遍历只有 1 种情况，称为层序遍历

具体来说，先序遍历即对于每棵子树按照下列顺序访问节点：根节点 -> 左孩子 -> 右孩子；中序遍历即对于每棵子树按照下列顺序访问节点：左孩子 -> 根节点 -> 右孩子；后序遍历，对于每棵子树按照下列顺序访问节点：左孩子 -> 右孩子 -> 根节点；层序遍历，按照从上至下，从左至右的顺序一层一层访问所有根节点
### 深度优先遍历 ( 递归实现 )
深度优先遍历的递归实现很简单，即从根节点开始，如果发现节点为空，说明是空二叉树，直接结束遍历，否则就对根节点的左子树和右子树分别进行递归：
```cpp
void dfs(BinaryTreeNode* root) {
    if (root == nullptr) {
        return;
    }
    dfs(root->left);
    dfs(root->right);
}
```
假设现在对满二叉树 1 2 3 4 5 6 7 进行深度优先遍历，那么具体过程如下：

该函数从根节点 1 开始，递归进入左子树 2，再递归进入左子树 4，继续递归进入左子树，发现左子树为空，则结束对该子树的遍历，也就是回溯至上一层，此时会第二次经过节点 4，然后递归进入右子树，发现右子树为空，则结束对该子树的遍历，再次回溯至上一层并第三次经过节点 4，至此左子树 4 遍历完毕，回溯至上一层并第二次经过节点 2，然后递归进入右子树 5，子树 5 的情况和子树 4 一样，总共三次经过节点 5，此时右子树 5 也遍历完毕，回溯至节点 2 处，左子树 2 也遍历完毕，因此再向上一层回溯，第二次经过节点 1，之后递归进入右子树 3，后面的过程和子树 2 相同，最终我们可以得到节点被访问的顺序：1 2 4 4 4 2 5 5 5 2 1 3 6 6 6 3 7 7 7 3 1，这个顺序被称为递归序或 dfs 序，从中我们可以发现，每个节点都有三次可以访问的机会

在第一、第二、第三次经过节点时访问节点，访问的顺序就分别是先序 ( 1 2 4 5 3 6 7 )、中序 ( 4 2 5 1 6 3 7 )、后序 ( 4 5 2 6 7 3 1 ) 遍历的顺序

因此，只需要将访问节点的代码放在上列函数中指定的位置，就可以得到这三种遍历方式的递归实现代码，下列代码中我们使用打印节点来表示对节点的访问
```cpp
// 先序遍历
void PreOrder(BinaryTreeNode* root) {
    if (root == nullptr) {
        return;
    }
    std::cout << root->data << ' ';
    PreOrder(root->left);
    PreOrder(root->right);
}
// 中序遍历
void InOrder(BinaryTreeNode* root) {
    if (root == nullptr) {
        return;
    }
    InOrder(root->left);
    std::cout << root->data << ' ';
    InOrder(root->right);
}
// 后序遍历
void PostOrder(BinaryTreeNode* root) {
    if (root == nullptr) {
        return;
    }
    PostOrder(root->left);
    PostOrder(root->right);
    std::cout << root->data << ' ';
}
```
如果要将上面的函数写成类成员函数，则应该写到节点类中，然后在二叉树类中调用：
```cpp
// BinaryTreeNode 类中
// 先序遍历
void PreOrder() {
    std::cout << this->data << ' ';
    if (this->left != nullptr) {
        this->left->PreOrder();
    }
    if (this->right != nullptr) {
        this->right->PreOrder();
    }
}
// 中序遍历
void InOrder() {
    if (this->left != nullptr) {
        this->left->InOrder();
    }
    std::cout << this->data << ' ';
    if (this->right != nullptr) {
        this->right->InOrder();
    }
}
// 后序遍历
void PostOrder() {
    if (this->left != nullptr) {
        this->left->PostOrder();
    }
    if (this->right != nullptr) {
        this->right->PostOrder();
    }
    std::cout << this->data << ' ';
}

// BinaryTree 类中
// 先序遍历
void PreOrder() {
    this->root->PreOrder();
    std::cout << '\n';
}
// 中序遍历
void InOrder() {
    this->root->InOrder();
    std::cout << '\n';
}
// 后序遍历
void PostOrder() {
    this->root->PostOrder();
    std::cout << '\n';
}
```
### 深度优先遍历 ( 非递归实现 )
利用栈将递归实现转换为循环实现
#### 先序遍历
第一步，判断二叉树是否为空，如果是空树，则不需要执行任何操作，遍历结束

第二步，创建一个栈，并将根节点入栈

第三步，当栈不为空时，循环执行下列操作：访问栈顶节点 -> 将栈顶节点出栈 -> 判断该节点的右、左孩子是否为空，如果不为空，则按右 -> 左的顺序入栈

原理：每棵子树的根节点入栈后立即出栈，再按右 -> 左的顺序入栈其子节点，最终出栈顺序即为：根 -> 左 -> 右，形成先序遍历
```cpp
void PreOrderNonRecur() {
    if (this->root == nullptr) {
        return;
    }
    std::stack<BinaryTreeNode*> s;
    s.push(this->root);
    while (!s.empty()) {
        BinaryTreeNode* cur = s.top();
        s.pop();
        std::cout << cur->data << ' ';
        if (cur->right != nullptr) {
            s.push(cur->right);
        }
        if (cur->left != nullptr) {
            s.push(cur->left);
        }
    }
    std::cout << '\n';
}
```
#### 中序遍历
第一步，判断二叉树是否为空，如果是空树，则不需要执行任何操作，遍历结束

第二步，创建一个栈，并保持栈为空

第三步，使用`cur`指针标记根节点

第四步，当栈不为空或`cur`指针不为空时，循环执行下列操作：利用`cur`指针，将所有最左侧节点依次入栈 -> 访问栈顶节点 -> 将栈顶节点出栈 -> 将`cur`移动到右子树的根节点上 -> 将右子树所有最左侧节点依次入栈

原理：最左侧节点入栈时，后入栈的节点是先入栈的节点的左孩子，并且最左侧的最后一个节点是叶节点，其左右孩子都为空，因此在出栈时会连续出栈两个节点，顺序是左 -> 根，然后`cur`指针才会转移到右子树上，最终出栈顺序即为：左 -> 根 -> 右，形成中序遍历
```cpp
void InOrderNonRecur() {
    if (this->root == nullptr) {
        return;
    }
    std::stack<BinaryTreeNode*> s;
    BinaryTreeNode* cur = this->root;
    while (!s.empty() || cur != nullptr) {
        if (cur != nullptr) {
            s.push(cur);
            cur = cur->left;
        } else {
            cur = s.top();
            s.pop();
            std::cout << cur->data << ' ';
            cur = cur->right;
        }
    }
    std::cout << '\n';
}
```
#### 后序遍历
第一步，判断二叉树是否为空，如果是空树，则不需要执行任何操作，遍历结束

第二步，创建两个栈，并将根节点放入第一个栈中，第二个栈保持为空

第三步，当第一个栈不为空时，循环执行下列操作：将第一个栈的栈顶节点出栈，并且放入第二个栈中 -> 判断该节点的左、右孩子是否为空，如果不为空，则按左 -> 右的顺序放入第一个栈中

第四步，当第二个栈不为空时，循环执行以下操作：访问栈顶节点 -> 将栈顶节点出栈，最终出栈顺序即为：左 -> 右 -> 根，形成后序遍历

原理：在第一个栈中，每棵子树的根节点入栈后立即出栈，并放入第二个栈中，再按左 -> 右的顺序入栈其子节点，那么第一个栈中子节点出栈并入第二个栈的顺序就是右 -> 左，因此第二个栈的入栈顺序就是根 -> 右 -> 左，最终出栈顺序即为：左 -> 右 -> 根，形成后序遍历
```cpp
void PostOrderNonRecur() {
    if (this->root == nullptr) {
        return;
    }
    std::stack<BinaryTreeNode*> s1, s2;
    s1.push(this->root);
    while (!s1.empty()) {
        BinaryTreeNode* cur = s1.top();
        s1.pop();
        s2.push(cur);
        if (cur->left != nullptr) {
            s1.push(cur->left);
        }
        if (cur->right != nullptr) {
            s1.push(cur->right);
        }
    }
    while (!s2.empty()) {
        BinaryTreeNode* cur = s2.top();
        std::cout << cur->data << ' ';
        s2.pop();
    }
    std::cout << '\n';
}
```
### 宽度优先遍历
宽度优先遍历即层序遍历，通常使用队列来实现

第一步，判断二叉树是否为空，如果是空树，则不需要执行任何操作，遍历结束

第二步，创建一个队列，并将根节点入队

第三步，当队列不为空时，循环执行下列操作：访问队首节点 -> 将队首节点出队 -> 依次将队首节点的左、右孩子入队

原理：队列具有先进先出的特性，入队的顺序就是出队的顺序
```cpp
void LevelOrder() {
    if (this->root == nullptr) {
        return;
    }
    std::queue<BinaryTreeNode*> q;
    q.push(this->root);
    while (!q.empty()) {
        BinaryTreeNode* cur = q.front();
        q.pop();
        std::cout << cur->data << ' ';
        if (cur->left != nullptr) {
            q.push(cur->left);
        }
        if (cur->right != nullptr) {
            q.push(cur->right);
        }
    }
    std::cout << '\n';
}
```
基本的层序遍历虽然的确按照层的顺序访问了每一个节点，但实际处理时并没有按层分组处理，我们可以在处理每一层之前保存当前队列长度，从而实现分组处理的功能：
```cpp
void bfs(BinaryTreeNode* root) {
    if (root == nullptr) {
        return;
    }
    std::queue<BinaryTreeNode*> q;
    q.push(root);
    while (!q.empty()) {
        int len = q.size(); 
        for (int i = 0; i < len; ++i) {
            BinaryTreeNode* cur = q.front();
            q.pop();
            std::cout << cur->data << ' ';
            if (cur->left != nullptr) {
                q.push(cur->left);
            }
            if (cur->right != nullptr) {
                q.push(cur->right);
            }
        }
        std::cout << '\n';
    }
}
```
### 根据遍历序列创建二叉树
根据先序、后序、层序遍历序列中的任意一种序列，我们能够确定二叉树的根节点，根据中序遍历序列和根节点信息，我们能够确定二叉树左右子树的构成情况，因此，给出一棵二叉树先序、后序、层序中的任意一种遍历序列，再给出中序遍历序列，就可以唯一确定这棵二叉树，从而还原出这棵二叉树的具体形状

以不同序列组合创建二叉树时，对序列的处理方式有所不同，但不论采用什么序列组合，给二叉树添加节点时都必须从根节点开始，即先序遍历的顺序：先添加根节点，再添加左、右子树

下面记先序序列为`pre`，后序序列为`post`，层序序列为`level`，中序序列为`in`，它们都是`std::string`类型
#### 给定先序序列和中序序列
第一步，`pre`的首个字符一定是当前子树的根节点，判断`pre`是否为空，如果为空，则没有节点可以添加，立即返回，如果不为空，则利用`pre[0]`创建新节点

第二步，在`in`中找到该字符，该字符的左、右侧子串分别是左、右子树的中序序列，记为`l_in`，`r_in`

第三步，在一棵树中，左、右子树的先序序列和中序序列长度相同、包含的节点相同，并且都是连续子串，利用这些性质，我们可以从`pre`中分离出左、右子树的先序序列，其中，靠近根节点的字符串是左子树的先序序列，记为`l_pre`，远离根节点的字符串是右子树的先序序列，记为`r_pre`

第四步，通过`l_pre`，`l_in`在左子树上递归执行上述操作
，通过`r_pre`，`r_in`在右子树上递归执行上述操作
```cpp
void Create(BinaryTreeNode*& root, const std::string& pre, const std::string& in) {
    if (pre.empty()) {
        return;
    }

    root = new BinaryTreeNode(pre[0]);
    int i = in.find(pre[0]);
    std::string l_in = in.substr(0, i);
    std::string l_pre = pre.substr(1, i);
    std::string r_in = in.substr(i + 1);
    std::string r_pre = pre.substr(i + 1);

    Create(root, l_pre, l_in);
    Create(root, r_pre, r_in);
}
```
#### 给定后序序列和中序序列
第一步，`post`的最后一个字符一定是当前子树的根节点，判断`post`是否为空，如果为空，则没有节点可以添加，立即返回，如果不为空，则利用`post.back()`创建新节点

第二步，在`in`中找到该字符，该字符的左、右侧子串分别是左、右子树的中序序列，记为`l_in`，`r_in`

第三步，在一棵树中，左、右子树的后序序列和中序序列长度相同、包含的节点相同，并且都是连续子串，利用这些性质，我们可以从`post`中分离出左、右子树的后序序列，其中，远离根节点的字符串是左子树的后序序列，记为`l_post`，靠近根节点的字符串是右子树的后序序列，记为`r_post`

第四步，通过`l_post`，`l_in`在左子树上递归执行上述操作
，通过`r_post`，`r_in`在右子树上递归执行上述操作
```cpp
void Create(BinaryTreeNode*& root, const std::string& post, const std::string& in) {
    if (post.empty()) {
        return;
    }

    root = new BinaryTreeNode(post.back());
    int i = in.find(post.back());
    std::string l_in = in.substr(0, i);
    std::string l_post = post.substr(0, i);
    std::string r_in = in.substr(i + 1);
    std::string r_post = post.substr(i, r_in.size());

    Create(root, l_post, l_in);
    Create(root, r_post, r_in);
}
```
#### 给定层序序列和中序序列
第一步，`level`的第一个字符一定是当前子树的根节点，判断`level`是否为空，如果为空，则没有节点可以添加，立即返回，如果不为空，则利用`level[0]`创建新节点

第二步，在`in`中找到该字符，该字符的左、右侧子串分别是左、右子树的中序序列，记为`l_in`，`r_in`

第三步，在一棵树中，左、右子树的层序序列和中序序列长度相同、包含的节点相同，但不是连续子串，利用这些性质，我们可以从`level`中分离出左、右子树的层序序列，其中，按从左到右的顺序，从`level`中取出在`l_in`中出现的所有字符，这些字符组成的字符串是左子树的层序序列，记为`l_level`，按从左到右的顺序，从`level`中取出在`r_in`中出现的所有字符，这些字符组成的字符串是右子树的层序序列，记为`r_level`

第四步，通过`l_level`，`l_in`在左子树上递归执行上述操作
，通过`r_level`，`r_in`在右子树上递归执行上述操作
```cpp
std::string GetLevel(const std::string& level, const std::string& in) {
    std::string ans;
    for (int i = 0; i < level.size(); ++i) {
        if (in.find(level[i]) != -1) {
            ans += level[i];
        }
    }
    return ans;
}

void Create(BinaryTreeNode*& root, const std::string& level, const std::string& in) {
    if (level.empty()) {
        return;
    }

    root = new BinaryTreeNode(level[0]);
    int i = in.find(level[0]);
    std::string l_in  = in.substr(0, i);
    std::string l_level = GetLevel(level, l_in);
    std::string r_in  = in.substr(i + 1);
    std::string r_level = GetLevel(level, r_in);

    Create(root, l_level, l_in);
    Create(root, r_level, r_in);
}
```
# 树和森林
## 普通树的遍历
普通树因为每个节点子树的数量不确定，因此不存在中序遍历，只存在先序、后序遍历、层序遍历，具体过程和二叉树的遍历是类似的

现在将普通树定义如下
```cpp
template<typename T>
struct TreeNode {
    T data;
    std::vector<TreeNode<T>*> children;

    // 创建树节点，数据元素的值为 e
    TreeNode(T e) : data(e) {}
};

template<typename T>
struct Tree {
    TreeNode<T>* root;

    // 创建空树
    Tree() : root() {}
};
```
创建一棵普通树，根节点为 4，4 的孩子有 7 8 9，7 的孩子有 1 2 3
```cpp
Tree<int> tree;
tree.root = new TreeNode(4);
tree.root->children.push_back(new TreeNode(7));
tree.root->children.push_back(new TreeNode(8));
tree.root->children.push_back(new TreeNode(9));
tree.root->children[0]->children.push_back(new TreeNode(1));
tree.root->children[0]->children.push_back(new TreeNode(2));
tree.root->children[0]->children.push_back(new TreeNode(3));
```
使用先序、后序、层序遍历该树的代码如下：
```cpp
// 先序遍历
template<typename T>
void PreOrder(TreeNode<T>* root) {
    if (root == nullptr) {
        return;
    }
    std::cout << root->data << ' ';
    for (int i = 0; i < root->children.size(); ++i) {
        PreOrder(root->children[i]);
    }
}
// 后序遍历
template<typename T>
void PostOrder(TreeNode<T>* root) {
    if (root == nullptr) {
        return;
    }
    for (int i = 0; i < root->children.size(); ++i) {
        PostOrder(root->children[i]);
    }
    std::cout << root->data << ' ';
}
// 层序遍历
template<typename T>
void LevelOrder(TreeNode<T>* root) {
    if (root == nullptr) {
        return;
    }
    std::queue<TreeNode<T>*> q;
    q.push(root);
    while (!q.empty()) {
        TreeNode<T>* cur = q.front();
        q.pop();
        std::cout << cur->data << ' ';
        for (int i = 0; i < cur->children.size(); ++i) {
            q.push(cur->children[i]);
        }
    }
    std::cout << '\n';
}
```
## 表达式树
## 哈夫曼树
## 堆
### 堆的基本概念
堆是以数组形式存储的、满足一定要求的完全二叉树

如果一棵完全二叉树任意一个节点的数据元素都不大于其父节点的数据元素，则它是一个大根堆 ( max heap )，根节点存储的是整棵树中最大的数据元素，反过来，如果任意一个节点的数据元素都不小于其父节点的数据元素，则它是一个小根堆 ( min heap )，根节点存储的是整棵树中最小的数据元素，默认情况下，堆都是大根堆

堆的STL相关算法
```cpp
std::make_heap(begin, end);
std::push_heap(begin, end);
std::pop_heap(begin, end);
```
## 优先队列
## 字典树
Trie树
## 二叉搜索树
## 判断二叉树性质
### 判断满二叉树
### 判断完全二叉树
### 判断搜索二叉树
### 判断平衡二叉树



### 并查集
### 平衡二叉树（AVL树）
红黑树（特化的 AVL树）
### 哈希表(散列表)、有序表(跳表)和关联容器、B树
set、map、unordered_set、unordered_map，multiset、multimap、unordered_multiset、unordered_multimap

`count()`成员函数，返回整数值 0 或 1，可以用于判断是否存在某元素

