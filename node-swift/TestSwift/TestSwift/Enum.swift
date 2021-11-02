//
//  Enum.swift
//  TestSwift
//
//  Created by Key on 2020/8/18.
//  Copyright © 2020 阅文. All rights reserved.
//

import Foundation


/************************/
/*
 枚举内存窥探
 
 如下实验：枚举、原始值、关联值 各种情况
 
 - 1 个字节存储成员值
 - N 个字节存储关联值（N取占用内存最大的关联值），任何一个 case 的关联值都公用这 N 个字节
 
 （共用体）
 */

func enumTest1() {
    enum TestEnum {
        case test1, test2, test3, test4
    }

    var t = TestEnum.test1

    print(Mems.ptr(ofVal: &t))

    t = .test2
    t = .test3

    print(MemoryLayout<TestEnum>.size)      // 1
    print(MemoryLayout<TestEnum>.stride)    // 1
    print(MemoryLayout<TestEnum>.alignment) // 1
    // 00 00 00 00 00 00 00 00
    // 01 00 00 00 00 00 00 00
    // 02 00 00 00 00 00 00 00
}

func enumTest2() {
    // 枚举 - 原始值
    enum TestEnum : Int {
        case test1 = 1, test2 = 2, test3 = 3
    }

    var t = TestEnum.test1
    // 00 00 00 00 00 00 00 00
    print(Mems.ptr(ofVal: &t))

    t = .test2
    // 01 00 00 00 00 00 00 00
    
    t = .test3
    // 02 00 00 00 00 00 00 00
    
    print(MemoryLayout<TestEnum>.size)      // 1
    print(MemoryLayout<TestEnum>.stride)    // 1
    print(MemoryLayout<TestEnum>.alignment) // 1
}

func enumTest3() {
    // 枚举 - 关联值
    enum TestEnum {
        case test1(Int, Int, Int)
        case test2(Int, Int)
        case test3(Int)
        case test4(Bool)
        case test5
    }

    var t = TestEnum.test1(1, 2, 3)
    // 01 00 00 00 00 00 00 00
    // 02 00 00 00 00 00 00 00
    // 03 00 00 00 00 00 00 00
    // 00
    // 00 00 00 00 00 00 00
    
    
    print(Mems.ptr(ofVal: &t))
    
    t = .test2(4, 5)
    // 04 00 00 00 00 00 00 00
    // 05 00 00 00 00 00 00 00
    // 00 00 00 00 00 00 00 00
    // 01
    // 00 00 00 00 00 00 00
    
    
    t = .test3(6)
    // 06 00 00 00 00 00 00 00
    // 00 00 00 00 00 00 00 00
    // 00 00 00 00 00 00 00 00
    // 02
    // 00 00 00 00 00 00 00
    
    
    t = .test4(true)
    // 01 00 00 00 00 00 00 00
    // 00 00 00 00 00 00 00 00
    // 00 00 00 00 00 00 00 00
    // 03
    // 00 00 00 00 00 00 00
    
    
    t = .test5
    // 00 00 00 00 00 00 00 00
    // 00 00 00 00 00 00 00 00
    // 00 00 00 00 00 00 00 00
    // 04
    // 00 00 00 00 00 00 00
    
    print(MemoryLayout<TestEnum>.size)      // 25
    print(MemoryLayout<TestEnum>.stride)    // 32
    print(MemoryLayout<TestEnum>.alignment) // 8
}


// 枚举 - 关联值
//enum TestEnum {
//    case test1(Int, Int, Int)
//    case test2(Int, Int)
//    case test3(Int)
//    case test4(Bool)
//    case test5
//}


//func a111() -> TestEnum {
//    TestEnum.test2(10, 20)
//}

/// switch 原理 -- 汇编分析
func enumTest4() {
    
    enum TestEnum {
        case test1(Int, Int, Int)
        case test2(Int, Int)
        case test3(Int)
        case test4(Bool)
        case test5
    }
    
    var t1 = TestEnum.test2(10, 20)
    
//    print(Mems.ptr(ofVal: &t1))
    
    switch t1 {
    case let .test1(a1, a2, a3):
        print("test1 -", a1, "-", a2, "-", a3)
    case let .test2(a1, a2):
        print("test2 -", a1, "-", a2)
    case let .test3(a1):
        print("test3 -", a1)
    case let .test4(a1):
        print("test4 -", a1)
    case .test5:
        print("test5 -")
    }
    
    
    
    print(MemoryLayout<TestEnum>.size)      // 1
    print(MemoryLayout<TestEnum>.stride)    // 1
    print(MemoryLayout<TestEnum>.alignment) // 1
}


/// 字符串插值
func enumTest5() {
    
    let c1: Int? = 10
//    print(c1)
//    print("c1 == \(c1)")
    
    print("c1 == \(c1!)")
    print("c1 == \(String(describing: c1))")
    print("c1 == \(c1 ?? 0)")
}


/// 多重可选项
func enumTest6() {
    
//    var r1: Int? = 10
//    var r2: Int?? = r1
//    var r3: Int?? = 10
//
//    print(r2 == r3)
//
//    var r11: Int? = nil
//    var r22: Int?? = r11
//    var r33: Int?? = nil
//
//    print(r22 == r33)
//    print(r11 == r33)
//
//    (r22 ?? 1) ?? 2
//    (r33 ?? 1) ?? 2
    
//    var num1: Int? = nil
//    var num2: Int?? = num1
//    var num3: Int?? = nil
//
//    var a1 = num2 ?? 1
//
//    print("aa")
}
