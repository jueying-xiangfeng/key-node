//
//  Closure.swift
//  TestSwift
//
//  Created by Key on 2020/8/20.
//  Copyright © 2020 阅文. All rights reserved.
//

import Foundation


// MARK: - 闭包表达式
/// 在 swift 中，可以通过 func 定义一个函数，也可以通过闭包表达式定义一个函数
func closureTest1() {

    /// 函数类型
    func sum(_ v1: Int, _ v2: Int) -> Int { v1 + v2 }
    var sumFn = sum
    print(sumFn(10, 20))

    /// 闭包表达式
    /*
     格式：
     {
        (参数列表) -> 返回值类型 in
        函数体代码
     }
     */
    
    var fn = {
        (v1: Int, v2: Int) -> Int in
        return v1 + v2
    }
    print(fn(10, 20))
    
    print(Mems.size(ofVal: &sumFn))
    print(Mems.size(ofVal: &fn))
    
//    let a = {
//        (v1: Int, v2: Int) -> Int in
//        return v1 + v2
//    }(10, 30)
//    print(a)
    
//    closureTest1_1()
//    closureTest1_2()
}

/// 闭包表达式的简写
func closureTest1_1() {
    
    print("closureTest1_1 ----------")
    
    func exec(v1: Int, v2: Int, fn: (Int, Int) -> Int) {
        print(fn(v1, v2))
    }
    
    /// 1 -
    exec(v1: 11, v2: 22, fn: { (a: Int, b: Int) -> Int in
        return a + b
    })
    /// 2 -
    exec(v1: 12, v2: 22, fn: { a, b -> Int in
        return a + b
    })
    /// 3 -
    exec(v1: 13, v2: 22, fn: { a, b in
        a + b
    })
    /// 4 -
    exec(v1: 14, v2: 22, fn: {
        $0 + $1
    })
    /// 5 - 变态级
    exec(v1: 14, v2: 22, fn: +)
    
    
    print("尾随闭包 ----------")
    /// 尾随闭包
    /// 如果将一个很长的闭包表达式作为函数的最后一个实参，使用尾随闭包可以增强函数的可读性
    /// 尾随闭包是一个被书写在函数调用括号外面(后面)的闭包表达式
    exec(v1: 10, v2: 20) { (a, b) -> Int in
        a + b
    }
    
    /// 如果闭包表达式是函数的唯一实参，而且使用了尾随闭包的语法，就不需要在函数名后边写圆括号
    func exec1(fn: (Int, Int) -> Int) {
        print(fn(1, 2))
    }
    exec1 { (a, b) -> Int in
        a + b
    }
    exec1(fn: {
        $0 + $1
    })
    exec1() {
        $0 + $1
    }
    exec1 { $0 + $1 }
}

func closureTest1_2() {
    /// 示例：数组排序
    
    var nums = [1, 2, 3, 4, 5]
    
    /// 返回 true，i1 在 i2 前面
    /// 返回 false，i1 在 i2 后面
    func cmp(i1: Int, i2: Int) -> Bool {
        return i1 > i2
    }
    nums.sort(by: cmp)
    print(1, nums)
    
    nums.sort(by: {
        (i1: Int, i2: Int) -> Bool in
        return i1 < i2
    })
    print(2, nums)
    
    nums.sort(by: { i1, i2 in return i1 < i2 })
    print(3, nums)
    
    nums.sort(by: { i1, i2 in i1 < i2 })
    print(4, nums)
    
    nums.sort(by: { $0 < $1 })
    print(5, nums)
    
    nums.sort(by: <)
    print(6, nums)
    
    nums.sort() { $0 < $1 }
    print(7, nums)
    
    nums.sort { $0 < $1 }
    print(8, nums)
    
    nums.sort { (i1, i2) -> Bool in
        i1 > i2
    }
    print(9, nums)
}


// MARK: - 闭包
/// 一个函数和它所捕获的变量、常量环境组合起来，成为闭包
/// 一般指定义在函数内部的函数
/// 一般它捕获的是外层函数的局部变量、常量
func closureTest2() {
    
    typealias Fn = (Int) -> Int
    func getFn() -> Fn {
        var num = 0
        func plus(_ i: Int) -> Int {
            num += i
            return num
        }
        return plus
    } // 返回的 plus 和 num 形成闭包
    
//    var fn1 = getFn()
//    fn1(1)
//    fn1(2)
    
//    print(fn1(1))
//    print(fn1(2))
//    print(fn1(3))
    
    
    /// 可以把闭包想象成是一个类的实例对象
    /// 内存在堆空间
    /// 捕获的局部变量、常量就是对象的成员(存储属性)
    /// 组成闭包的函数就是类内部定义的方法
    class Closure {
        var num1 = 0
        var num2 = 0
        
        func plus(_ i: Int) -> (Int, Int) {
            num1 += i
            num2 += i << 1
            return (num1, num2)
        }
        
        func minus(_ i: Int) -> (Int, Int) {
            num1 -= i;
            num2 -= i << 1
            return (num1, num2)
        }
    }
    let cs = Closure()
    print(cs.plus(1))  // (1, 2)
    print(cs.minus(2)) // (-1, -2)
    print(cs.plus(3))  // (2, 4)
    print("----------------")
    
    closureTest2_1()
//    closureTest2_2()
}

func closureTest2_1() {
    
    var funcions: [() -> Int] = []
    
    for i in 1...3 {
        funcions.append { () -> Int in
            i
        }
    }
//    for item in funcions {
//        print(item.self, item(), separator:"===")
//    }
//    print("----------------")
}

func closureTest2_2() {
    
    class Closure {
        var i: Int
        init(item i: Int) {
            self.i = i
        }
        func get() -> Int {
            return i
        }
    }
    
    var clses: [Closure] = []
    for i in 1...3 {
        clses.append(Closure(item: i))
    }
    
    for cls in clses {
        print(cls.get())
    }
}


// MARK: - 自动闭包
///
/// @autoclosure 会自动将 20 封装成闭包 { 20 }
/// @autoclosure 只支持 () -> T 格式的参数
/// @autoclosure 并非只支持最后一个参数
/// 空合并运算符 ?? 使用了 @autoclosure 技术
/// 有 @autoclosure、无 @autoclosure 构成函数重载
func closureTest3() {
    
    func getFirstPositive(_ v1: Int, _ v2: Int) -> Int {
        return v1 > 0 ? v1 : v2
    }
    print(getFirstPositive(10, 20))
    
    /// 改成函数类型的参数，可以让 v2 延迟加载
    func getFirstPositive1(_ v1: Int, _ v2: () -> Int) -> Int {
        return v1 > 0 ? v1 : v2()
    }
    func getNum() -> Int {
        print("----------")
        return 20
    }
    
    print(getFirstPositive1(10, getNum))
    
    /// 为了避免与期望冲突，使用了 @autoclosure 的地方最好明确注释清楚，这个值会被推迟执行
    func getFirstPositive2(_ v1: Int, _ v2: @autoclosure () -> Int) -> Int {
        return v1 > 0 ? v1 : v2()
    }
    print(getFirstPositive2(10, 20))
}
