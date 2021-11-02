//
//  Method.swift
//  TestSwift
//
//  Created by wangxiangfeng on 2021/2/20.
//  Copyright © 2021 DiDi. All rights reserved.
//

import Foundation

/// 枚举、结构体、类都可以定义实例方法、类型方法
///
/// - 实例方法（Instance Method）：通过实例对象调用
/// - 类型方法（Type Method）：通过类型调用，用 static 或者 class 关键字定义
///
/// self：
/// - 在实例方法中代表实例对象
/// - 在类型方法中代表类型
///
/// 在类型方法 static func getCount 中
/// - count 等价于 self.count、Car.self.count、Car.count
///
func methodTest1() {
    class Car {
        static var count = 0
        /// @discardableResult 可以消除：函数调用返回值未被使用的警告
        @discardableResult
        init() {
            Car.count += 1
        }
        static func getCount() -> Int { count }
    }
    Car()
    Car()
    Car()
    print(Car.getCount())
    
    
    /// 结构体和枚举是值类型，默认情况下，值类型的属性不能被自身的实例方法修改
    ///
    /// - 在 func 关键字前加 mutating 可以允许这种修改行为
    ///
    struct Point {
        var x = 0
        var y = 0
        
        mutating func moveBy(deltaX: Int, deltaY: Int) {
            x += deltaX
            y += deltaY
        }
    }
    var p = Point()
    print(p.x, p.y)
    
    p.moveBy(deltaX: 10, deltaY: 20)
    print(p.x, p.y)
    
    
    enum StateSwitch {
        case low, middle, high
        
        mutating func next() {
            switch self {
            case .low:
                self = .middle
            case .middle:
                self = .high
            case .high:
                self = .low
            }
        }
    }
}
