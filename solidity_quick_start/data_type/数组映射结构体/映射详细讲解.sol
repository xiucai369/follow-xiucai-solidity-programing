// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract Mapping {
    mapping(uint => address) public idToAddress; // id映射到地址
    mapping(address => address) public swapPair; // 币对的映射，地址到地址
    
    // 规则1. _KeyType不能是自定义的 下面这个例子会报错
    // 我们定义一个结构体 Struct
    // struct Student{
    //    uint256 id;
    //    uint256 score; 
    //}
    // mapping(Struct => uint) public testVar;

    function writeMap (uint _Key, address _Value) public{
        idToAddress[_Key] = _Value;
    }

    //-----映射类型变量的声明-----
     mapping(KeyType => ValueType) varName;

    //其中 KeyType 是键的类型，它可以是任何「内置值类型」
    //（built-in value type）。例如 uint, string, bytes 等等。
    //但是不能是数组，结构体，映射类型这些引用类型。
    //然后 ValueType 是值的类型。它可以是任意类型，包括数组，结构体等。
    //此外， varName 是你取的任意变量名。
    //例如我想要声明一个空投数额记录，我们可以这样声明：
    struct AirDrop {
        address to;
        uint amount;
    }

    AirDrop[] airDrop;

    AirDrop[] airDrop;
    function getAirDropAmount(address addr) public view returns(uint) {
        for(uint i = 0; i < airDrop.length; i++) {
            if(airDrop[i].to == addr) {
                return airDrop[i].amount;
            }
        }
        return 0;
    }

    mapping(address => uint) airDrop;

    // -------------如何使用key存取value----------------
    airDrop[0xaaaaa] = 100;
    uint amount = airDrop[0xaaaaa];

    // ------------映射类型只能声明在 storage------------
    mapping(address => uint) memory myMap; // 编译错误

    // ------------映射类型作为入参和返回值时，函数可见性必须是 private 或 internal
    //● 函数的可见性为 public 或 external时， 那么在入参和返回值里面不能使用映射类型。
    //● 函数的可见性为 private 或 internal时，那么在入参和返回值里面可以使用映射类型。
    //如果你还不知道什么是函数的可见性（visibility），可以暂时先略过这部分。
    //下面的例子展示了这个规则：
    //映射类型作为入参和返回值时，函数可见性必须是 private 或 internal
    // 编译错误，映射类型作为入参和返回值时，函数可见性必须是 private 或 internal
    function invalidDeclaration(mapping(address => uint) storage myMap) public {}

    // 编译错误，映射类型作为入参和返回值时，函数可见性必须是 private 或 internal
    function invalidDeclaration(mapping(address => uint) storage myMap) external {}

    // 合法
    function validDeclaration(mapping(address => uint) storage myMap) private {}

    // 合法
    function validDeclaration(mapping(address => uint) storage myMap) internal {}

    // ------映射类型可以与数组，结构体互相嵌套------
    struct Book {
        uint isbn;
        string title; // 书名
        uint price;   // 价格
    }

    mapping(uint => Book) lib; // 从 ISBN 到 Book 的映射关系

    // ---------------映射类型的其他特性----------------
    //    Solidity 的映射类型还有一些其他特性：
    //    1. 没有 length 属性
    //    2. 无法进行遍历
    //    所以如果你想要知道映射类型的 length 究竟是多少，或者想要遍历整个映射类型，这都需要自己实现。不过在合约使用到的大多数场景中，都没有这种需求。
}
