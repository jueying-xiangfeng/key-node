//: [Previous](@previous)

/*:
## 1. if-else
 
 if 后面的条件只能是 Bool 类型
 
 if 后面的条件可以省略小括号，条件后面的大括号不能省略
*/
let age = 10
if age > 10 {
    print("yes")
} else if age > 5 {
    print(">5 yes")
} else {
    print("no")
}

/*:
## 2. while
 
 repeat-while 相当于C语言的 do-while
 
 swift3 开始，去除了自增(++)、自减(--) 运算符
*/
var num = 5
while num > 0 {
    print("num is \(num)")
    num -= num
}

var num1 = -1
repeat {
    print("num1 is \(num1)")
} while (num1 > 0)  // 打印了一次

/*:
## 2. for
*/

//: 闭区间运算符: a...b -> (a<= 取值 <= b)
// 注意这里 i 默认为 let，如果想要改变 i，则需要主动声明为 var 类型
for i in 0...3 {
    print("for: let i == \(i)")
}

for var i in 0...3 {
    i += i
    print("for: var i == \(i)")
}

let names = ["a", "b", "c", "d"]
for i in 0...3 {
    print("names: i = \(names[i])")
}

let range = 1...3
for i in range {
    print("names: range -- i = \(names[i])")
}

let af = 1
var bf = 2
for i in af...bf {
    print("af--bf  i = \(names[i])")
}
for i in af...3 {
    print("af--3  i = \(names[i])")
}

for _ in 1...3 {
    print("省略 i")
}

// 半开区间运算符: a..<b (a <= 取值 < b)
for i in 1..<5 {
    print("半开区间运算符 -- \(i)")
}


/*:
## 3. for - 区间运算符用在数组上
*/
let nameArray = ["a", "b", "c", "d"]
for name in nameArray[0...3] {
    print("name array -- name = \(name)")
}

// 单侧区间: 让区间炒一个方向尽可能的远
for name in nameArray[2...] {
    print("name array - 单侧区间 name = \(name)")
}
for name in nameArray[...2] {
    print("name array - 单侧区间 name = \(name)")
}
for name in nameArray[..<2] {
    print("name array - 单侧区间-半开区间 name = \(name)")
}

let rangeFor = ...5
rangeFor.contains(9)
rangeFor.contains(2)
rangeFor.contains(-4)

// 区间类型
let rangeFor1: ClosedRange<Int> = 1...3
let rangeFor2: Range<Int> = 1..<3
let rangeFor3: PartialRangeThrough<Int> = ...5

// 字符、字符串也能使用区间运算符，但默认不能用在 for-in 中
let stringRange1 = "cc"..."ff" // ClosedRange<String>
stringRange1.contains("cb")
stringRange1.contains("aa")
stringRange1.contains("cd")

let stringRange2 = "a"..."f"
stringRange2.contains("d")
stringRange2.contains("h")

// \0 到 ~ 囊括了所有可能要用到的 ASCII 字符
let characterRange: ClosedRange<Character> = "\0"..."~"
characterRange.contains("G")

// 带间隔的区间值
let hours = 11
let hourInterval = 2
for tickMark in stride(from: 4, to: hours, by: hourInterval) {
    print("tickmark -- \(tickMark)")
}


/*:
## 4. switch
*/

// case default 后面不能写大括号 {}
// 默认可以不写 break，并且不会贯穿到后面的条件
var numberSwitch = 1
switch numberSwitch {
case 1:
    print("number switch is 1")
    print("number switch is 1")
case 2:
    print("number switch is 2")
default:
    print("number switch is other")
}

// 使用 fallthrough 可以实现贯穿效果
var numberSwitch1 = 1
switch numberSwitch1 {
    case 1:
        print("number switch1 is 1")
        fallthrough
    case 2:
        print("number switch1 is 2")
    default:
        print("number switch is other")
}

// switch 注意点

// switch 必须能保证处理所有情况
// case、default 后面至少要有一条语句
// 如果不想做任何事情，加 break 即可

// 如果能保证已处理所有情况，也可以不必使用 default
enum Answer { case right, wrong }
let answer = Answer.right
switch answer {
    case Answer.right:
        print("answer right")
    case Answer.wrong:
        print("answer wrong")
}

/*
 由于已经确定 answer 是 Answer 类型，这里可以直接省略 Answer
 switch answer {
     case .right:
         print("answer right")
     case .wrong:
         print("answer wrong")
 }
 */


// 复合条件
// switch 也支持 Character、String 类型
let stringF = "jack"
switch stringF {
    case "jack":
        fallthrough
    case "john":
        print("is person")
    default:
        break
}
switch stringF {
    case "jack", "john":
        print("is person")
    default:
        break
}

// 区间匹配、元组匹配
// 可以使用下划线_ 忽略某个值
let count = 62
switch count {
    case 0:
        print("none")
    case 1..<5:
        print("1~4")
    case 5..<100:
        print("5~99")
    default:
        print("other")
}

let point = (1, 1)
switch point {
    case (0, 0):
        print("origin")
    case (_, 0):
        print("on the x-axis")
    case (0, _):
        print("on the y-axis")
    case (-2...2, -2...2):
        print("inside the box")
    default:
        print("outside of the box")
}

// 值绑定，必要时 let 也可以为 var
let point1 = (2, 0)
switch point1 {
    case (let x, 0):
        print("on the x-axis with an x value of \(x)")
    case (0, let y):
        print("on the y-axis with an y value of \(y)")
    case let (x, y):
        print("somewhere else at (\(x), \(y))")
}


// where
let point2 = (1, -1)
switch point2 {
case let (x, y) where x == y:
    print("on the line x == y")
case let (x, y) where x == -y:
    print("on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some artitrary point")
}

var testNumbers = [1, 2, 3, -1, -2, -3]
var resultNum = 0
for num in testNumbers where num > 0 {
    resultNum += num
}
print(resultNum)


// 标签语句
for i in 1...4 {
    for k in 1...4 {
        if k == 3 {
            continue
        }
        if i == 3 {
            break
        }
        print("i == \(i), k == \(k)")
    }
}

outer: for i in 1...4 {
    for k in 1...4 {
        if k == 3 {
            continue outer
        }
        if i == 3 {
            break outer
        }
        print("outer i == \(i), k == \(k)")
    }
}



//: [Next](@next)
