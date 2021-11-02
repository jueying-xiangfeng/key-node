//
//  StructAndClass.swift
//  TestSwift
//
//  Created by Key on 2020/8/19.
//  Copyright © 2020 阅文. All rights reserved.
//

import Foundation


/************************/
/*:
## 结构体
 
 在 swfit 标准库中，绝大多数的公开类型都是结构体，枚举和类只占一小部分
 - 比如 Bool、Int、Double、String、Array、Dictionary 都是结构体
 
 所有的结构体都有一个编译器自动生成的初始化器(initializer、初始化方法、构造器、构造方法)
 这里的成员变量叫做 (存储属性， Stored Property)
*/


// MARK: - 结构体的初始化器
/// 编译器会根据情况，可能会为结构体生成生成多个初始化器
/// 宗旨是：保证所有成员都有初始值
/// 可选项 -- 都有个默认值 nil
func structAndClassTest1() {
//    struct PointT {
//        var x: Int
//        var y: Int
//    }
//    var pt1 = PointT(x: 10, y: 10)
//
//    struct PointT1 {
//        var x: Int = 0
//        var y: Int
//    }
//    var pt11 = PointT1(y: 10)
//    var pt12 = PointT1(x: 10, y: 10)
//
//    struct PointT11 {
//        var x: Int = 0
//        var y: Int = 0
//    }
//    var pt111 = PointT11(y: 10)
//    var pt112 = PointT11(x: 10, y: 10)
//    var pt113 = PointT11(x: 10)
//    var pt114 = PointT11()
//
//    // 可选项
//    // 可选项都有个默认值 nil
//    struct PointK {
//        var x: Int?
//        var y: Int?
//    }
//    var pk1 = PointK()
//    var pk2 = PointK(x: 10)
//    var pk3 = PointK(y: 10)
//    var pk4 = PointK(x: 10, y: 10)
}


// MARK: - 结构体自定义初始化器、本质
/// 一旦在结构体定义了初始化器，编译器就不会在帮我们自动生成其他初始化器
func structAndClassTest2() {
    
    // 自定义初始化器
//    struct PointT {
//        var x: Int = 0
//        var y: Int = 0
//        init(x: Int, y: Int) {
//            self.x = x
//            self.y = y
//        }
//    }
    
    struct PointT {
        var x: Int = 0
        var y: Int = 0
//        init() {
//            x = 0
//            y = 0
//        }
    }
    /*
     struct PointT {
         var x: Int = 0
         var y: Int = 0
     }
     */
    
    var pt1 = PointT()
    pt1.x = 1
    
    /*
     可以看到系统生成的初始化器方法和我们自己写的是一样的
     
     TestSwift`init() in PointT #1 in structAndClassTest2():
     ->  0x1000057a0 <+0>:  pushq  %rbp
         0x1000057a1 <+1>:  movq   %rsp, %rbp
         0x1000057a4 <+4>:  xorps  %xmm0, %xmm0
         0x1000057a7 <+7>:  movaps %xmm0, -0x10(%rbp)
         0x1000057ab <+11>: movq   $0x0, -0x10(%rbp)
         0x1000057b3 <+19>: movq   $0x0, -0x8(%rbp)
         0x1000057bb <+27>: movq   $0x0, -0x10(%rbp)
         0x1000057c3 <+35>: movq   $0x0, -0x8(%rbp)
         0x1000057cb <+43>: xorl   %eax, %eax
         0x1000057cd <+45>: movl   %eax, %ecx
         0x1000057cf <+47>: movq   %rcx, %rax
         0x1000057d2 <+50>: movq   %rcx, %rdx
         0x1000057d5 <+53>: popq   %rbp
         0x1000057d6 <+54>: retq
     
     
     TestSwift`init() in PointT #1 in structAndClassTest2():
     ->  0x1000057b0 <+0>:  pushq  %rbp
         0x1000057b1 <+1>:  movq   %rsp, %rbp
         0x1000057b4 <+4>:  xorps  %xmm0, %xmm0
         0x1000057b7 <+7>:  movaps %xmm0, -0x10(%rbp)
         0x1000057bb <+11>: movq   $0x0, -0x10(%rbp)
         0x1000057c3 <+19>: movq   $0x0, -0x8(%rbp)
         0x1000057cb <+27>: xorl   %eax, %eax
         0x1000057cd <+29>: movl   %eax, %ecx
         0x1000057cf <+31>: movq   %rcx, %rax
         0x1000057d2 <+34>: movq   %rcx, %rdx
         0x1000057d5 <+37>: popq   %rbp
         0x1000057d6 <+38>: retq
     */
    
    structAndClassTest2_1()
}

