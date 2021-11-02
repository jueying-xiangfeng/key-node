//
//  main.swift
//  TestSwift
//
//  Created by Key on 2020/8/18.
//  Copyright © 2020 阅文. All rights reserved.
//

import Foundation

/************************/
// MARK: - 枚举
/*
 枚举内存窥探
 */
//enumTest1()
//enumTest2()
//enumTest3()
//enumTest4()
//enumTest5()
//enumTest6()


//enum TestEnum {
//    case test1(Int, Int, Int)
//    case test2(Int, Int)
//    case test3(Int)
//    case test4(Bool)
//    case test5
//}
//
////var t1 = TestEnum.test1(10, 20, 30)
////print(Mems.ptr(ofVal: &t1))
//
//var t1 = TestEnum.test5
////    t = .test3(6)
////    t = .test4(true)
////    t = .test5
//
//
//switch t1 {
//case let .test1(a1, a2, a3):
//    print("test1 -", a1, "-", a2, "-", a3)
////case let .test2(a1, a2):
////    print("test2 -", a1, "-", a2)
////case let .test3(a1):
////    print("test3 -", a1)
////case let .test4(a1):
////    print("test4 -", a1)
//case .test5:
//    print("test5 -")
//default:
//    break
//}
//
//
//print(Mems.ptr(ofVal: &t1))


/************************/
// MARK: - 结构体、类
//structAndClassTest1()
//structAndClassTest2()
//structAndClassTest3()
//structAndClassTest4()
//structAndClassTest5()
//structAndClassTest6()

/// 汇编层面分析
//struct Point {
//    var x: Int
//    var y: Int
//}
//
//var p1 = Point(x: 10, y: 20)
//var p2 = p1
//p2.x = 11
//p2.y = 22
//print("---")



/************************/
// MARK: - 闭包
//class Person {
//    var age = 10
//}
//
//var p = Person()
//print(MemoryLayout.stride(ofValue: p))
//print(MemoryLayout<Person>.stride)
//print(class_getInstanceSize(Person.self))

//closureTest1()
//closureTest2()
//closureTest3()


//var num111 = 10
//
//print(MemoryLayout<String>.stride)
//print(MemoryLayout<Int>.stride)
//
//print(MemoryLayout.size(ofValue: num111))
//print(MemoryLayout.stride(ofValue: num111))
//print("-------")

//func sum(_ v1: Int, _ v2: Int) -> Int { v1 + v2 }
//
//var fn = sum
//print(MemoryLayout.stride(ofValue: fn))

//print(fn(10, 20))

//class Person {
//    var age = 10
//}
//
//typealias Fn = (Int) -> Int
//func getFn() -> Fn {
////    var a1 = 1
////    var a2 = 2
//
//    let p1 = Person()
//    let p2 = Person()
//
//    func plus(_ i: Int) -> Int {
////        a1 += i
////        a2 += i
////        return a1 + a2
//
//        p1.age += i
//        p2.age += i
//        return p1.age + p2.age
//    }
//    return plus
//} // 返回的 plus 和 num 形成闭包
//
//var fn1 = getFn()
//fn1(1)
//
////print(fn1(1))
//print(MemoryLayout.size(ofValue: fn1))
//print(MemoryLayout.stride(ofValue: fn1))

//fn1(1)
//print(fn1(1))


/************************/
// MARK: - 属性
//propertyTest1()
//propertyTest2()
//propertyTest3()
//propertyTest4()
//propertyTest5()


/************************/
// MARK: - 方法
//methodTest1()



/************************/
// MARK: - 下标
//subscriptTest1()



/************************/
// MARK: - 继承
//inheritanceTest1()
//inheritanceTest2()
//inheritanceTest3()
//inheritanceTest4()
//inheritanceTest5()

/// 多态：

//class Animal {
//    func speak() {
//        print("Animal speak")
//    }
//    func eat() {
//        print("Animal eat")
//    }
//    func sleep() {
//        print("Animal sleep")
//    }
//}
//
//var anim: Animal = Animal()
//anim.speak()
//anim.eat()
//anim.sleep()
//
//class Dog : Animal {
//    override func speak() {
//        print("Dog speak")
//    }
//    override func eat() {
//        print("Dog eat")
//    }
////        override func sleep() {
////            print("Dog sleep")
////        }
//}
//
//anim = Dog()
//anim.speak()
//anim.eat()
//anim.sleep()


/************************/
// MARK: - 初始化
//initializerTest1()
initializerTest2()
