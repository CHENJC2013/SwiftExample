//
//  Concentration.swift
//  Concentration
//
//  Created by ChenJiCai on 2019/8/15.
//  Copyright © 2019 CJC. All rights reserved.
//

import Foundation

class Concentration {
    
//    var cards = Array<Card>()
    var cards = [Card]()
    
    func chooseCard(at index: Int) {
        
    }

    init(numberOfPairsOfCards: Int) {
     
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

