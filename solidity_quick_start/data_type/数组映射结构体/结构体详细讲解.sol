// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.9.0;
// 2024年最热门web3技术保姆级solidity教程，
// 欢迎大家关注秀才!视频在抖音里面@跟着秀才学编程 进入web3开发合集观看学习
// https://github.com/xiucai369/follow-xiucai-solidity-programing

// 本视频使用solidity版本v0.8.17讲解
// ------------------结构体------------------
// Solidity 提供了一种以结构形式定义新类型的方法，以下是一个结构体使用的示例：

// 定义一个包含两个属性的新类型。
// 在合约之外声明一个结构，
// 可以让它被多个合约所共享。
// 在这里，这并不是真的需要。

// ------------------结构体众筹案例详细讲解------------------
// 今天我们学习一个众筹合约的案例，这个合约并没有提供众筹合约的全部功能，
// 但它包含了理解结构体所需的基本概念。
// 结构类型可以在映射和数组内使用， 它们本身可以包含映射和数组。

// 结构体不可能包含其自身类型的成员，尽管结构本身可以是映射成员的值类型，
// 或者它可以包含其类型的动态大小的数组。 这一限制是必要的，因为结构的大小必须是有限的。

// 注意在所有的函数中，结构类型被分配到数据位置为 storage 的局部变量。
// 这并不是拷贝结构体，而只是存储一个引用， 因此对本地变量成员的赋值实际上是写入状态。

// 当然，您也可以直接访问该结构的成员， 而不把它分配给本地变量，
// 如 campaigns[campaignID].amount = 0。

// 备注
// 在 Solidity 0.7.0 之前，包含仅有存储类型（例如映射）的成员的内存结构是允许的，
// 像上面例子中的 campaigns[campaignID] = Campaign(beneficiary, goal, 0, 0) 这样的赋值是可以的，
// 只是会默默地跳过这些成员。

// 众筹玩家-爱心人士
    struct Funder {
        address addr;//玩家账户地址
        uint amount;//玩家捐献多少资金
    }

contract CrowdFunding {
    // 结构体也可以被定义在合约内部，这使得它们只在本合约和派生合约中可见。
    // 这是一个众筹计划对象
    struct Campaign {
        address payable beneficiary;// 受益人是谁
        uint fundingGoal;//需要筹款多少资金
        uint numFunders;//参与众筹的用户个数
        uint amount;// 众筹金额
        mapping (uint => Funder) funders;//存储每个众筹用户
    }

    uint numCampaigns;
    mapping (uint => Campaign) campaigns;// 众筹计划映射

    // 创建一个众筹计划方案
    function newCampaign(address payable beneficiary, uint goal)
    public returns (uint campaignID) {
        campaignID = numCampaigns++; // campaignID 作为一个变量返回
        // 我们不能使用 "campaigns[campaignID] = Campaign(beneficiary, goal, 0, 0)"
        // 因为右侧创建了一个内存结构 "Campaign"，其中包含一个映射。
        Campaign storage c = campaigns[campaignID];
        c.beneficiary = beneficiary;
        c.fundingGoal = goal;
    }
    // 爱心人士发起捐献
    function contribute(uint campaignID,address sender,uint amount) public payable {
        Campaign storage c = campaigns[campaignID];
        // 以给定的值初始化，创建一个新的临时 memory 结构体，
        // 并将其拷贝到 storage 中。
        // 注意您也可以使用 Funder(msg.sender, msg.value) 来初始化。
        c.funders[c.numFunders++] = Funder({addr: sender, amount: amount});
        c.amount += amount;
    }

    // 检查众筹资金是否到账
    function checkGoalReached(uint campaignID)
    public returns (bool reached) {
        Campaign storage c = campaigns[campaignID];
        if (c.amount < c.fundingGoal)
            return false;
        uint amount = c.amount;
        c.amount = 0;
        c.beneficiary.transfer(amount);
        return true;
    }
}



//// SPDX-License-Identifier: MIT
//pragma solidity ^0.8.21;
//contract StructTypes {
//    // 结构体 Struct
//    struct Student{
//        uint256 id;
//        uint256 score;
//    }
//    Student student; // 初始一个student结构体
//    //  给结构体赋值
//    // 方法1:在函数中创建一个storage的struct引用
//    function initStudent1() external{
//        Student storage _student = student; // assign a copy of student
//        _student.id = 11;
//        _student.score = 100;
//    }
//
//    // 方法2:直接引用状态变量的struct
//    function initStudent2() external{
//        student.id = 1;
//        student.score = 80;
//    }
//
//    // 方法3:构造函数式
//    function initStudent3() external {
//        student = Student(3, 90);
//    }
//
//    // 方法4:key value
//    function initStudent4() external {
//        student = Student({id: 4, score: 60});
//    }
//
//    //Solidity 中有三种引用类型。分别是数组，结构体和映射类型。其中数组是把一堆类型相同的元素绑在一起，形成一种新的类型。
//    //接下来我们要介绍的结构体是把不同类型的元素绑在一起，形成的一种新类型。结构体类型主要有以下几个方面的应用：
//    //1. 可以把多个不同类型的数据绑在一起方便进行统一管理
//    //2. 有了结构体，我们可以一次性向函数传入多个值，而不需要把其展开成多个参数
//    //3. 同理, 我们也可以使用结构体一次性从函数传回多个值
//    //4. 结构体加强了 Solidity 的表达能力（结构体可以与其他结构体或者数组，映射类型互相嵌套）。使得代码更加易读
//
//    // -----------定义一个结构体--------------
//    struct Book {
//        string title; // 书名
//        uint price;   // 价格
//    }
//
//    // ----------结构体的声明------------------
//    // StructName DataLocation varName;
//    Book memory book;
//
//    // ----------结构体的初始化----------------
//    Book memory book1 = Book(
//        {
//            title: "my book title",
//            price: 25
//        }
//    );
//
//    Book memory book2 = Book("my book title", 25);
//
//    // ------------获取结构体成员-------------
//    Book memory book3;
//    book3.title = "my book title"; // 给结构体成员赋值
//    book3.price = 25; // 给结构体成员赋值
//
//    console.log("title: %s", book3.title); // 获取结构体成员值
//
//    // ---------结构体可以和数组，映射类型互相嵌套---------
//    Book[] public lib; // Book数组，状态变量
//    function addNewBook(Book memory book) public {
//        lib.push(book);
//    }
//
//    struct Book {
//        string title; // 书名
//        uint price;   // 价格
//        string[] author; // 作者
//    }
//}
//
