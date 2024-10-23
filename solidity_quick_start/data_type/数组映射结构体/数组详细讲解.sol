// SPDX-License-Identifier: MIT
//pragma solidity ^0.8.21;
//contract ArrayTypes {
    //数组的声明
    //数组是一种数据结构，它是存储同类型元素的有序集合。
    //数组可以按照其长度是否可以改变分下面两种：
    //------------静态数组（static array）------------------------
    //T[arrSize] DataLocation arrName;
    //其中 arrSize 是数组的长度，
    //DataLocation 是数据位置，而 arrName 是你为这个数组起的任意名字。
    //数组是一种引用类型
    //注意：数组是一种引用类型，所以你必须在声明
    //定义的时候加上三个数据位置（data location）关键字之一：
    //storage , memory , calldata
//    uint[3] memory nftMem;
//    uint[3] storage nftStorage;
//    uint size = 2;
//    uint[size][size] memory array; // 非法，size 是变量，不能用来指定数组大小
//    // 静态数组的初始化
//    uint[3] memory nftArr; //所有元素都是0

    // 数组字面值初始化
    //必须使用uint(1000)显式地将「数组字面值」第一个元素的类型转换成uint
//    uint[3] memory nftArr = [uint(1000), 1001, 1002];
    // 编译报错，类型不匹配
//    uint[3] memory nftArr = [1000, 1001, 1002];
//    uint[3] memory nftArr = [uint(1000), 1001];  //编译错误，长度不匹配


    //--------------动态数组（dynamic array）-------------------------
    //T[] DataLocation arrName;
//    uint[] memory nftMem;
//    uint[] storage nftStorage;

    // 动态数组初始化
//    uint n = 3;
//    uint[] memory nftArr = new uint[](n);
//    uint[] storageArr = [uint(1), 2]; // 动态数组只有在storage位置才能用数组字面值初始化


    //-------态数组和动态数组是不同的类型------
//    uint[] memory dynamicArr = new uint[](2);
//    uint[2] memory staticArr = dynamicArr; // 编译错误，静态数组和动态数组是不同的类型


    // -------------下标访问----------------
    // 下标访问静态数组：
//    uint[3] memory nftArr1 = [uint(1000), 1001, 1002];
//    nftArr1[0] = 2000;
//    nftArr1[1] = 2001;
//    nftArr1[2] = 2002;

    // 下标访问动态数组：
//    uint[] memory nftArr2 = new uint[](n);
//    nftArr2[0] = 1000;
//    nftArr2[1] = 1001;
//    nftArr2[2] = 1002;

    // --------------------成员变量-----------------------------
//    uint[3] memory arr1 = [uint(1000), 1001, 1002];
//    uint[] memory arr2 = new uint[](3);
//    uint arr1Len = arr1.length; // 3
//    uint arr2Len = arr2.length; // 3

    //-----------------动态数组成员函数-----------------------
    // 只有动态数组，并且其数据位置为 storage 的时候才有成员函数。
    // 其他数组，比如静态数组和在 calldata , memory 的数组是没有成员函数的。
    // 这三个成员函数会改变数组的长度。它们分别是：
    // ● push() 在数组末尾增加一个元素，并赋予零值；数组长度加一
    // ● push(x) 将元素x添加到数组末尾；数组长度加一
    // ● pop() 从数组末尾弹出一个元素； 数组长度减一
    // 注意
    // 只有动态数组，并且其数据位置为 storage 的时候才有成员函数 push() , push(x) , pop()。
    // 注意这三个成员函数会改变数组的长度
    // push 和 pop 函数示例
//    uint[] arr; //定义在storage位置的数组
//
//    function pushPop() public {
//        // 刚开始没有任何元素
//        arr.push(); // 数组有一个元素：[0]
//        arr.push(1000); //数组有两个元素：[0, 1000]
//        arr.pop(); // 数组剩下一个元素： [0]
//    }

    // 如果我们尝试在「静态数组」或者「数据位置」不是 storage 的「动态数组」执行上面的成员函数，编译器会报错：
    // 编译错误： 静态数组使用 push ， pop 成员函数
//    uint[3] memory arr;
//    arr.push(1); //编译错误，只有 storage 上的动态数组才能调用 push 函数
//    arr.pop(); // 编译错误，只有 storage 上的动态数组才能调用 pop 函数

    // 编译错误：数据位置不在 storage 的动态数组使用 push ， pop 成员函数
