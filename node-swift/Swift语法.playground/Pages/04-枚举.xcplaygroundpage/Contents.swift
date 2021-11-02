//: [Previous](@previous)


/*:
## 1. 枚举基本使用
*/
enum DirectionUse {
    case north
    case south
    case east
    case west
}

enum DirectionUse1 {
    case north, south, east, west
}

var dirUse = DirectionUse1.west
dirUse = DirectionUse1.east
dirUse = .north
print(dirUse)

switch dirUse {
    case .north:
        print("north")
    case .south:
        print("south")
    case .east:
        print("east")
    case .west:
        print("west")
}


/*:
## 2. 关联值 (Associated Values)
 
 !!!：将【枚举的成员值】和【其他类型的值】关联存储在一起
*/
enum ScoreUse {
    case points(Int)
    case grade(Character)
}

var scoreUse1 = ScoreUse.points(99)
scoreUse1 = .grade("A")

print(scoreUse1, "+", 123)

// case 后面的参数可以写在最外面 let .points(i)
// 也可以写在里面 .points(let i)
// 如果有多个参数，则表示所有的都是 let 常量
// 可以根据需要来修改 let 或者 var

switch scoreUse1 {
    case let .points(i):
        print(i, "points")
    case let .grade(i):
        print("grade", i)
}

enum DateUse {
    case digit(year: Int, month: Int, day: Int)
    case string(String)
}

var dateUse = DateUse.digit(year: 2020, month: 8, day: 18)
dateUse = DateUse.string("2020-8-18")

switch dateUse {
    case .digit(let year, let month, let day):
        print(year, month, day)
    case .string(let value):
        print(value)
}


// 应用 -- 手机解锁密码
enum Password {
    case number(Int, Int, Int, Int)
    case gesture(String)
}

var pwd = Password.number(1, 2, 3, 4)
pwd = Password.gesture("123456789")

switch pwd {
    case let .number(a1, a2, a3, a4):
        print(a1, a2, a3, a4)
    case let .gesture(string):
        print(string)
}



/*:
## 3. 原始值 (Raw Values)
 
 枚举成员可以使用相同类型的默认值预先对应，这个默认值就是原始值
 
 !!!: 原始值不占用枚举变量的内存
*/
enum Grade : String {
    case perfect = "A"
    case gread = "B"
    case good = "C"
    case bad = "D"
}
var gradeResult = Grade.perfect
let greadRawValue = gradeResult.rawValue

// 隐式原始值 (Implicitly Assigned Raw Values)
// 如果枚举的原始值类型是 Int、String  swift 会自动分配原始值
enum Direction111 : String {
    case north, south, east, west
}
print(Direction111.north.rawValue)

enum Season111 : Int {
    case spring, summer, autumn, winter
}
print(Season111.spring.rawValue)
print(Season111.summer.rawValue)
print(Season111.autumn.rawValue)
print(Season111.winter.rawValue)


// 递归枚举 (Recursive Enumeration)
indirect enum ArithExpr {
    case number(Int)
    case sum(ArithExpr, ArithExpr)
    case dif(ArithExpr, ArithExpr)
}

enum ArithExpr1 {
    case number(Int)
    indirect case sum(ArithExpr1, ArithExpr1)
    indirect case dif(ArithExpr1, ArithExpr1)
}

let five = ArithExpr.number(5)
let four = ArithExpr.number(4)
let two = ArithExpr.number(2)
let sum = ArithExpr.sum(five, four)
let dif = ArithExpr.dif(sum, two)

func calculate(_ expr: ArithExpr) -> Int {
    switch expr {
        case let .number(value):
            return value
        case let .sum(left, right):
            return calculate(left) + calculate(right)
        case let .dif(left, right):
            return calculate(left) - calculate(right)
    }
}

calculate(sum)
calculate(dif)



// 内存  memory layout
enum PasswordML {
    case number(Int, Int, Int, Int)
    case other
}

MemoryLayout<PasswordML>.stride     // 40 -- 分配占用的空间大小
MemoryLayout<PasswordML>.size       // 33 -- 实际用到的空间大小
MemoryLayout<PasswordML>.alignment  // 8  -- 对齐参数

var pwdML = PasswordML.number(1, 20, 21, 32)
pwdML = .other

MemoryLayout.stride(ofValue: pwdML)     // 40
MemoryLayout.size(ofValue: pwdML)       // 33
MemoryLayout.alignment(ofValue: pwdML)  // 8

// 具体内存窥探相关请看 TestSwift 工程


//: [Next](@next)


/*
 rbp:
 0x7ffeefbff4b0
 0x7FFEEFBFF490
 0x7FFEEFBFF498
 
 
 0x00007ffeefbff4b0
 
 0x00007ffeefbff490
 
 0x1000059cb <+11>:  movq   $0xa, -0x20(%rbp)
 0x1000059d3 <+19>:  movq   $0x14, -0x18(%rbp)
 0x1000059db <+27>:  movq   $0x1e, -0x10(%rbp)
 
 
 
 0x1000071ff
 
 
 */
