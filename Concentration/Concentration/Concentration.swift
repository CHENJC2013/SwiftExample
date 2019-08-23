//
//  Concentration.swift
//  Concentration
//
//  Created by ChenJiCai on 2019/8/15.
//  Copyright © 2019 CJC. All rights reserved.
//

import Foundation

struct Concentration {
    
//    var cards = Array<Card>()
    private(set) var cards = [Card]()
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
//        计算属性
        get {
            return cards.indices.filter({ cards[$0].isFaceUp}).oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
//   mutating 结构体和枚举是值类型。默认情况下，值类型属性不能被自身的实例方法修改。
//    在 func关键字前放一个 mutating关键字来使属性可被修改
//    *** 在class中都不需要写mutating,因为class是引用类型
    mutating func chooseCard(at index: Int) {
//        assert: 断言，assert中的第一个参数为false时，程序会自动crash，并打印第二个参数
//        发布后会自己忽略断言
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): 传入的索引在cards中不存在")
        if !cards[index].isMatched {
            if let matchIndex = indexOfTheOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = index
            }
        }
    }

    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "init(\(numberOfPairsOfCards): 参数必须大于0")
//        let card = Card()//报错：Struct有一个自动获取的构造器，与类的不同，此init方法中会包含Struct中的所有变量做为参数
//        let card = Card(isFaceUp: false, isMatched: false, identifier: T##Int)
        for _ in 0..<numberOfPairsOfCards { // <小于号代表开区间，不包含number的值
            let card = Card()
            /*let matchingCard = card  // 值拷贝
            cards.append(card)
            cards.append(matchingCard)*/
            // 当你传递结构体时，实际上是在拷贝，在真正需要的时候产生新的内存
            cards += [card, card]
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
