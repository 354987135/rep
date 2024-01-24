### 图的基本概念
### 图的存储
邻接矩阵（稠密图）、邻接表存储（稀疏图）
### 图的遍历
bfs，dfs，bfs最短路，多源bfs，欧拉回路（一笔画问题）
### 最短路径算法
迪杰斯特拉算法，弗洛伊德算法，SPFA算法
### 最小生成树
prim算法，kruskal算法


## A* 寻路算法
```cpp
void bfs(int v, const vector<vector<int>>& g, vector<bool>& vis)
{
    queue<int> q;
    vis[v - 1] = true;
    q.push(v);
    while(!q.empty())
    {
        int cv = q.front();
        cout << cv;
        q.pop();
        for (int i = 0; i < g[v - 1].size(); ++i)
        {
            if(g[v - 1][i] && !vis[g[v - 1][i] - 1])
            {
                vis[g[v - 1][i] - 1] = true;
                q.push(i);
            }
        }
    }
}

void dfs(int sv, int fv, int& cnt, const vector<vector<int>>& g, vector<int>& path, vector<bool>& vis)
{
    if(sv == fv)
    {
        ++cnt;
        for (int v : path)
        {
            cout << v << " ";
        }
        cout << fv << " \n";
        return;
    }
    vis[sv - 1] = true;
    path.push_back(sv);
    for (int i = 0; i < g[sv - 1].size(); ++i)
    {
        if (!vis[g[sv - 1][i] - 1])
            dfs(g[sv - 1][i], fv, cnt, g, path, vis);
    }
    vis[sv - 1] = false;
    path.pop_back();
}

void dfs(int v, const vector<vector<int>>& g, vector<bool>& vis, const string& vList = "")
{
    vis[v - 1] = true;
    for (int i = 0; i < g[v - 1].size(); ++i)
    {
        if(!vis[g[v - 1][i] - 1])
            dfs(g[v - 1][i], g, vis, vList);
    }
}

void dfs(int v)
{
    vis[v - 1] = true;
    cout << v[v - 1];
    for (int i = 0; i < 8; ++i)
    {
        if (g[v - 1][i])
            if (!vis[i])
                dfs(i + 1);
    }
}


struct Edge
{
    int y;
    int weight;

    Edge(int a, int b) : y(a), weight(b) {}
};

int main()
{
    int n, m;
    cin >> n >> m;
    vector<vector<Edge>> g(n);
    for (int i = 0; i < m; ++i)
    {
        int x, y, z;
        cin >> x >> y >> z;
        g[x - 1].push_back(Edge(y, z));
        g[y - 1].push_back(Edge(x, z));
    }
    for (int i = 0; i < n; ++i)
    {
        if (!g[i].empty())
        {
            int max = g[i][0].weight;
            for (int j = 0; j < g[i].size(); ++j)
            {
                max = max > g[i][j].weight ? max : g[i][j].weight;
            }
            cout << max << " ";
        }
        else
            cout << "-inf ";
    }    
}
```