//    uint[] memory arr = new uint[](3);
//    arr.push(1); //编译错误，只有 storage 上的动态数组才能调用 push 函数
//    arr.pop(); // 编译错误，只有 storage 上的动态数组才能调用 pop 函数

    // --------------Solidity 动态字节数组------------------
    //前面介绍了静态字节数组，它的长度是固定的，而且最长也就只有32字节。
    //那么如果我们希望存放超过32个字符怎么办。又或者我们希望它的长度可以变化的，可以按需增加的。
    // 这个时候我们就可以使用动态字节数组(dynamically-sized byte array)。
    // 动态字节数组其实是数组类型(array)其中的一种类型，只不过是字节数组而已。
    //我们单独抽出来介绍是想要跟静态字节数组做对比。
    //动态字节数组是引用类型
    //特别注意动态字节数组是引用类型（reference type），而静态字节数组是值类型（value type）
    //动态字节数组与静态字节数组的区别
    //动态字节数组与静态字节数组有几点区别：
    //1. 静态字节数组长度是固定的，在编译期就已经确定；而动态字节数组的长度是不固定的
    //2. 静态字节数组的长度只能是1到32字节；而动态字节数组没有长度的限制
    //3. 动态字节数组是引用类型（reference type），也就是说其变量存储的其实是数组的地址；
    //而静态字节数组是值类型（value type）
    //如果一个字节数组已经明确长度不会发生改变，而且长度小于等于32字节，那么建议使用静态字节数组。
    //会更高效，更节省Gas。其他情况才推荐使用动态字节数组。
    //动态字节数组的种类
    //Solidity有两种动态字节数组：
    //● bytes
    //● string
    //其中 bytes 类似于 bytes1[] 不过 bytes 在 memory 和 calldata 位置会更加紧凑。
    //Solidity 的存储结构里面规定了 memory 和 calldata 中的数组（比如bytes1[]）的每个元素都要占据32字节的倍数。不足32字节的，会自动 padding 到32字节。但是对于 bytes 和 string 没有这样的要求。所以 bytes 和 string 会比 bytes1[] 更加紧凑。
    //string 的内部结构基本等同于 bytes 的类型，但是它不能进行下标访问，也不能获取长度。
    //换种说法就是 string 和 bytes 内部存储结构相同，但是对外访问接口不同。

    // bytes 转 string
//    bytes memory bstr = new bytes(10);
//    string memory message = string(bstr); // 使用string()函数转换

    // string 转 bytes
//    string memory message = "hello world";
//    bytes memory bstr = bytes(message); //使用bytes()函数转换

    // ------string 不能进行下标访问，也不能获取长度---------------
//    string str = "hello world";
//    uint len = str.length; // 不合法，不能获取长度
//    bytes1 b = str[0]; // 不合法，不能进行下标访问

    // 你可以将 string 转换成 bytes 后再进行下标访问和获取长度
    //将 string 转换成 bytes 后再进行下标访问和获取长度
//    string str = "hello world";
//    uint len = bytes(str).length; // 合法
//    bytes1 b = bytes(str)[0]; // 合法
//}

// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.9.0;
// 本视频使用solidity版本v0.8.17讲解

// -------------------引用类型---------------------------
// 引用类型的值可以通过多个不同的名称进行修改。
// 这与值类型形成鲜明对比，在值类型的变量被使用时，
// 您会得到一个独立的副本。
// 正因为如此，对引用类型的处理要比对值类型的处理更加谨慎。
// 目前， 引用类型包括结构、数组和映射。如果您使用一个引用类型，
// 您必须明确地提供存储该类型的数据区域。
// memory （其寿命限于外部函数调用），
// storage （存储状态变量的位置，其寿命限于合约的寿命）
// 或 calldata （包含函数参数的特殊数据位置）。

// 改变数据位置的赋值或类型转换将总是导致自动复制操作，
// 而同一数据位置内的赋值只在某些情况下对存储类型进行复制。

// -------------------数据位置-------------------
//每个引用类型都有一个额外的属性，即 "数据位置"， 关于它的存储位置。
//有三个数据位置。 memory, storage 和 calldata。
// Calldata是一个不可修改的、非持久性的区域，用于存储函数参数，
// 其行为主要类似于memory。

