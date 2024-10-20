// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
pragma solidity ^0.8.21;
contract StructTypes {
    // 结构体 Struct
    struct Student{
        uint256 id;
        uint256 score; 
    }
    Student student; // 初始一个student结构体
    //  给结构体赋值
    // 方法1:在函数中创建一个storage的struct引用
    function initStudent1() external{
        Student storage _student = student; // assign a copy of student
        _student.id = 11;
        _student.score = 100;
    }

    // 方法2:直接引用状态变量的struct
    function initStudent2() external{
        student.id = 1;
        student.score = 80;
    }
    
    // 方法3:构造函数式
    function initStudent3() external {
        student = Student(3, 90);
    }

    // 方法4:key value
    function initStudent4() external {
        student = Student({id: 4, score: 60});
    }

    //Solidity 中有三种引用类型。分别是数组，结构体和映射类型。其中数组是把一堆类型相同的元素绑在一起，形成一种新的类型。
    //接下来我们要介绍的结构体是把不同类型的元素绑在一起，形成的一种新类型。结构体类型主要有以下几个方面的应用：
    //1. 可以把多个不同类型的数据绑在一起方便进行统一管理
    //2. 有了结构体，我们可以一次性向函数传入多个值，而不需要把其展开成多个参数
    //3. 同理, 我们也可以使用结构体一次性从函数传回多个值
    //4. 结构体加强了 Solidity 的表达能力（结构体可以与其他结构体或者数组，映射类型互相嵌套）。使得代码更加易读

    // -----------定义一个结构体--------------
    struct Book {
        string title; // 书名
        uint price;   // 价格
    }

    // ----------结构体的声明------------------
    // StructName DataLocation varName;
    Book memory book;

    // ----------结构体的初始化----------------
    Book memory book1 = Book(
        {
            title: "my book title",
            price: 25
        }
    );

    Book memory book2 = Book("my book title", 25);

    // ------------获取结构体成员-------------
    Book memory book3;
    book3.title = "my book title"; // 给结构体成员赋值
    book3.price = 25; // 给结构体成员赋值

    console.log("title: %s", book3.title); // 获取结构体成员值

    // ---------结构体可以和数组，映射类型互相嵌套---------
    Book[] public lib; // Book数组，状态变量
    function addNewBook(Book memory book) public {
        lib.push(book);
    }

    struct Book {
        string title; // 书名
        uint price;   // 价格
        string[] author; // 作者
    }
}

