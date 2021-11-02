//: [Previous](@previous)


/*:
## 1. 可选项
 
 - 可选项，一般也称为可选类型，它允许将值设置为 nil
 - 在类型名称后面加个问号 ? 来定义一个可选项
*/
var a: String? = "key"
a = nil

var b: Int? = 3
b = nil

var array = [1, 2, 3]
func get(_ index: Int) -> Int? {
    if index < 0 || index >= array.count {
        return nil
    }
    return array[index]
}
print(get(1) as Any)    // Optional(2)
print(get(-1) as Any)   // nil
print(get(5) as Any)    // nil



/*:
## 2. 强制解包 (Forced Unwrapping)
 
 可选项是对其他类型的一层包装，可以将它理解为一个盒子
 - 如果为 nil，那么他是个空盒子
 - 如果不为 nil，那么盒子里面装的是：被包装类型的数据
*/
var a1: Int? // 默认为 nil
a1 = 10
a1 = nil


// 如果要从可选项中取出被包装的数据（将盒子里面装的数据取出来），需要使用感叹号 ! 进行强制解包
var a2: Int? = 10
var a22: Int = a2!
a22 += 10

// 如果对值为 nil 的可选项（空盒子）进行强制解包，将会产生运行时错误
// Fatal error: Unexpectedly found nil while unwrapping an Optional value
//var a3: Int?
//a3!


// 判断可选项是否包含值
let a4 = Int("123")
if a4 != nil {
    print("不为空 -- \(a4!)")
} else {
    print("a4 为空")
}


/*:
## 3. 可选项绑定 (Optional Binding)
 
 可以使用可选项绑定来判断可选项是否包含值
 - 如果包含就自动解包，把值赋给一个临时的常量(let)或者变量(var)，并返回true，否则返回false
*/
let a5 = Int("123")
if let number = a5 {
    print("--- \(number)")
} else {
    print("字符串转整数失败")
}

enum Season11 : Int {
    case spring = 1, summer, autumn, winter
}

if let season = Season11(rawValue: 6) {
    switch season {
    case .spring:
        print("season is spring")
    default:
        print("season is other")
    }
} else {
    print("no sucn season")
}

// 等价写法
if let first = Int("4") {
    if let second = Int("42") {
        if first < second && second < 100 {0
            print("成功 -- \(first) -- \(second)")
        }
    }
}

if let first = Int("4"),
    let second = Int("42"),
    first < second && second < 100 {
        print("成功 -- \(first) -- \(second)")
}


// while 循环使用可选项绑定

// 要求：遇到正数直接相加，遇到负数或者非数字，停止遍历
var strs = ["10", "11", "abc", "-11", "-20", "30"]
var index = 0
var sum = 0
while let values = Int(strs[index]), values > 0 {
    sum += values
    index += 1
}
print(sum)


/*:
## 4. 空合并运算符 ?? (Nil - Coalescing Operator)
 
 官方方法定义：
 public func ?? <T>(optional: T?, defaultValue: @autoclosure () throws -> T) rethrows -> T
 public func ?? <T>(optional: T?, defaultValue: @autoclosure () throws -> T?) rethrows -> T?
 
 
 使用：a ?? b
 - a 是可选项
 - b 是可选项 或者 不是可选项
 - b 跟 a 的存储类型必需相同
 - 如果 a 不为 nil，就返回 a
 - 如果 a 为 nil 就返回 b
 - 如果 b 不是可选项，返回 a 时会自动解包
*/

// - s3 是 Int? Optional(1)
let s1: Int? = 1
let s2: Int? = 2
let s3 = s1 ?? s2
print(s3!)

// - s33 是 Int? Optional(2)
let s11: Int? = nil
let s22: Int? = 2
let s33 = s11 ?? s22
print(s33!)

// - s333 是 Int? nil
let s111: Int? = nil
let s222: Int? = nil
let s333 = s111 ?? s222
print(s333 as Any)

// - s3333 是 Int, 1
let s1111: Int? = 1
let s2222: Int = 2
let s3333 = s1111 ?? s2222
print(s3333)

// - s33333 是 Int, 2
let s11111: Int? = nil
let s22222: Int = 2
let s33333 = s11111 ?? s22222
print(s33333)


// 多个 ?? 一起使用

// d3 为 Int, 1
let d1: Int? = 1
let d2: Int? = 2
let d3 = d1 ?? d2 ?? 3

