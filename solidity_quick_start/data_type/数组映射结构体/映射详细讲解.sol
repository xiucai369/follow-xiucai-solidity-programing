// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.9.0;
// 本视频使用solidity版本v0.8.17讲解
// ---------------------------------映射类型---------------------------------
// 映射类型使用语法 mapping(KeyType => ValueType)，
// 映射类型的变量使用语法 mapping(KeyType => ValueType) VariableName 声明。
// KeyType 可以是任何内置的值类型， bytes， string，或任何合约或枚举类型。
// 其他用户定义的或复杂的类型，如映射，结构体或数组类型是不允许的。
// ValueType 可以是任何类型，包括映射，数组和结构体。

// 您可以把映射想象成 哈希表， 它实际上被初始化了，使每一个可能的键都存在，
// 并将其映射到字节形式全是零的值，一个类型的 默认值。
// 相似性到此为止，键数据不存储在映射中，而是它的 keccak256 哈希值被用来查询。

// 正因为如此，映射没有长度，也没有被设置的键或值的概念，
// 因此，如果没有关于分配的键的额外信息，就不能被删除（见 清除映射）。

// 映射只能有一个 storage 的数据位置，因此允许用于状态变量，
// 可作为函数中的存储引用类型，或作为库函数的参数。
// 但它们不能被用作公开可见的合约函数的参数或返回参数。
//这些限制对于包含映射的数组和结构也是如此。

// 您可以把映射类型的状态变量标记为 public，
// Solidit y会为您创建一个 getter 函数。
// KeyType 将成为 getter 函数的参数。
// 如果 ValueType 是一个值类型或一个结构，getter 返回 ValueType。
// 如果 ValueType 是一个数组或映射，getter 对每个 KeyType 递归出一个参数。
// 在下面的例子中， MappingExample 合约定义了一个公共的 balances 映射，
// 键类型是 address，值类型是 uint，

// 将一个Ethereum地址映射到一个无符号整数值。
// 由于 uint 是一个值类型，getter 返回一个与该类型相匹配的值，
// 您可以在 MappingUser 合约中看到它返回指定地址对应的值。
contract MappingExample {
    mapping(address => uint) public balances;

    function update(uint newBalance) public {
        balances[msg.sender] = newBalance;
    }
}
contract MappingUser {
    function f() public returns (uint) {
        MappingExample m = new MappingExample();
        m.update(100);
        return m.balances(address(this));
    }
}