// 结构体内存结构
func structAndClassTest2_1() {
    struct PointT {
        var x: Int = 0
        var y: Int = 0
    }
    print(MemoryLayout<PointT>.size)        // 16
    print(MemoryLayout<PointT>.stride)      // 16
    print(MemoryLayout<PointT>.alignment)   // 8
    
    struct PointT1 {
        var x: Int = 10
        var y: Int = 20
        var origin: Bool = true
    }
    print(MemoryLayout<PointT1>.size)        // 17
    print(MemoryLayout<PointT1>.stride)      // 24
    print(MemoryLayout<PointT1>.alignment)   // 8
    
    print("--------------------------")
    var pt1 = PointT1()
    
    print(Mems.ptr(ofVal: &pt1))
    print(Mems.memStr(ofVal: &pt1))
}


// MARK: - 类
/// 类的定义和结构体类似，但编译器并没有为类自动生成可以传入成员值的初始化器
func structAndClassTest3() {
    
    class PointC {
        var x: Int = 0
        var y: Int = 0
    }
    let p1 = PointC()
    print(p1)
    
    
    /// 类的初始化器
    /// 如果类的所有成员都在定义的时候指定了初始值，编译器会为类生成无参的初始化器
    /// 成员的初始化是在这个初始化器中完成的
    
    /*
     下述两段代码完全等效
     class Point {
         var x: Int = 10
         var y: Int = 20
     }
     let p1 = Point()
     
     
     class Point {
         var x: Int = 10
         var y: Int = 20
         init() {
             x = 10
             y = 20
         }
     }
     let p1 = Point()
     */
}


// MARK: - 结构体和类的本质区别
/// 结构体是值类型(枚举也是值类型)，类是引用类型(指针类型)
func structAndClassTest4() {
    
    class Size {
        var width = 1
        var height = 2
    }
    
    struct Point {
        var x: Int = 3
        var y: Int = 4
    }
    
    var size = Size()
    var point = Point()
    
    print("size 变量的地址", Mems.ptr(ofVal: &size))
    print("size 变量的内存", Mems.memStr(ofVal: &size))
    
    print("------------------")
    
    print("size 变量所指向内存的地址", Mems.ptr(ofRef: size))
    print("size 变量所指向内存的内容",Mems.memStr(ofRef: size))
    
    print("------------------")
    
    print("point 变量的地址", Mems.ptr(ofVal: &point))
    print("point 变量的内存", Mems.memStr(ofVal: &point))
    
    
    print("------------------")
    
    let ptr = malloc(17)
    print(malloc_size(ptr))
}


// MARK: - 值类型
/// 结构体是值类型(枚举也是值类型)，类是引用类型(指针类型)
// 值类型赋值给 var、let 或者给函数传参，是直接将所有内容拷贝一份
// 类似于对文件进行 copy、paste 操作，产生了全新的文件副本。属于深拷贝
func structAndClassTest5() {
    
    struct Point {
        var x: Int
        var y: Int
    }
    /// 汇编层面分析值类型赋值原理
    
//    var p1 = Point(x: 10, y: 20)
//    var p2 = p1
//    print("---")
    
    structAndClassTest5_1()
}

