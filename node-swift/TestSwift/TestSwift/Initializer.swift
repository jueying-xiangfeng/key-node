//
//  Initializer.swift
//  TestSwift
//
//  Created by wangxiangfeng on 2021/2/25.
//  Copyright © 2021 DiDi. All rights reserved.
//

import Foundation

/// 初始化器
///
/// 类、结构体、枚举都可以定义初始化器
/// 类有2种初始化器：指定初始化器（designated initializer）、便捷初始化器（convenience initializer）
///
/// - 每个类至少有一个指定初始化器，指定初始化器是类的主要初始化器
/// - 默认初始化器总是类的指定初始化器
/// - 类偏向于少量指定初始化器，一个类通常只有一个指定初始化器
///
/// - 初始化器的相互调用规则
///     - 指定初始化器必须从他的直系父类调用指定初始化器
///     - 便捷初始化器必须从相同的类里调用另一个初始化器
///     - 便捷初始化器最终必须调用一个指定初始化器
///
///
/// 两段式初始化、安全检查
///
/// 1、两段式初始化
/// - 第一阶段：初始化所有存储属性
///     - 外层调用指定\便捷初始化器
///     - 分配内存给实例，但未初始化
///     - 指定初始化器确保当前类定义的存储属性都初始化
///     - 指定初始化器调用父类的初始化器，不断向上调用，形成初始化器链
///
/// - 第二阶段：设置新的存储属性值
///     - 从顶部初始化器往下，链中的每一个指定初始化器都有机会进一步定制实例
///     - 初始化器现在能够使用self（访问、修改他的属性，调用他的实例方法等等）
///     - 最终，链中任何便捷初始化器都有机会定制实例以及使用self
///
/// 2、安全检查
/// - 指定初始化器必须保证在调用父类初始化器之前，其所在类定义的所有存储属性都要初始化完成
/// - 指定初始化器必须先调用父类初始化器，然后才能为继承的属性设置新值
/// - 便捷初始化器必须先调用同类中的其他初始化器，然后再为任意属性设置新值
/// - 初始化器在第一阶段初始化完成之前，不能调用任何实例方法、不能读取任何实例属性的值，也不能引用self
/// - 直到第一阶段结束，实例才算完全合法
///
func initializerTest1() {
    
    class Animal {
        var age: Int = 0
        init(age: Int) {
            self.age = age
        }
        
        convenience init() {
            self.init(age: 0)
        }
    }
    class Dog : Animal {
        var weight: Int = 0
        
        init(weight: Int, age: Int) {
            self.weight = weight
            super.init(age: age)
        }
        
        convenience init(weight: Int) {
            self.init(weight: weight, age: 0)
        }
        
        func test() {
            
        }
    }
    
    var dog = Dog(weight: 10, age: 1)
    
    Dog(weight: 11)
    
    print(dog.weight, dog.age)
}


func initializerTest2() {
    
    class Animal {
        var age: Int = 0
        init(age: Int) {
            self.age = age
        }
        
//        convenience init() {
//            self.init(age: 0)
//        }
    }
    class Dog : Animal {
        var weight: Int = 0
        
        init(weight: Int, age: Int) {
            self.weight = weight
            super.init(age: age)
        }
        
//        override init(age: Int) {
//            self.weight = 0
//            super.init(age: age)
//        }
        
        override convenience init(age: Int) {
            self.init(weight: 0, age: age)
        }
    }
    
    var dog = Dog(weight: 10, age: 1)
//
//    Dog(weight: 11)
//
    print(dog.weight, dog.age)
    
    
}
