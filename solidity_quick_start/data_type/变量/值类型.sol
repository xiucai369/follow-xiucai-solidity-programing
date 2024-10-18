// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
//小结
//布尔类型是用 bool 关键字定义的，只有 true 或 false 两种取值
//可以使用的运算符有：逻辑非(!), 逻辑与(&&), 逻辑或(||), 等于(==), 不等于(!=)
//逻辑或(||)和逻辑与(&&)都遵循短路规则，即在满足左边条件时不会再执行右边的操作

//小结
//Solidity有两种整型：有符号整型(intM)和无符号整型(uintM)，M的取值范围为8到256，步长为8
//我们介绍了整型可以使用的算数运算符，比较运算符和位运算符
//Solidity 的整型运算可能会出现溢出的情况
//在版本 <0.8.0 的 Solidity 中，可以使用 Openzeppelin 的 SafeMath 库来防止整型溢出
//在版本 >=0.8.0 的 Solidity 中，如果整型溢出，交易会被终止
//虽然 Solidity 在整型溢出方面是安全的，但是这并不意味着你的合约没有问题，需要注意其他的潜在风险

//Solidity的地址类型用关键字 address 表示。它占据20bytes (160bits)，默认值为 0x0 ，
//表示空地址。地址类型可以再细分为两种：
//address : 普通地址类型（不可接收转账）
//address payable : 可收款地址类型（可接收转账）
//这两种地址类型的主要的区别在于 address payable 能接受转账，而 address 不能。
//接下来我们先介绍完如何定义地址类型的变量，然后再介绍为什么要区分这两种地址类型。

//小结
//Solidity 中的地址类型是用于转账和与其他合约交互的
//地址类型用 address 表示，占据20bytes (160bits)。默认值为0x0
//地址类型有两种：普通地址类型和可收款地址类型
//可收款地址类型可以接受转账，而普通地址类型不能
//可以使用 payable() 函数将地址字面值显式转换为可收款地址类型
//balance：可以获取地址余额
//transfer()：可以向指定地址转账
//send()：与 transfer() 函数类似，但是如果转账失败会抛出异常
//call()：可以调用其他合约中的函数
//delegatecall()：与 call() 函数类似，但是使用当前合约的上下文来调用其他合约中的函数
//staticcall(): 与 call() 函数类似，但是不会允许有改变状态变量的操作
//transfer()和send() 函数只能在 address payable 类型中使用

//小结
//静态字节数组是固定长度的字节数组，是值类型，变量所储存的是值而不是数据的地址。
//Solidity一共有32种静态字节数组，如 bytes1, bytes2, bytes3, …, bytes32
//比较运算符可以比较两个变量的数量大小关系，以及变量是否相等，比较运算符得到的结果是布尔值。
//位运算符用来对二进制位进行操作，执行结果是静态字节数组。
//可以使用 [] 运算符来通过下标访问静态字节数组的某个元素，但要注意不要越界访问。

//小结
//字面值（literal）是在程序中无需变量保存的值，可以直接表示为数字或字符串。Solidity支持多种字面值类型：地址字面值，有理数和整数字面值，字符串字面值，Unicode字面值。
//地址字面值是一个长度为42字节的十六进制字符串，可以直接赋值给地址类型。
//有理数和整数字面值有多种表示方式：十进制整数，十进制小数，十六进制整数，科学记数法。Solidity 不支持8进制字面值。
//在 Solidity 中，可以在整数字面值中使用下划线_来增强可读性。例如，1_000_000 表示 100万。
//字符串字面值是由双引号 " 或单引号 ' 括起来的字符串。可以使用转义字符 \ 来表示一些特殊字符。
//Unicode字面值是由反斜杠 \ 和四位十六进制数拼成的。例如，\u0041 表示大写字母 A。

//小结
//枚举类型是组织收集有关联变量的一种方式
//Solidity的枚举类型跟C语言的类似，都是一种特殊的整型
//使用枚举类型可以提高代码的类型安全性和可读性。
//可以通过 . 操作符来获取枚举类型的某个枚举值

//小结
//自定义值类型是用户自定义的值类型，类似于别名，但是不等同于别名
//可以通过 type C is V 来定义新的自定义值类型
//使用自定义值类型可以提高代码的类型安全性和代码可读性
//不同自定义值类型之间不能进行算术运算
//自定义值类型和原生类型之间没有隐式类型转换，需要使用强制类型转换进行转换
contract ValueTypes{
    // 布尔值
    bool public _bool = true;
    // 布尔运算
    bool public _bool1 = !_bool; //取非
    bool public _bool2 = _bool && _bool1; //与
    bool public _bool3 = _bool || _bool1; //或
    bool public _bool4 = _bool == _bool1; //相等
    bool public _bool5 = _bool != _bool1; //不相等


    // 整数
    int public _int = -1;
    uint public _uint = 1;
    uint256 public _number = 20220330;
    // 整数运算
    uint256 public _number1 = _number + 1; // +，-，*，/
    uint256 public _number2 = 2**2; // 指数
    uint256 public _number3 = 7 % 2; // 取余数
    bool public _numberbool = _number2 > _number3; // 比大小


    // 地址
    address public _address = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    address payable public _address1 = payable(_address); // payable address，可以转账、查余额
    // 地址类型的成员
    uint256 public balance = _address1.balance; // balance of address
    
    
    // 固定长度的字节数组
    bytes32 public _byte32 = "MiniSolidity"; // bytes32: 0x4d696e69536f6c69646974790000000000000000000000000000000000000000
    bytes1 public _byte = _byte32[0]; // bytes1: 0x4d
    
    
    // Enum
    // 将uint 0， 1， 2表示为Buy, Hold, Sell
    enum ActionSet { Buy, Hold, Sell }
    // 创建enum变量 action
    ActionSet action = ActionSet.Buy;

    // enum可以和uint显式的转换
    function enumToUint() external view returns(uint){
        return uint(action);
    }
}

