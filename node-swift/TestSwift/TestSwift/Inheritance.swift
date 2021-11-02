//
//  Inheritance.swift
//  TestSwift
//
//  Created by wangxiangfeng on 2021/2/24.
//  Copyright © 2021 DiDi. All rights reserved.
//

import Foundation

func separatorLog() {
    print("---------------------")
}


/// 值类型（枚举、结构体）不支持继承，只有类支持继承
///
/// 没有父类的类称为基类
/// swift 没有像 OC、Java 那样的规定：任何类最终都要继承自某个基类
///
/// 子类可以重写父类的 下标、方法、属性。重写必须加上 override 关键字
///

/// 内存结构
func inheritanceTest1() {
    
    class Animal {
        var age = 0
    }
    class Dog : Animal {
        var weight = 0
    }
    class ErHa : Dog {
        var iq = 0
    }
    
    let a = Animal()
    a.age = 10
    
    print(Mems.size(ofRef: a))
    print(Mems.memStr(ofRef: a))
    separatorLog()
    
    let d = Dog()
    d.age = 10
    d.weight = 20
    print(Mems.size(ofRef: d))
    print(Mems.memStr(ofRef: d))
    separatorLog()
    
    let e = ErHa()
    e.age = 10
    e.weight = 20
    e.iq = 30
    print(Mems.size(ofRef: e))
    print(Mems.memStr(ofRef: e))
    separatorLog()
    
    var e1 = ErHa()
    print(Mems.size(ofVal: &e1))
    print(Mems.memStr(ofVal: &e1))
    
    print(Mems.memStr(ofRef: e1))
}

/// 重写实例方法、下标
func inheritanceTest2() {
    class Animal {
        func speak() {
            print("Animal speak")
        }
        subscript(index: Int) -> Int {
            return index
        }
    }
    
    class Cat : Animal {
        override func speak() {
            super.speak()
            print("Cat speak")
        }
        override subscript(index: Int) -> Int {
            return super[index] + 1
        }
    }
    
    var anim: Animal
    anim = Animal()
    anim.speak()
    print(anim[6])
    separatorLog()
    
    anim = Cat()
    anim.speak()
    print(anim[6])  // 7
}

/// 重写类型方法、下标
///
/// 被 class 修饰的类型方法、下标，允许被子类重写
/// 被 static 修饰的类型方法、下标，不允许被子类重写
///
func inheritanceTest3() {
    class Animal {
        class func speak() {
            print("Animal speak")
        }
        class subscript(index: Int) -> Int {
            return index
        }
    }
    
    class Cat : Animal {
        override class func speak() {
            super.speak()
            print("Cat speak")
        }
        override class subscript(index: Int) -> Int {
            return super[index] + 1
        }
    }
    
    Animal.speak()
    print(Animal[6])
    separatorLog()
    
    Cat.speak()
    print(Cat[6])
}


/// 重写属性
///
/// - 子类可以将父类的属性（存储、计算）重写为【计算属性】
/// - 子类不可以将父类属性重写为【存储属性】
/// - 只能重写 var 属性，不能重写 let 属性
/// - 重写时，属性名、类型要一致
/// - 子类重写后的属性权限 不能小于 父类属性的权限
///     - 如果父类属性是只读的，那么子类重写后的属性可以是只读的、也可以是可读可写的
///     - 如果父类属性是可读写的，那么子类重写后的属性也必须是可读写的
///
func inheritanceTest4() {
    // 重写实例属性
//    inheritanceTest4_1()
    // 重写类型属性
//    inheritanceTest4_2()
    // 属性观察器
    inheritanceTest4_3()
}

/// 重写实例属性
func inheritanceTest4_1() {
    class Circle {
        let a: Int = 0
        var radius: Int = 0
        var diameter: Int {
            set {
                print("Circle setDiameter")
                radius = newValue / 2
            }
            get {
                print("Circle getDiameter")
                return radius * 2
            }
        }
    }
    
    class SubCircle : Circle {
        override var radius: Int {
            set {
                print("SubCircle setRadius")
                super.radius = newValue > 0 ? newValue : 0
            }
            get {
                print("SubCircle getRadius")
                return super.radius
            }
        }
        override var diameter: Int {
            set {
                print("SubCircle setDiameter")
                super.diameter = newValue > 0 ? newValue : 0
            }
            get {
                print("SubCircle getDiameter")
                return super.diameter
            }
        }
    }
    
    var circle: Circle
    circle = Circle()
    circle.radius = 6
    // Circle getDiameter
    // 12
    print(circle.diameter)
    // Circle setDiameter
    // 10
    circle.diameter = 20
    print(circle.radius)
    
    separatorLog()
    
    circle = SubCircle()
    // SubCircle setRadius
    circle.radius = 6
    // SubCircle getDiameter
    // Circle getDiameter
    // SubCircle getRadius
    // 12
    print(circle.diameter)
    // SubCircle setDiameter
    // Circle setDiameter
    // SubCircle setRadius
    circle.diameter = 20
    // SubCircle getRadius
    // 10
    print(circle.radius)
}

