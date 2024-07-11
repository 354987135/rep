```cpp
void QuickSort(vector<int>& arr, int l, int r) { // 0, size - 1
    // 选定最右元素为基准值
    if (l >= r) {
        return;
    }
    int lessR = l - 1, greaterL = r, cur = l;
    while (cur < greaterL) { // P = arr[r]
        if (arr[cur] < arr[r]) {
            swap(arr[cur++], arr[++lessR]);
        } else if (arr[cur] > arr[r]) {
            swap(arr[cur], arr[--greaterL]);
        } else {
            ++cur;
        }
    }
    swap(arr[greaterL], arr[r]);
    QuickSort(arr, l, lessR);
    QuickSort(arr, greaterL + 1, r);
}
```