//
//  Card.swift
//  Concentration
//
//  Created by ChenJiCai on 2019/8/15.
//  Copyright © 2019 CJC. All rights reserved.
//

import Foundation

/*
 Struct与Class的主要区别：
 相同点
 * 都能定义property、method、initializers
 * 都支持protocol、extension
 不同点
 * class是引用类型；struct是值类型
 * class支持继承；struct不支持继承
 * class声明的方法修改属性不需要mutating关键字；struct需要
 * class没有提供默认的memberwise initializer；struct提供默认的memberwise initializer
 * class支持引用计数(Reference counting)；struct不支持
 * class支持Type casting；struct不支持
 * class支持Deinitializers；struct不支持
 
 */
struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    /*
     Static:
     1、修饰全局变量，作用域会修改，也就是只能在当前文件下使用
     2、修饰变量，只会分配一次内存
     3、修饰局部变量，延长生命周期，跟整个应用程序有关，程序结束才会销毁。 而全局变量本来的生命周期就是整个程序运行期间
     */
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        //因为是在Static方法中调用，所以可以不用写Card.identifierFactory
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
//    init(identifier: Int) {
//        self.identifier = identifier
//    }
}
