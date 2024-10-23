// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

contract C {
    // x 的数据存储位置是 storage。
    // 这是唯一可以省略数据位置的地方。
    uint[] x;

    // memoryArray 的数据存储位置是 memory。
    function f(uint[] memory memoryArray) public {
        x = memoryArray; // 将整个数组拷贝到 storage 中，可行
        uint[] storage y = x; // 分配一个指针，其中 y 的数据存储位置是 storage，可行
        y[7]; // 返回第 8 个元素，可行
        y.pop(); // 通过y修改x，可行
        delete x; // 清除数组，同时修改 y，可行
        // 下面的就不可行了；需要在 storage 中创建新的未命名的临时数组，/
        // 但 storage 是“静态”分配的：
        // y = memoryArray;
        // 同样， "delete y" 也是无效的，
        // 因为对引用存储对象的局部变量的赋值只能从现有的存储对象中进行。
        // 它将 “重置” 指针，但没有任何合理的位置可以指向它。
        // 更多细节见 "delete" 操作符的文档。
        // delete y;
        g(x); // 调用 g 函数，同时移交对 x 的引用
        h(x); // 调用 h 函数，同时在 memory 中创建一个独立的临时拷贝
    }

    function g(uint[] storage) internal pure {}
    function h(uint[] memory) public pure {}
}