// -------------------数组----------------------------------------------
// 数组可以在声明时指定长度，也可以动态调整大小。
// 一个元素类型为 T，固定长度为 k 的数组可以声明为 T[k]，
// 而动态数组声明为 T[]。
// 例如，一个由5个 uint 的动态数组组成的数组被写成 uint[][5]。
// 与其他一些语言相比, 这种记法是相反的。
// 在Solidity中, X[3] 总是一个包含三个 X 类型元素的数组，
// 即使 X 本身是一个数组。 这在其他语言中是不存在的，如C语言。
// 索引是基于零的，访问方向与声明相反。
// 例如，如果您有一个变量 uint[][5] memory x，
// 您用 x[2][6] 访问第三个动态数组中的第七个 uint，
// 要访问第三个动态数组，用 x[2]。
// 同样，如果您有一个数组 T[5] a 的类型 T，
// 也可以是一个数组，那么 a[2] 总是有类型 T。
// 数组元素可以是任何类型，包括映射或结构体。
// 并适用于类型的一般限制，映射只能存储在 storage 数据位置，
// 公开可见的函数需要参数是 ABI类型。
// 可以将状态变量数组标记为 public，
//  并让Solidity创建一个 getter 函数。数字索引成为该函数的一个必要参数。
// 访问一个超过它的末端的数组会导致一个失败的断言。
// 方法 .push() 和 .push(value) 可以用来在数组的末端追加一个新的元素，
//  其中 .push() 追加一个零初始化的元素并返回它的引用。


// -------------------bytes 和 string 类型的数组-------------------------
// bytes 和 string 类型的变量是特殊的数组。 bytes 类似于 bytes1[]，
// 但它在 calldata 中会被“紧打包”（译者注：将元素连续地存在一起，
// 不会按每 32 字节一单元的方式来存放）。
//  string 与 bytes 相同，但不允许用长度或索引来访问。

// Solidity没有字符串操作函数，但有第三方的字符串库。
// 您也可以用
// keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2))
// 来比较两个字符串的keccak256-hash，
// 用 string.concat(s1, s2) 来连接两个字符串。

// 您应该使用 bytes 而不是 bytes1[]，因为它更便宜，
// 因为在 memory 中使用 bytes1[] 会在元素之间增加31个填充字节。
// 请注意，在 storage 中，由于紧打包，没有填充，参见 字节和字符串。
// 一般来说，对于任意长度的原始字节数据使用 bytes，
// 对于任意长度的字符串（UTF-8）数据使用 string。
// 如果您能将长度限制在一定的字节数，
// 总是使用 bytes1 到 bytes32 中的一种值类型，因为它们更便宜。

// -------------------函数bytes.concat和string.concat-------------------
// 您可以使用 string.concat 连接任意数量的 string 值。
// 该函数返回一个单一的 string memory 数组，其中包含没有填充的参数内容。
// 如果您想使用不能隐式转换为 string 的其他类型的参数，
// 您需要先将它们转换为 string。

// 同样， bytes.concat 函数可以连接任意数量的 bytes
// 或 bytes1 ... bytes32 值。
// 该函数返回一个单一的 bytes memory 数组，其中包含没有填充的参数内容。
// 如果您想使用字符串参数或其他不能隐式转换为 bytes 的类型，
// 您需要先将它们转换为 bytes 或 bytes1 /.../ bytes32。
// 如果您不带参数调用 string.concat 或 bytes.concat，
// 它们会返回一个空数组。
contract C {
    string s = "Storage";
    function f(bytes calldata bc, string memory sm, bytes16 b)
    public view {
        string memory concatString = string.concat(s, string(bc), "Literal", sm);
        assert((bytes(s).length + bc.length + 7 + bytes(sm).length)
        == bytes(concatString).length);

        bytes memory concatBytes = bytes.concat(bytes(s), bc, bc[:2], "Literal", bytes(sm), b);
        assert((bytes(s).length + bc.length + 2 + 7 + bytes(sm).length + b.length)
        == concatBytes.length);
    }
}

