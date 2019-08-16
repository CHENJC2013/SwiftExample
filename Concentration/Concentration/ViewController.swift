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
    lazy var game = Concentration(numberOfPairsOfCards: (self.cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
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
    
    var emojiChoices = ["🎃", "🤖", "🎃", "🤖"]
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
//        flipCountLabel.text = "Flips:\(flipCount)"  //使用didSet
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9917996526, green: 0.6423984766, blue: 0.01227067038, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
}

