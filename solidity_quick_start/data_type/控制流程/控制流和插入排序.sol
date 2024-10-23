// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

//for循环语法
//Solidity的 for 循环的语法与C语言，Javascript基本相同，其语法如下：
//
//for (init-statement; test-statement; iteration-statement) {
//// 循环体
//}
//
//for循环有三个控制语句：
//init-statement 用来在循环开始之前初始化循环变量，只执行一次
//test-statement 用来判断循环是否已经满足退出条件，每一轮循环都会执行一次判断
//iteration-statement 用来在每一轮循环执行完后（也就是执行完循环体后），改变循环变量的值
//例如下面的示例中我们可以看到 init-statement 是 i=1 ， test-statement 是 i<=10 ， iteration-statement 是 i++ 。

//while循环语法
//Solidity的 while 循环的语法与C语言，Javascript基本相同，其语法如下：
//
//while (test-statement) {
//// 循环体
//}
//
//我们可以看到while循环里面有两个表达式：
//
//test-statement
//循环体
//while 循环在每次循环开始前，首先判断 test-statement 是否为 true 。如果是则把循环体执行一遍，如果 test-statement 为 false ，那么就退出循环并继续执行余下的代码。通常情况下你都需要在循环体里面修改循环控制变量，
//使得 test-statement 在适当的时候执行结果为 false 而终止循环。
contract InsertionSort {
    // if else
    function ifElseTest(uint256 _number) public pure returns(bool){
        if(_number == 0){
            return(true);
        }else{
            return(false);
        }
    }

    // for loop
    function forLoopTest() public pure returns(uint256){
        uint sum = 0;
        for(uint i = 0; i < 10; i++){
            sum += i;
        }
        return(sum);
    }

    // while
    function whileTest() public pure returns(uint256){
        uint sum = 0;
        uint i = 0;
        while(i < 10){
            sum += i;
            i++;
        }
        return(sum);
    }

    // do-while
    function doWhileTest() public pure returns(uint256){
        uint sum = 0;
        uint i = 0;
        do{
            sum += i;
            i++;
        }while(i < 10);
        return(sum);
    }

    // 三元运算符 ternary/conditional operator
    function ternaryTest(uint256 x, uint256 y) public pure returns(uint256){
        // return the max of x and y
        return x >= y ? x: y; 
    }


    // 插入排序 错误版
    function insertionSortWrong(uint[] memory a) public pure returns(uint[] memory) {
        for (uint i = 1;i < a.length;i++){
            uint temp = a[i];
            uint j=i-1;
            while( (j >= 0) && (temp < a[j])){
                a[j+1] = a[j];
                j--;
            }
            a[j+1] = temp;
        }
        return(a);
    }

    // 插入排序 正确版
    function insertionSort(uint[] memory a) public pure returns(uint[] memory) {
        // note that uint can not take negative value
        for (uint i = 1;i < a.length;i++){
            uint temp = a[i];
            uint j=i;
            while( (j >= 1) && (temp < a[j-1])){
                a[j] = a[j-1];
                j--;
            }
            a[j] = temp;
        }
        return(a);
    }
}