func structAndClassTest5_1() {
    /// 值类型的赋值操作
    /*
     swift 标准库中，为了提升性能，String、Array、Dictionary、Set 采取了 Copy On Write 的技术
     - 比如仅当有 写 操作时，才会真正执行拷贝操作
     - 对于标准库值类型的赋值操作，swift 能确保最佳性能，所以没必要为了保证性能来避免赋值
     
     建议：不需要修改的，尽量定义成 let
     */
    
    struct Point {
        var x: Int
        var y: Int
    }
    var p1 = Point(x: 10, y: 20)
    print("p1 --- before --", Mems.ptr(ofVal: &p1))
    print("p1 --- before --", Mems.memStr(ofVal: &p1))
    
    var test = 10
    print("test --- before --", Mems.ptr(ofVal: &test))
    print("test --- before --", Mems.memStr(ofVal: &test))
    
    p1 = Point(x: 11, y: 22)
    print("p1 --- after --", Mems.ptr(ofVal: &p1))
    print("p1 --- after --", Mems.memStr(ofVal: &p1))
    
    /*
     p1 --- before --   0x00007ffeefbff4f0
     p1 --- before --   0x000000000000000a 0x0000000000000014
     test --- before -- 0x00007ffeefbff4e8
     test --- before -- 0x000000000000000a
     p1 --- after --    0x00007ffeefbff4f0
     p1 --- after --    0x000000000000000b 0x0000000000000016
     */
}


// MARK: - 引用类型
/// 引用赋值给 var、let 或者给函数传参，是将内存地址拷贝一份
// 类似于制作一个文件的替身，指向的是同一个文件。属于浅拷贝 (shallow copy)
func structAndClassTest6() {
    
    class Size {
        var width: Int
        var height: Int
        
        init(width: Int, height: Int) {
            self.width = width
            self.height = height
        }
    }
    
    let p1 = Size(width: 10, height: 20)
    let p2 = p1
    
    p2.width = 11
    p2.height = 22
    
    print("---")
    
    structAndClassTest6_1()
}

func structAndClassTest6_1() {
    
    /*
     对象的堆空间申请过程
     
     在 swift 中，创建类的实例对象，要向堆空间申请内存，流程如下
     - class.__allocation_init()
     - libswiftCore.dylib:_swift_allocObject_
     - libswiftCore.dylib:swift_slowAlloc
     - libsystem_malloc.dylib:malloc
     
     在 mac、iOS 中的 malloc 函数分配的内存大小总是 16 的倍数
     通过 class_getInstanceSize 可以得知：类对象至少需要占用多少内存
     */
    
//    class Point {
//        var x = 11  // 8
//        var test = true // 1
//        var y = 22  // 8
//    }
//    
//    let p = Point()
//    print(malloc_size(Mems.ptr(ofRef: p)))  // 48
//    
//    print(class_getInstanceSize(Point.self))    // 40
//    print(class_getInstanceSize(type(of: p)))   // 40
//    
//    print(MemoryLayout<Point>.size) // 8
//    print(MemoryLayout<Point>.stride)   // 8
//    print(MemoryLayout<Point>.alignment)    // 8
    
    
    /// 值类型、引用类型的 let
    /// 抓住重点：地址内容不可变
    
    
    /// 枚举、结构体、类都可以定义方法
    // 一般发定义在枚举、结构体、类内部的函数，叫做方法
    
    // 方法占用对象内存吗
    // - 不占用
    // - 方法的本质就是函数
    // - 方法、函数都存放在代码段
    
    test11()
}

func test11() {
    
    struct Point {
        var x: Int
        var b1: Bool
        var x1: Int
        var b2: Bool
        var b3: Bool
        var y: Int
    }
    
    var a = Point(x: 10, b1: true, x1: 11, b2: true, b3: true, y: 20)
    print(Mems.ptr(ofVal: &a))
    print(Mems.memStr(ofVal: &a))
    print("----")
    
    class Size {
        var width: Int
        var b1: Bool
        var height: Int
        var b2: Bool
        
        init(width: Int, b1: Bool, b2: Bool, height: Int) {
            self.width = width
            self.height = height
            self.b1 = b1
            self.b2 = b2
        }
    }
    
    var s = Size(width: 10, b1: true, b2: true, height: 20)
    print(Mems.ptr(ofVal: &s))
    print(Mems.memStr(ofVal: &s))
    
    print(Mems.ptr(ofRef: s))
    print(Mems.memStr(ofRef: s))
    
    print("----")
}
