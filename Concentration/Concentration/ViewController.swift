//
//  ViewController.swift
//  Concentration
//
//  Created by ChenJiCai on 2019/8/15.
//  Copyright © 2019 CJC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 只要类的所有变量都被初始化，类自动得到一个不需要参数的init()方法
    /*
     1、前面不加lazy时，不能访问self中的变量，因为在给变量game赋值时要调用Concentration的init方法时，self还没有初始化
     2、当给变量添加lazy时，意味着它将不会初始化，直到需要使用它的时候
     3、不能在lazy变量上使用属性观察者didSet等
     */
    private lazy var game = Concentration(numberOfPairsOfCards: (self.cardButtons.count + 1) / 2)
    
    //private(set) 不允许设置值
    private(set) var flipCount = 0 {
//当你声明一个存储属性，你可以使用闭包定义一个【属性观察器】，该闭包中的代码会在属性被设值的时候执行。
//  willSet 观察器会在属性被赋新值之前被运行，didSet 观察器则会在属性被赋新值之后运行。
//  无论新值是否等于属性的旧值它们都会被执行。
//  需要注意的是当属性在初始化方法中进行赋值时，不会触发观察器的代码
        didSet { //属性观察器
            flipCountLabel.text = "Flips:\(flipCount)"
        }
    }

    //Optional: 可选类型，只有两种状态（有值、没值），没值时是nil。nil在Swift中不代表空指针，代表的是可选类型的缺省值
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel() {
//        for index in 0..<cardButtons.count {
//        indices 属性返回一个 Range \<Index>，可以用来遍历集合中所有的有效索引
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.9917996526, green: 0.6423984766, blue: 0.01227067038, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["🎃", "🤖", "🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇"]
    
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex =
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        } else {
//            return "?"
//        }
        return emoji[card.identifier] ?? "?"
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
