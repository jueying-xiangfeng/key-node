//: [Previous](@previous)


/*:
## 1. 函数的定义
 
 形参默认是 let，也只能是 let
*/
func pi() -> Double {
    return 3.14
}

func testSum(v1: Int, v2: Int) -> Int {
    return v1 + v2
}
testSum(v1: 10, v2: 20)

// 无返回值
func sayHello() -> Void {
    print("hello")
}

func sayHello1() -> () {
    print("hello1")
}

func sayHello2() {
    print("hello2")
}

sayHello()
sayHello1()
sayHello2()


/*:
## 2. 隐式返回 (Implicit Return)
 
 如果整个函数体是一个单一表达式，那么函数会隐式返回这个表达式
*/
func testSum2(v1: Int, v2: Int) -> (Int) {
    v1 + v2
}
testSum2(v1: 10, v2: 20)


/*:
## 3. 返回元组，实现多返回值
*/
func calculate(v1: Int, v2: Int) -> (sum: Int, difference: Int, average: Int) {
    let sum = v1 + v2
    return (sum, v1 - v2, sum >> 1)
}
let calculateResult = calculate(v1: 20, v2: 10)
calculateResult.sum
calculateResult.difference
calculateResult.average

/*:
## 4. 函数的文档注释
*/

/// 求和【概述】
///
/// 将2个整数相加【更详细的描述】
///
/// - Parameters:
///   - v1: 第一个参数
///   - v2: 第二个参数
/// - Returns: 2个参数和
///
/// - Note: 传入2个整数即可【批注】
func testSum3(v1: Int, v2: Int) {
    v1 + v2
}
testSum3(v1: 10, v2: 20)


/*:
## 4. 参数标签 (Argument Label)
*/
// 可以修改参数标签
func goToWork(at time: String) {
    print("this time is \(time)")
}
goToWork(at: "08:00")

// 可以使用下划线 _  省略参数标签
func goToWork(_ time: String) {
    print("this time is \(time)")
}
goToWork("09:00")


/*:
## 5. 默认参数 (Default Paramter Value)
 
 形参可以有默认值
 
 - C++ 的默认形参值有个限制:必须从有往左设置。由于swift有参数标签，因此并没有此类限制
 - 但是在省略参数标签时，需要特别注意，避免出错
*/
func check(name: String = "nobady", age: Int, job: String = "none") {
    print("name = \(name), age = \(age), jon = \(job)")
}
check(name: "key", age: 28, job: "IT")
check(name: "rose", age: 20)
check(age: 10, job: "test")
check(age: 22)

// 注意：这里的 middle 就是不可以省略的参数标签
func testLabel(_ first: Int = 10, middle: Int, _ last: Int = 30) {
    print("testLabel")
}
testLabel(middle: 20)


/*:
## 6. 可变参数 (Variadic Parameter)
 
 - 一个函数最多只能有1个可变参数
 - 紧跟在可变参数后面的参数不能省略参数标签
*/
func variadicSum(_ numbers: Int...) -> (Int) {
    var total = 0
    for num in numbers {
        total += num
    }
    return total
}
variadicSum(10, 20, 30)

func variadicTest(_ numbers: Int..., string: String, _ other: String) {
    print("variadicTest")
}
variadicTest(10, 20, 30, string: "test", "key")


/*
 来看下自带的 print 函数
 
 /// - Parameters:
 ///   - items: Zero or more items to print.
 ///   - separator: A string to print between each item. The default is a single
 ///     space (`" "`).
 ///   - terminator: The string to print after all items have been printed. The
 ///     default is a newline (`"\n"`).
 public func print(_ items: Any..., separator: String = " ", terminator: String = "\n")
 */
print(1, 2, 3)
print(1, 2, 3, separator: "--")
print(1, 2, 3, separator: "--", terminator: "")
print(1)


/*:
## 7. 输入输出参数 (In-Out Parameter)
 
 可以用 inout 定义一个输入输出参数：可以在函数内部修改外部实参的值
 
 - 可变参数不能标记位 inout
 - inout 参数不能有默认值
 - inout 参数只能传入可以被多次赋值的
 - inout 参数的本质是地址传递(引用传递)
*/
func swapValues(_ v1: inout Int, _ v2: inout Int) {
//    let temp = v1
//    v1 = v2
//    v2 = temp
    (v1, v2) = (v2, v1)
}
var swapValue1 = 10
var swapValue2 = 20
swapValues(&swapValue1, &swapValue2)
print("\(swapValue1) -- \(swapValue2)")


/*:
## 8. 函数重载 (Function Overload)
 
 规则：
 - 函数名相同
 - 参数个数不同 || 参数类型不同 || 参数标签不同
 
*/
func sumOverload(v1: Int, v2: Int) -> Int {
    v1 + v2
}

// 参数个数不同
func sumOverload(v1: Int, v2: Int, v3: Int) -> Int {
    v1 + v2
}

// 参数类型不同
func sumOverload(v1: Int, v2: Double) -> Double {
    Double(v1) + v2
}