// d33 为 Int, 2
let d11: Int? = nil
let d22: Int? = 2
let d33 = d11 ?? d22 ?? 3

// d332 为 Int, 3
let d111: Int? = nil
let d222: Int? = nil
let d333 = d111 ?? d222 ?? 3



// ?? 跟 if let 配合使用
let q1: Int? = nil
let q2: Int? = 2
// 类似于 if a != nil || b != nil
if let temp = q1 ?? q2 {
    print("temp == \(temp)")
}
// if a != nil && b != nil
if let temp1 = q1, let temp2 = q2 {
    print("----\(temp1)-- \(temp2)")
}



// if 语句实现登陆
func login1(_ info: [String : String]) {
    let userName: String
    if let temp = info["username"] {
        userName = temp
    } else {
        print("用户名不正确")
        return
    }
    let password: String
    if let temp = info["password"] {
        password = temp
    } else {
        print("密码不正确")
        return
    }
    print("用户名:\(userName) -- 密码:\(password)")
}
login1(["username" : "key", "password" : "123"])
login1(["username1" : "key1", "password1" : "123"])


/*:
## 5. guard 语句
 
 - 当 guard 语句条件为 false 时，就会执行大括号里面的代码
 - 当 guard 语句条件为 true 时，就会跳过 guard 语句
 
 
 guard condition else {
    // do something
    退出当前作用域
    // return、break、continue、throw error
 }
*/
// 当使用 guard 语句进行可选项绑定时，绑定的常量(let)、变量(var)也能在外层作用域使用
func login2(_ info: [String : String]) {
    guard let username = info["username"] else {
        print("username 不正确")
        return
    }
    guard let password = info["password"] else {
        print("password 不正确")
        return
    }
    print("username: \(username) -- password: \(password)")
}

login2(["username" : "key", "password" : "123"])
login2(["username1" : "key1", "password1" : "123"])




/*:
## 6. 隐式解包 (Implicitly Unwrapped Optional)
 
 - 在某些情况下，可选项一旦被设定只之后，就会一直拥有值
 - 在这种情况下，可以去掉检查，也不必每次访问的时候都进行解包，因为它能确定每次访问的时候都有值
 - 可以在类型后面加个感叹号! 定义一个隐式解包可选项
*/
let n1: Int! = 10
let n2: Int = n1
if n1 != nil {
    
}
if let temp = n1 {
    print("隐式解包 temp -- \(temp)")
}

// 注意，这里需要隐式解包的变量不能为 nil
// Fatal error: Unexpectedly found nil while implicitly unwrapping an Optional value
//let n11: Int! = nil
//let n22: Int = n11



/*:
## 7. 字符串插值
 
 可选项在字符串插值或者直接打印时，编译器会发出警告
*/
var c1: Int? = 10
print(c1)
print("c1 == \(c1)")

// 消除警告方法
// - 1
print("c1 == \(String(describing: c1))")

// -2
print("c1 == \(c1!)")

// -3
print("c1 == \(c1 ?? 0)")


/*:
## 8. 多重可选项
 
 可以使用 lldb 指令: frame Variable -R (fr v -R) 查看区别
*/

/*
 (Swift.Optional<Swift.Int>) r1 = some {
   some = {
     _value = 10
   }
 }
 */
var r1: Int? = 10

/*
 (Swift.Optional<Swift.Optional<Swift.Int>>) r2 = some {
   some = some {
     some = {
       _value = 10
     }
   }
 }
 */
var r2: Int?? = r1

/*
 (Swift.Optional<Swift.Optional<Swift.Int>>) r3 = some {
   some = some {
     some = {
       _value = 10
     }
   }
 }
 */
var r3: Int?? = 10

print(r2 == r3)

/*
 (Swift.Optional<Swift.Int>) r11 = none {
   some = {
     _value = 0
   }
 }
 */
var r11: Int? = nil

/*
 (Swift.Optional<Swift.Optional<Swift.Int>>) r22 = some {
   some = none {
     some = {
       _value = 0
     }
   }
 }
 */
var r22: Int?? = r11

/*
 (Swift.Optional<Swift.Optional<Swift.Int>>) r33 = none {
   some = some {
     some = {
       _value = 0
     }
   }
 }
*/
var r33: Int?? = nil

print(r22 == r33)
print(r11 == r33)

(r22 ?? 1) ?? 2
(r33 ?? 1) ?? 2



//: [Next](@next)
