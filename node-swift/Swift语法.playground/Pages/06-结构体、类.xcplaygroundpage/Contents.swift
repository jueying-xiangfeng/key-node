//: [Previous](@previous)


/*:
## 1. 结构体
 
 在 swfit 标准库中，绝大多数的公开类型都是结构体，枚举和类只占一小部分
 - 比如 Bool、Int、Double、String、Array、Dictionary 都是结构体
 
 所有的结构体都有一个编译器自动生成的初始化器(initializer、初始化方法、构造器、构造方法)
 这里的成员变量叫做 (存储属性， Stored Property)
*/

// 结构体的初始化器

// 编译器会根据情况，可能会为结构体生成生成多个初始化器
// 宗旨是：保证所有成员都有初始值

struct PointT {
    var x: Int
    var y: Int
}
var pt1 = PointT(x: 10, y: 10)

struct PointT1 {
    var x: Int = 0
    var y: Int
}
var pt11 = PointT1(y: 10)
var pt12 = PointT1(x: 10, y: 10)

struct PointT11 {
    var x: Int = 0
    var y: Int = 0
}
var pt111 = PointT11(y: 10)
var pt112 = PointT11(x: 10, y: 10)
var pt113 = PointT11(x: 10)
var pt114 = PointT11()


// 可选项
// 可选项都有个默认值 nil
struct PointK {
    var x: Int?
    var y: Int?
}
var pk1 = PointK()
var pk2 = PointK(x: 10)
var pk3 = PointK(y: 10)
var pk4 = PointK(x: 10, y: 10)


class PointA {
    var x: Int
    var y: Int
    
    init() {
        x = 0
        y = 0
    }
}

let pa1 = PointA()


/*
0x100006083 <+19>:  movl   $0xa, %edi   // 10 -> edi
0x100006088 <+24>:  movl   $0x14, %esi  // 20 -> esi

TestSwift`init(x:y:) in Point #1 in structAndClassTest5():
->  0x100006150 <+0>:  pushq  %rbp
    0x100006151 <+1>:  movq   %rsp, %rbp
    0x100006154 <+4>:  movq   %rdi, %rax    // 10 -> rax
    0x100006157 <+7>:  movq   %rsi, %rdx    // 20 -> rdx
    0x10000615a <+10>: popq   %rbp
    0x10000615b <+11>: retq

0x100006092 <+34>:  movq   %rax, -0x10(%rbp)    // 10 -> rbp-0x10   p1
0x100006096 <+38>:  movq   %rdx, -0x8(%rbp)     // 20 -> rbp-0x8

0x10000609a <+42>:  movq   %rax, -0x20(%rbp)    // 10 -> rbp-0x20   p2
0x10000609e <+46>:  movq   %rdx, -0x18(%rbp)    // 20 -> rbp-0x18

0x1000060a2 <+50>:  movq   0x507f(%rip), %rax        ; (void *)0x00007fff8c6d77e0: type metadata for Any
0x1000060a9 <+57>:  addq   $0x8, %rax
0x1000060ad <+61>:  movl   $0x1, %edi
0x1000060b2 <+66>:  movq   %rax, %rsi
0x1000060b5 <+69>:  callq  0x1000095ee





0x10000a0b0 <+48>:  movq   %rax, 0x3bb9(%rip)   10 -> 0x10000a0b7 + 0x3bb9 = 0x10000DC70
0x10000a0b7 <+55>:  movq   %rdx, 0x3bba(%rip)   20 -> 0x10000a0be + 0x3bba = 0x10000DC78
0x10000a0be <+62>:  movq   %rsi, %rdi
0x10000a0c1 <+65>:  leaq   -0x18(%rbp), %rsi
0x10000a0c5 <+69>:  movl   $0x20, %edx
0x10000a0ca <+74>:  callq  0x10000a58a
0x10000a0cf <+79>:  movq   0x3b9a(%rip), %rax   0x10000a0d6 + 0x3b9a = 0x10000DC70
0x10000a0d6 <+86>:  movq   %rax, 0x3ba3(%rip)   0x10000a0dd + 0x3ba3 = 0x10000DC80
0x10000a0dd <+93>:  movq   0x3b94(%rip), %rax   0x10000a0e4 + 0x3b94 = 0x10000DC78
0x10000a0e4 <+100>: movq   %rax, 0x3b9d(%rip)
*/






//: [Next](@next)