// 参数标签不同
func sumOverload(_ v1: Int, _ v2: Int) -> Int {
    v1 + v2
}
func sumOverload(a: Int, b: Int) -> Int {
    a + b
}


/*
 参数重载注意点:
 */
// 返回值类型与函数参数无关-> error: ambiguous use of 'sumOverload1(v1:v2:)
//func sumOverload1(v1: Int, v2: Int) -> Int { v1 + v2 }
//func sumOverload1(v1: Int, v2: Int) {  }
//sumOverload1(v1: 10, v2: 20)


// 默认参数值和函数重载一起使用产生二义性，编译器不会报错(C++ 中会报错)
//func sumOverload2(v1: Int, v2: Int) -> Int { v1 + v2 }
//func sumOverload2(v1: Int, v2: Int, v3: Int = 10) -> Int { v1 + v2 + v3 }
//sumOverload2(v1: 10, v2: 20)


// 可变参数、省略参数标签、函数重载 一起使用产生二义性时，编译器可能会报错
//func sumOverload3(v1: Int, v2: Int) -> Int { v1 + v2 }
//func sumOverload3(_ v1: Int, _ v2: Int) -> Int { v1 + v2 }
//func sumOverload3(_ numbers: Int...) -> Int {  }
//sumOverload3(10, 20)


/*:
## 9. 内联函数 (Inline Function)
 
 如果开启了编译器优化 (Release模式默认会开始优化)，编译器会自动将某些函数变成内联函数
 path: target->build Settings->optimization
 
 在 release 模式下，编译器已经开启优化，会自动决定哪些函数需要内联，因此没必要使用 @inline
 
 哪些函数不会被自动内联
 - 函数体比较长
 - 包含递归调用
 - 包含动态派发
 - ...
 
*/
// 永远不会被内联 (即使开启了编译器优化)
@inline(never) func testInline1() {
    print("testInline1")
}
// 开启编译器优化时，即使代码很长，也会被内联 (递归调用函数、动态派发的函数除外)
@inline(__always) func testInline2() {
    print("testInline2")
}


/*:
## 10. 函数类型 (Function Type)
*/

// 每一个函数都是有类型的，函数类型由 形式参数类型、返回值类型 组成

// () -> Void 或者 () -> ()
func testType() {}
// (Int, Int) -> Int
func sumType(a: Int, b: Int) -> Int {
    a + b
}

// 定义变量 - 调用时不需要参数标签
var testTypeFn: (Int, Int) -> Int = sumType
testTypeFn(10, 20)


// 函数类型作为函数参数
// (Int, Int) -> Int
func sumType1(v1: Int, v2: Int) -> Int {
    v1 + v2
}

func differenceType1(v1: Int, v2: Int) -> Int {
    v1 - v2
}

func printResultType(_ mainFunc: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mainFunc(a, b))")
}

printResultType(sumType1, 20, 10)
printResultType(differenceType1, 20, 10)


// 函数类型作为函数返回值
// 返回值是函数类型的函数 -- 高阶函数 (Higher - Order Function)
func next(_ input: Int) -> Int {
    input + 1
}

func previous(_ input: Int) -> Int {
    input - 1
}

func forward(_ forward: Bool) -> (Int) -> Int {
    forward ? next : previous
}

forward(true)(3)
forward(false)(3)


/*:
## 11. typealias
 
 用来给类型起别名
*/
typealias Byte = Int8
typealias Short = Int16
typealias Long = Int64

typealias Date = (year: Int, month: Int, day: Int)
func testTypeAlias(_ date: Date) {
    print(date.year)
    print(date.month)
    print(date.day)
}
//testTypeAlias(date: (year: 2020, month: 8, day: 18))
testTypeAlias((2020, 8, 18))


typealias IntFn = (Int, Int) -> Int
func differenceTypeAlias(v1: Int, v2: Int) -> Int {
    v1 - v2
}

let intFnTypeAlias: IntFn = differenceTypeAlias;
let resultTypeAliasDiff = intFnTypeAlias(20, 10)

func setFnTypeAlias(_ fn: IntFn) {
    let result = fn(11, 22)
    print(result)
}
setFnTypeAlias(differenceTypeAlias)

func getFnTypeAlias() -> IntFn {
    differenceTypeAlias
}
setFnTypeAlias(getFnTypeAlias())

// 这里还可以看下，按照 swift 标准库的定义， Void 就是空元组()
// public typealias Void = ()




/*:
## 12. 嵌套函数 (Nested Fuction)
 
 将函数定义在函数内部
*/
func forward111(_ forward: Bool) -> (Int) -> Int {
    
    func next(_ input: Int) -> Int {
        input + 1
    }
    func previous(_ input: Int) -> Int {
        input - 1
    }
    return forward ? next : previous
}

let result111 = forward111(true)(8)

let resultFunc: (Int) -> Int = forward111(true)
let resultFunc1: Int = resultFunc(2)

//: [Next](@next)