// 下面的例子是一个简化版本的 ERC20 代币。 _allowances 是一个映射类型在另一个映射类型中的例子。
// 下面的例子使用 _allowances 来记录别人允许从您的账户中提取的金额。
contract MappingERC20Example {

    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    function getBalance(address owner) public view returns (uint256) {
        return _balances[owner];
    }

    function transferFrom(address sender, address recipient, uint256 amount)
    public returns (bool) {
        require(_allowances[sender][msg.sender] >= amount, "ERC20: Allowance not high enough.");
        _allowances[sender][msg.sender] -= amount;
        _transfer(sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[msg.sender][spender] = amount;
        _balances[msg.sender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(_balances[sender] >= amount, "ERC20: Not enough funds.");

        _balances[sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
    }
}


// ----------------------递归映射---------------------------
// 您不能对映射进行递归调用，也就是说，您不能列举它们的键。
// 不过，可以在它们上层实现一个数据结构，并对其进行递归。
// 例如， 下面的代码实现了一个 IterableMapping 库， 然后 User 合约将数据添加到该库中，
// sum 函数对所有的值进行递归调用去累加这些值。

    struct IndexValue { uint keyIndex; uint value; }
    struct KeyFlag { uint key; bool deleted; }

    struct itmap {
        mapping(uint => IndexValue) data;
        KeyFlag[] keys;
        uint size;
    }

    type Iterator is uint;

library IterableMapping {
    function insert(itmap storage self, uint key, uint value) internal returns (bool replaced) {
        uint keyIndex = self.data[key].keyIndex;
        self.data[key].value = value;
        if (keyIndex > 0)
            return true;
        else {
            keyIndex = self.keys.length;
            self.keys.push();
            self.data[key].keyIndex = keyIndex + 1;
            self.keys[keyIndex].key = key;
            self.size++;
            return false;
        }
    }

    function remove(itmap storage self, uint key) internal returns (bool success) {
        uint keyIndex = self.data[key].keyIndex;
        if (keyIndex == 0)
            return false;
        delete self.data[key];
        self.keys[keyIndex - 1].deleted = true;
        self.size --;
    }

    function contains(itmap storage self, uint key) internal view returns (bool) {
        return self.data[key].keyIndex > 0;
    }

    function iterateStart(itmap storage self) internal view returns (Iterator) {
        return iteratorSkipDeleted(self, 0);
    }

    function iterateValid(itmap storage self, Iterator iterator) internal view returns (bool) {
        return Iterator.unwrap(iterator) < self.keys.length;
    }

    function iterateNext(itmap storage self, Iterator iterator) internal view returns (Iterator) {
        return iteratorSkipDeleted(self, Iterator.unwrap(iterator) + 1);
    }

    function iterateGet(itmap storage self, Iterator iterator) internal view returns (uint key, uint value) {
        uint keyIndex = Iterator.unwrap(iterator);
        key = self.keys[keyIndex].key;
        value = self.data[key].value;
    }

    function iteratorSkipDeleted(itmap storage self, uint keyIndex) private view returns (Iterator) {
        while (keyIndex < self.keys.length && self.keys[keyIndex].deleted)
            keyIndex++;
        return Iterator.wrap(keyIndex);
    }
}

// 如何使用
contract User {
    // 只是一个保存我们数据的结构体。
    itmap data;
    // 对数据类型应用库函数。
    using IterableMapping for itmap;

    // 插入一些数据
    function insert(uint k, uint v) public returns (uint size) {
        // 这将调用 IterableMapping.insert(data, k, v)
        data.insert(k, v);
        // 我们仍然可以访问结构中的成员，
        // 但我们应该注意不要乱动他们。
        return data.size;
    }

    // 计算所有存储数据的总和。
    function sum() public view returns (uint s) {
        for (
            Iterator i = data.iterateStart();
            data.iterateValid(i);
            i = data.iterateNext(i)
        ) {
            (, uint value) = data.iterateGet(i);
            s += value;
        }
    }
}

//contract Mapping {
//    mapping(uint => address) public idToAddress; // id映射到地址
//    mapping(address => address) public swapPair; // 币对的映射，地址到地址
//
//    // 规则1. _KeyType不能是自定义的 下面这个例子会报错
//    // 我们定义一个结构体 Struct
//    // struct Student{
//    //    uint256 id;
//    //    uint256 score;
//    //}
//    // mapping(Struct => uint) public testVar;
//
//    function writeMap (uint _Key, address _Value) public{
//        idToAddress[_Key] = _Value;
//    }
//
//    //-----映射类型变量的声明-----
//     mapping(KeyType => ValueType) varName;
//
//    //其中 KeyType 是键的类型，它可以是任何「内置值类型」
//    //（built-in value type）。例如 uint, string, bytes 等等。
//    //但是不能是数组，结构体，映射类型这些引用类型。
//    //然后 ValueType 是值的类型。它可以是任意类型，包括数组，结构体等。
//    //此外， varName 是你取的任意变量名。
//    //例如我想要声明一个空投数额记录，我们可以这样声明：
//    struct AirDrop {
//        address to;
//        uint amount;
//    }
//
//    AirDrop[] airDrop;
//
//    AirDrop[] airDrop;
//    function getAirDropAmount(address addr) public view returns(uint) {
//        for(uint i = 0; i < airDrop.length; i++) {
//            if(airDrop[i].to == addr) {
//                return airDrop[i].amount;
//            }
//        }
//        return 0;
//    }
//
//    mapping(address => uint) airDrop;
//
//    // -------------如何使用key存取value----------------
//    airDrop[0xaaaaa] = 100;
//    uint amount = airDrop[0xaaaaa];
//
//    // ------------映射类型只能声明在 storage------------
//    mapping(address => uint) memory myMap; // 编译错误
//
//    // ------------映射类型作为入参和返回值时，函数可见性必须是 private 或 internal
//    //● 函数的可见性为 public 或 external时， 那么在入参和返回值里面不能使用映射类型。
//    //● 函数的可见性为 private 或 internal时，那么在入参和返回值里面可以使用映射类型。
//    //如果你还不知道什么是函数的可见性（visibility），可以暂时先略过这部分。
//    //下面的例子展示了这个规则：
//    //映射类型作为入参和返回值时，函数可见性必须是 private 或 internal
//    // 编译错误，映射类型作为入参和返回值时，函数可见性必须是 private 或 internal
//    function invalidDeclaration(mapping(address => uint) storage myMap) public {}
//    // 编译错误，映射类型作为入参和返回值时，函数可见性必须是 private 或 internal
//    function invalidDeclaration(mapping(address => uint) storage myMap) external {}
//
//    // 合法
//    function validDeclaration(mapping(address => uint) storage myMap) private {}
//
//    // 合法
//    function validDeclaration(mapping(address => uint) storage myMap) internal {}
//
//    // ------映射类型可以与数组，结构体互相嵌套------
//    struct Book {
//        uint isbn;
//        string title; // 书名
//        uint price;   // 价格
//    }
//
//    mapping(uint => Book) lib; // 从 ISBN 到 Book 的映射关系
//
//    // ---------------映射类型的其他特性----------------
//    //    Solidity 的映射类型还有一些其他特性：
//    //    1. 没有 length 属性
//    //    2. 无法进行遍历
//    //    所以如果你想要知道映射类型的 length 究竟是多少，或者想要遍历整个映射类型，这都需要自己实现。不过在合约使用到的大多数场景中，都没有这种需求。
//}


