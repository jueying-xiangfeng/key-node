//
//  Subscript.swift
//  TestSwift
//
//  Created by wangxiangfeng on 2021/2/20.
//  Copyright © 2021 DiDi. All rights reserved.
//

import Foundation


/// 使用 subscript 可以个任意类型（枚举、结构体、类）增加下标功能 - （下标脚本）
///
/// - subscript 语法类似于实例方法、计算属性，本质就是方法（函数）
///
func subscriptTest1() {
    
    class Point {
        var x = 0.0, y = 0.0
        
        /// subscript 中定义的返回值类型决定了
        ///
        /// - get 方法的返回值类型
        /// - set 方法中 newValue 的类型
        ///
        /// subscript 可以接受多个参数，并且类型任意
        ///
        subscript(index: Int) -> Double {
            set {
                if index == 0 {
                    x = newValue
                } else {
                    y = newValue
                }
            }
            get {
                if index == 0 {
                    return x
                } else {
                    return y
                }
            }
        }
    }
    
    let p = Point()
    p[0] = 11.1
    p[1] = 22.2
    
    print(p.x)
    print(p.y)
    
    print(p[0])
    print(p[1])
    
    /// 下标的细节：
    
    /// subscript 可以没有 set 方法，但必须要有 get 方法
    /// 如果只有 get 方法，可以省略 get
    
    class Point1 {
        var x = 0, y = 0
        subscript(index: Int) -> Int {
            get {
                if index == 0 {
                    return x
                } else if index == 1 {
                    return y
                }
                return 0
            }
        }
    }
    
    class Point2 {
        var x = 0, y = 0
        subscript(index: Int) -> Int {
            if index == 0 {
                return x
            } else if index == 1 {
                return y
            }
            return 0
        }
    }
    
    /// 可以设置参数标签
    class Point3 {
        var x = 0, y = 0
        subscript(index i: Int) -> Int {
            if i == 0 {
                return x
            } else if i == 1 {
                return y
            }
            return 0
        }
    }
    let p3 = Point3()
    p3.y = 22
    print(p3[index: 1])
    
    /// 下标可以是类型方法
    class Sum {
        static subscript(v1: Int, v2: Int) -> Int {
            return v1 + v2
        }
    }
    print(Sum[10, 20])
    
    
    /// 结构体、类作为返回值对比
    class Size {
        var x = 0, y = 0
    }
    class SizeManager {
        var size = Size()
        subscript(index: Int) -> Size {
            get { size }
        }
    }
    let sizeManager = SizeManager()
    sizeManager[0].x = 11
    sizeManager[0].y = 22
    
    print(sizeManager[0])
    print(sizeManager.size)
    
    struct Size1 {
        var x = 0, y = 0
    }
    class SizeManager1 {
        var size = Size1()
        subscript(index: Int) -> Size1 {
            get { size }
            set {
                size = newValue
            }
        }
    }
    let sizeManager1 = SizeManager1()
    sizeManager1[0].x = 11
    sizeManager1[0].y = 22
    
    print(sizeManager1[0])
    print(sizeManager1.size)
    
    
    /// 接收多个参数的下标
    class Grid {
        var data = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8]
        ]
        subscript(row: Int, column: Int) -> Int {
            set {
                guard row >= 0 && row < 3 && column >= 0 && column < 3 else {
                    return
                }
                data[row][column] = newValue
            }
            get {
                guard row >= 0 && row < 3 && column >= 0 && column < 3 else {
                    return 0
                }
                return data[row][column]
            }
        }
    }
    let grid = Grid()
    grid[0, 0] = 77
    grid[1, 1] = 88
    grid[2, 2] = 99
    print(grid.data)
}