// -------------------创建内存数组--------------------------------------
// 具有动态长度的内存数组可以使用 new 操作符创建。
// 与存储数组不同的是，不可能 调整内存数组的大小
//（例如， .push 成员函数不可用）。
// 您必须事先计算出所需的大小，或者创建一个新的内存数组并复制每个元素。
// 正如Solidity中的所有变量一样，
// 新分配的数组元素总是以 默认值 进行初始化。
contract C2 {
    function f(uint len) public pure {
        uint[] memory a = new uint[](7);
        bytes memory b = new bytes(len);
        assert(a.length == 7);
        assert(b.length == len);
        a[6] = 8;
    }
}
// -------------------数组字面常数--------------------------------------
// 数组字面常数表达式是一个逗号分隔的一个或多个表达式的列表，
// 用方括号（ [...] ）括起来。
// 例如， [1, a, f(3)]。数组字面常数的类型确定如下：
// 它总是一个静态大小的内存数组，其长度是表达式的数量。
// 数组的基本类型是列表上第一个表达式的类型，
// 这样所有其他表达式都可以隐含地转换为它。
// 如果不能做到这一点，则会有一个类型错误。
// 仅仅存在一个所有元素都可以转换的类型是不够的。
// 其中一个元素必须是该类型的。
// 在下面的例子中， [1, 2, 3] 的类型是 uint8[3] memory，
// 因为这些常量的类型都是 uint8。
// 如果您想让结果是 uint[3] memory 类型，
// 您需要把第一个元素转换为 uint。
contract C3 {
    function f() public pure {
        g([uint(1), 2, 3]);
        // 下一行会产生一个类型错误，因为uint[3]内存不能被转换为uint[]内存。
        // uint[] memory x = [uint(1), 3, 4];

        // 如果您想初始化动态大小的数组，您必须分配各个元素：

        uint[] memory xx = new uint[](3);
        xx[0] = 1;
        xx[1] = 3;
        xx[2] = 4;
    }
    function g(uint[3] memory) public pure {
        // ...
    }
}
// -------------------数组成员--------------------------------------
//     length:
// 数组有 length 成员变量表示当前数组的长度。一经创建，
// 内存memory数组的大小就是固定的（但却是动态的，也就是说，它依赖于运行时的参数）。

// push():
// 动态存储数组和 bytes （不是 string ）有一个叫 push() 的成员函数，
// 您可以用它在数组的末尾追加一个零初始化的元素。它返回一个元素的引用，
// 因此可以像 x.push().t = 2 或 x.push() = b 那样使用。

// push(x):
// 动态存储数组和 bytes （不是 string ）有一个叫 push(x) 的成员函数，
// 您可以用它在数组的末端追加一个指定的元素。该函数不返回任何东西。

// pop():
// 动态存储数组和 bytes （不是 string ）有一个叫 pop() 的成员函数，
// 您可以用它来从数组的末端移除一个元素。 这也隐含地在被删除的元素上调用 delete。
// 该函数不返回任何东西。

// -------------------对存储数组元素的悬空引用（Dangling References）-------------------
// 当使用存储数组时，您需要注意避免悬空引用。
// 悬空引用是指一个指向不再存在的或已经被移动而未更新引用的内容的引用。
// 例如，如果您将一个数组元素的引用存储在一个局部变量中，
// 然后从包含数组中使用 .pop()，就可能发生悬空引用：
contract C4 {
    uint[][] s;
    function f() public {
        // 存储一个指向s的最后一个数组元素的指针。
        uint[] storage ptr = s[s.length - 1];
        // 删除s的最后一个数组元素。
        s.pop();
        // 写入已不在数组内的数组元素。
        ptr.push(0x42);
        // 现在向 ``s`` 添加一个新元素不会添加一个空数组，
        // 而是会产生一个长度为1的数组，元素为 ``0x42``。
        s.push();
        assert(s[s.length - 1][0] == 0x42);
    }
}

// -------------------数组切片--------------------------------------
// 数组切片是对一个数组的连续部分的预览。
// 它们被写成 x[start:end]，其中 start 和 end 是表达式，
// 结果是uint256类型（或隐含的可转换类型）。
// 分片的第一个元素是 x[start]， 最后一个元素是 x[end - 1]。
// 如果 start 大于 end，或者 end 大于数组的长度， 就会出现异常。

// start 和 end 都是可选的： start 默认为 0， end 默认为数组的长度。

// 数组切片没有任何成员。它们可以隐含地转换为其底层类型的数组并支持索引访问。
// 索引访问在底层数组中不是绝对的，而是相对于分片的开始。