/// 重写类型属性
///
/// 被 class 修饰的计算类型属性，可以被子类重写
/// 被 static 修饰的类型属性（存储、计算），不可以被子类重写
///
func inheritanceTest4_2() {
    class Circle {
        static var radius: Int = 0
        class var diameter: Int {
            set {
                print("Circle setDiameter")
                radius = newValue / 2
            }
            get {
                print("Circle getDiameter")
                return radius * 2
            }
        }
    }
    class SubCircle: Circle {
        override static var diameter: Int {
            set {
                print("SubCircle setDiameter")
                super.diameter = newValue > 0 ? newValue : 0
            }
            get {
                print("SubCircle getDiameter")
                return super.diameter * 2
            }
        }
    }
    
    Circle.radius = 6
    // Circle getDiameter
    // 12
    print(Circle.diameter)
    // Circle setDiameter
    Circle.diameter = 20
    // 10
    print(Circle.radius)
    
    separatorLog()
    
    
    SubCircle.radius = 6
    // SubCircle getDiameter
    // Circle getDiameter
    // 12
    print(SubCircle.diameter)
    // SubCircle setDiameter
    // Circle setDiameter
    SubCircle.diameter = 20
    // 10
    print(SubCircle.radius)
}

/// 属性观察器
///
/// 可以在子类中为父类属性（除了只读计算属性、let 属性）增加属性观察器
///
/// 被 final 修饰的方法、下标、属性 禁止被重写
/// 被 final 修饰的类 禁止被继承
///
func inheritanceTest4_3() {
    class Circle {
        var radius: Int = 1 {
            willSet {
                print("Circle willSetRadius", newValue)
            }
            didSet {
                print("Circle didSetRadius", oldValue, radius)
            }
        }
    }
    class SubCircle : Circle {
        override var radius: Int {
            willSet {
                print("SubCircle willSetRadius", newValue)
            }
            didSet {
                print("SubCircle didSetRadius", oldValue, radius)
            }
        }
    }
    
    let circle = SubCircle()
    // SubCircle willSetRadius 10
    // Circle willSetRadius 10
    // Circle didSetRadius 1 10
    // SubCircle didSetRadius 1 10
    circle.radius = 10
    
    separatorLog()
    
    
    class Circle1 {
        var radius: Int {
            set {
                print("Circle setRadius", newValue)
            }
            get {
                print("Circle getRadius")
                return 20
            }
        }
    }
    class SubCircle1 : Circle1 {
        override var radius: Int {
            willSet {
                print("SubCircle willSetRadius", newValue)
            }
            didSet {
                print("SubCircle didSetRadius", oldValue, radius)
            }
        }
    }
    
    let circle1 = SubCircle1()
    // Circle getRadius
    // SubCircle willSetRadius 10
    // Circle setRadius 10
    // Circle getRadius
    // SubCircle didSetRadius 20 20
    circle1.radius = 10
    
    separatorLog()
    
    
    class Circle2 {
        class var radius: Int {
            set {
                print("Circle setRadius", newValue)
            }
            get {
                print("Circle getRadius")
                return 20
            }
        }
    }
    class SubCircle2 : Circle2 {
        override static var radius: Int {
            willSet {
                print("SubCircle willSetRadius", newValue)
            }
            didSet {
                print("SubCircle didSetRadius", oldValue, radius)
            }
        }
    }
    // Circle getRadius
    // SubCircle willSetRadius 10
    // Circle setRadius 10
    // Circle getRadius
    // SubCircle didSetRadius 20 20
    SubCircle2.radius = 10
}

/// 多态的实现原理
///
/// - OC: runtime
/// - C++: 虚表（虚函数表）
///
/// swift 中多态的实现原理
///
func inheritanceTest5() {
    
    // 结构体
//    struct Person {
//        func speak() {
//            print("Person speak")
//        }
//        func eat() {
//            print("Person eat")
//        }
//        func sleep() {
//            print("Person sleep")
//        }
//    }
//
//    let p = Person()
//    p.speak()
//    p.eat()
//    p.sleep()
//    
//    separatorLog()
    
//    class Animal {
//        func speak() {
//            print("Animal speak")
//        }
//        func eat() {
//            print("Animal eat")
//        }
//        func sleep() {
//            print("Animal sleep")
//        }
//    }
//    
//    class Dog : Animal {
//        override func speak() {
//            print("Dog speak")
//        }
//        override func eat() {
//            print("Dog eat")
//        }
////        override func sleep() {
////            print("Dog sleep")
////        }
//    }
//    
//    var anim = Animal()
//    anim.speak()
//    anim.eat()
//    anim.sleep()
//    
////    separatorLog()
//    
////    anim = Dog()
////    anim.speak()
////    anim.eat()
////    anim.sleep()
//    
}
