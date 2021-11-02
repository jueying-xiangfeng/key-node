//
//  Property.swift
//  TestSwift
//
//  Created by Key on 2020/8/22.
//  Copyright © 2020 阅文. All rights reserved.
//

import Foundation

// MARK: - 属性
///
/// swift 中跟实例相关的属性可以分为两类
///
/// 1、存储属性 - Stored Property
/// - 类似于成员变量这个概念
/// - 存储在实例的内存中
/// - 结构体、类可以定义存储属性
/// - 枚举不可以定义存储属性
///
/// 2、计算属性 Computed Property
/// - 本质就是方法 (函数)
/// - 不占用实例的内存
/// - 枚举、结构体、类都可以定义属性
///
func propertyTest1() {
    
    /// - 存储属性
    /// 关于存储属性，swift 有个明确规定
    /// 在创建类 或者 结构体的实例时，必需为所有的存储属性设置一个合适的初始值
    /// 可以在初始化器里为存储属性设置一个初始值
    /// 可以分配一个默认的属性值作为属性定义的一部分
    ///
    struct Circle {
        /// 存储属性
        var radius: Double
        /// 计算属性
        var diameter: Double {
            set {
                radius = newValue / 2
            }
            get {
                radius * 2
            }
        }
    }
    
    var circle = Circle(radius: 5)
    print(circle.radius)
    print(circle.diameter)
    
    circle.diameter = 12
    print(circle.radius)
    print(circle.diameter)
    
    
    /// - 计算属性
    /// set 传入的新值默认叫做 newValue，也可以自定义
    /// 定义计算属性只能用 var，不能用 let
    /// let 代表常量：值是一成不变的
    /// 计算属性的值可能发生变化 (即使是只读计算属性)
    /// 只读计算属性：只有 get，没有 set
    ///
    struct Circle1 {
        /// 存储属性
        var radius: Double
        /// 计算属性
        var diameter: Double {
            set (newDiameter) { // 自定义名称
                radius = newDiameter / 2
            }
            get {
                radius * 2
            }
        }
    }
    struct Circle2 {
        var radius: Double
//        var diameter: Double { // 只读属性
//            get {
//                radius * 2
//            }
//        }
        var diameter: Double { radius * 2 }
    }
}


// MARK: - 枚举 rawValue 原理
/// 枚举原始值 rawValue 的本质是：
/// 只读计算属性
///
func propertyTest2() {
    /// 原始值
    enum Season : Int {
        case spring = 1, summer, autumn, winter
        
        var rawValue: Int {
            switch self {
            case .spring:
                return 11
            case .summer:
                return 22
            case .autumn:
                return 33
            case .winter:
                return 44
            }
        }
    }
    
    var s = Season.spring
    s = Season.summer
    
    print(s.rawValue, "---",
          MemoryLayout.size(ofValue: s), "---",
          MemoryLayout.stride(ofValue: s), "---",
          MemoryLayout.alignment(ofValue: s))
}


// MARK: - 延迟存储属性 (Lazy Stored Property)
///
/// 使用 lazy 可以定一个延迟存储属性，在第一次用到属性的时候才会进行初始化
///
/// - lazy 属性必需是 var，不能是 let (let 必需在实例的初始化方法完成之前就拥有值)
/// - 如果多条线程同时第一次访问 lazy 属性 (无法保证属性只被初始化一次)
///
func propertyTest3() {
    
    class Car {
        init() {
            print("car init")
        }
        func run() {
            print("car is running")
        }
    }
    
    class Person {
        lazy var car = Car()
        init() {
            print("Person init")
        }
        func goOut() {
            car.run()
        }
    }
    
    let p = Person()
    print("---------")
    p.goOut()
    
    
//    class PhotoView {
//        lazy var image: Image = {
//            let url = ""
//            let data = Data(url: url)
//            return Image(data: data)
//        }()
//    }
    
    
    ///
    /// 延迟存储属性注意点
    /// 当结构体包含一个延迟存储属性时，只有 var 才能访问延迟存储属性
    /// 因为延迟属性初始化时需要改变结构体的内存
    ///
    struct Point {
        var x = 0
        var y = 0
        lazy var z = 0
    }
    
//    let pt = Point()
//    pt.z
}



// MARK: - 属性观察器、inout
///
/// 属性观察器、计算属性的功能，同样可以应用在全局变量、局部变量身上
///
func propertyTest4() {
    
    struct Shape {
        var width: Int
        var side: Int {
            willSet {
                print("willSet -- ", newValue)
            }
            didSet {
                print("didSet -- ", oldValue, side)
            }
        }
        var girth: Int {
            set {
                width = newValue / side
                print("setGirth", newValue)
            }
            get {
                print("getGirth")
                return width * side
            }
        }
        func show() {
//            let a1 = width + 2
//            let a2 = side
//            let a3 = girth + 
            
            print("width=\(width), side=\(side), girth=\(girth)")
        }
    }
    
    
    func test(_ num: inout Int) {
        print("test")
        num = 20
    }
    
    var s = Shape(width: 10, side: 4)
//    s.side = 11
//    test(&s.width)
    
//    test(&s.side)
//    s.show()
    
//    let aaa = s.girth
    
    
    test(&s.girth)
    
    
    ///
    /// inout 本质总结
    ///
    /// 1、如果实参有物理内存地址，且没有设置属性观察器
    /// - 直接将实参的内存地址传入函数 (实参进行引用传递)
    ///
    /// 2、如果实参是计算属性 或者 设置了属性观察器
    /// - 采取了 Copy In Copy Out 的做法
    /// - 调用该函数时，先复制实参的值，产生副本 (汇编：放到局部变量里面) (【get】)
    /// - 将副本的内存地址传入函数 (将副本进行引用传递)，在函数内部可以修改副本的值
    /// - 函数返回后，再将副本的值覆盖实参的值 (【set】)
    ///
    /// 总结：inout 的本质就是引用传递 (地址传递)
    ///
}


// MARK: - 类型属性 (Type Property)
///
/// 严格来说，属性可以分为
///
/// 1、实例属性 (Instance Property)：只能通过实例去访问
/// - 存储实例属性 (Stored Instance Property)：存储在实例的内存中，每个实例都有一份
/// - 计算实例属性 (Computed Instance Property)
///
/// 2、类型属性 (Type Property)：只能通过类型去访问
/// - 存储类型属性 (Stored Type Property)：整个程序运行过程中，就只有一份内存 (类似于全局变量)
/// - 计算类型属性 (Computed Type Property)
///
/// 3、可以通过 static 定义类型属性
/// - 如果是类，也可以用关键字 class
///
///
/// 类型属性细节
/// 1、不同于存储实例属性，必需给存储类型属性设定初始值
/// - 因为类型没有像实例那样的 init 初始化器来初始化存储属性
///
/// 2、存储类型属性 默认就是 lazy，会在第一次使用的时候初始化
/// - 就算被多个线程同时访问，保证只会初始化一次
/// - 存储类型属性可以是 let
///
/// 3、枚举类型也可以定义类型属性 (存储类型属性、计算类型属性)
///
func propertyTest5() {
    
    struct Car {
        static var count: Int = 0
        init() {
            Car.count += 1
        }
    }
    
    let c1 = Car()
    let c2 = Car()
    let c3 = Car()
    
    print(c1, c2, c3, Car.count)
    
    
    ///
    /// 单例模式
    ///
    class FileManger {
        public static let shared = FileManger()
        private init() {  }
    }
    
    class FileManger1 {
        public static let shared1 = {
            ///
            /// ...
            /// ...
            ///
            return FileManger1()
        }()
        private init() {
            
        }
    }
}