// 数组切片没有类型名，这意味着任何变量都不能以数组切片为类型，
// 它们只存在于中间表达式中。

// 数组切片对于ABI解码在函数参数中传递的二级数据很有用：

contract Proxy {
    /// @dev 由代理管理的客户合约的地址，即本合约的地址
    address client;

    constructor(address client_) {
        client = client_;
    }

    /// 转发对 "setOwner(address)" 的调用，
    /// 该调用在对地址参数进行基本验证后由客户端执行。
    function forward(bytes calldata payload) external {
        bytes4 sig = bytes4(payload[:4]);
        // 由于截断行为，bytes4(payload)的表现是相同的。
        // bytes4 sig = bytes4(payload);
        if (sig == bytes4(keccak256("setOwner(address)"))) {
            address owner = abi.decode(payload[4:], (address));
            require(owner != address(0), "Address of owner cannot be zero.");
        }
        (bool status,) = client.delegatecall(payload);
        require(status, "Forwarded call failed.");
    }
}



contract ArrayContract {
    uint[2**20] aLotOfIntegers;
    // 请注意，下面不是一对动态数组，
    // 而是一个动态数组对（即长度为2的固定大小数组）。
    // 在 Solidity 中，T[k]和T[]总是具有T类型元素的数组，
    // 即使T本身是一个数组。
    // 正因为如此，bool[2][]是一个动态数组对，其元素是bool[2]。
    // 这与其他语言不同，比如C，
    // 所有状态变量的数据位置都是存储。
    bool[2][] pairsOfFlags;

    // newPairs被存储在memory中--这是公开合约函数参数的唯一可能性。
    function setAllFlagPairs(bool[2][] memory newPairs) public {
        // 赋值到一个存储数组会执行 ``newPairs`` 的拷贝，
        // 并替换完整的数组 ``pairsOfFlags``。
        pairsOfFlags = newPairs;
    }

    struct StructType {
        uint[] contents;
        uint moreInfo;
    }
    StructType s;

    function f(uint[] memory c) public {
        // 在 ``g`` 中存储一个对 ``s`` 的引用。
        StructType storage g = s;
        // 也改变了 ``s.moreInfo``.
        g.moreInfo = 2;
        // 指定一个拷贝，因为 ``g.contents`` 不是一个局部变量，
        // 而是一个局部变量的成员。
        g.contents = c;
    }

    function setFlagPair(uint index, bool flagA, bool flagB) public {
        // 访问一个不存在的数组索引会引发一个异常
        pairsOfFlags[index][0] = flagA;
        pairsOfFlags[index][1] = flagB;
    }

    function changeFlagArraySize(uint newSize) public {
        // 使用push和pop是改变数组长度的唯一方法。
        if (newSize < pairsOfFlags.length) {
            while (pairsOfFlags.length > newSize)
                pairsOfFlags.pop();
        } else if (newSize > pairsOfFlags.length) {
            while (pairsOfFlags.length < newSize)
                pairsOfFlags.push();
        }
    }

    function clear() public {
        // 这些完全清除了数组
        delete pairsOfFlags;
        delete aLotOfIntegers;
        // 这里有相同的效果
        pairsOfFlags = new bool[2][](0);
    }

    bytes byteData;

    function byteArrays(bytes memory data) public {
        // 字节数组（"byte"）是不同的，因为它们的存储没有填充，
        // 但可以与 "uint8[]"相同。
        byteData = data;
        for (uint i = 0; i < 7; i++)
            byteData.push();
        byteData[3] = 0x08;
        delete byteData[2];
    }

    function addFlag(bool[2] memory flag) public returns (uint) {
        pairsOfFlags.push(flag);
        return pairsOfFlags.length;
    }

    function createMemoryArray(uint size) public pure returns (bytes memory) {
        // 使用 `new` 创建动态 memory 数组：
        uint[2][] memory arrayOfPairs = new uint[2][](size);

        // 内联数组总是静态大小的，如果您只使用字面常数表达式，您必须至少提供一种类型。
        arrayOfPairs[0] = [uint(1), 2];

        // 创建一个动态字节数组：
        bytes memory b = new bytes(200);
        for (uint i = 0; i < b.length; i++)
            b[i] = bytes1(uint8(i));
        return b;
    }

}
