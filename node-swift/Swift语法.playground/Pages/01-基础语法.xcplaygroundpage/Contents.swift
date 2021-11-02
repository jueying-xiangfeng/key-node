import Foundation


/*:
 ## 1. 常量
 1. 只能赋值一次
 2. 它的值不要求在编译期间确定，但使用之前必须赋值一次
 3. 常量、变量在初始化之前，都不能使用
 */

// 1
let age1 = 10
let age2: Int
age2 = 10

// 2
func getAge() -> Int {
    return 10
}
let age3 = getAge()

// 3
let age: Int
var height: Int

age = 10
height = age

print(age)
print(height)


/*:
## 2. 标识符
1. 标识符(常量名、变量名、函数名)几乎可以使用任何字符
2. 标识符不能以数字开头，不能包含空白符、制表符、箭头等特殊字符
*/
func  🏀🏀() {
    print("666")
}
🏀🏀()


/*:
## 3. 常见数据类型
### 值类型 (value type)
 - 枚举(enum): Optional
 - 结构体(struct): Bool、Int、Float、Double、Character、String、Array、Dictionary、Set
 
### 引用类型 (reference type)
 - 类(class)
 
 
 ### 总结
 - 整数类型: Int8、Int16、Int32、Int64、UInt8、UInt16、UInt32、UInt64
 - 在32Bit平台，Int等价于32；在64Bit平台，Int等价于Int64
 - 整数的最值: UInt8.max、Int16.min
 - 一般情况都是用Int即可
 - 浮点类型: Float 32位，精度只有6位。Double 64位，精度至少15位
*/
let letFloat = 30.0
let letDouble = 30.01



/*:
## 4. 字面量
 
 整数或者浮点数可以添加额外的零或者下划线来增加可读性
 100_0000   100_0000_0000.0000_0000_1   000123.456
*/

// Bool
let bool: Bool = true

// 字符串
let string: String = "字符串"

// 字符(可存储ASCII字符、Unicode字符)
let character: Character = "a"

// 整数
let intDecimal = 17         // 十进制
let intBinary = 0b10001     // 二进制
let intOctal = 0o21         // 八进制
let intHexadecimal = 0x11   // 十六进制

let i = 0000_0017

// 浮点数
let doubleDecimal = 125.0       // 十进制，等价于 1.25e2，0.0125等价于1.25e-2
let doubleHexadecimal1 = 0xFp2   // 十六进制，15*2^2，相当于十进制的60
let doubleHexadecimal2 = 0xFp-2  // 十六进制，15*2^-2，相当于十进制 3.75

// 数组
let array = [1, 2, 3]

// 字典
let dictionary = ["age" : 18, "height" : 122]

let dictionary1: Dictionary<String, Any> = [:]
let keys = dictionary1.keys
print(keys, keys.count)


/*:
## 5. 类型转换
*/

// 整数转换
let int1: UInt16 = 2_000
let int2: UInt8 = 1
let int3 = int1 + UInt16(int2)

// 整数、浮点数转换
let int = 3
let double = 0.14159
let pi = Double(int) + double
let intPi = Int(pi)

// 字面量可以直接相加，因为数字字面量本身没有明确的类型
let result = 3 + 0.14159

/*:
 ## 6, 元组
 */
let http404Error = (404, "Not Found")
print("status code is \(http404Error.0)")

let (statusCode, statusMessage) = http404Error
print("status code is \(statusCode)")

let (justStatusCode, _) = http404Error

let http200Status = (statusCode: 200, statusMessage: "OK")
print("status code is \(http200Status.statusCode)")

//: [Next](@next)



// 单行注释

/*
 多行注释
 /*
 多行注释
 */
 
 markup语法
 ## 二级标题
 ### 三级标题
 */


//: # 一级标题

/*:
 # 学习Swift
 ## 基础语法
 - 变量
 - 常量
 ## 面向对象
 1. 类
 2. 属性
 3. 方法
 ## 汇编分析
 
 [苹果官方](https://www.apple.com)
 */

//: [下一页](@next)
//: [上一页](@previous)
