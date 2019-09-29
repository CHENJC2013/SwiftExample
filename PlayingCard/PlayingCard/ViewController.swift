//
//  ViewController.swift
//  PlayingCard
//
//  Created by ChenJiCai on 2019/8/23.
//  Copyright © 2019 CJC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var deck = PlayingCardDeck()
    
    @IBOutlet private var cardViews: [PlayingCardView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var cards = [PlayingCard]()
        for _ in 1...((cardViews.count+1)/2) {
            let card = deck.draw()!
            cards += [card, card]
        }
        for cardView in cardViews {
            cardView.isFaceUp = false
            let card = cards.remove(at: cards.count.arc4random)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
            cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(filpCard(_:))))
            
            // 给行为添加item
            cardBehavior.addItem(cardView)
            
        }
    }

    private var faceUpCardViews: [PlayingCardView] {
        // filter 方法用于过滤元素，即筛选出数组元素中满足某种条件的元素
        return cardViews.filter { $0.isFaceUp && !$0.isHidden && $0.transform != CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0) && $0.alpha == 1 }
    }

    private var faceUpCardViewsMatch: Bool {
        return faceUpCardViews.count == 2 &&
        faceUpCardViews[0].rank == faceUpCardViews[1].rank &&
        faceUpCardViews[0].suit == faceUpCardViews[1].suit
    }
    
    lazy var animator = UIDynamicAnimator(referenceView: view)
    
    lazy var cardBehavior = CardBehavior.init(in: animator)
    
    var lastChosenCardView: PlayingCardView?
    
    @objc func filpCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            if let chosenCardView = sender.view as? PlayingCardView, faceUpCardViews.count < 2 {
                lastChosenCardView = chosenCardView
                // 在card被选中时，将behavior移除，避免被选中的卡片还在移动
                cardBehavior.removeItem(chosenCardView)
                
                UIView.transition(with: chosenCardView, duration: 0.6, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: {
                    chosenCardView.isFaceUp = !chosenCardView.isFaceUp
                }, completion: { finish in
                    let cardsToAnimate = self.faceUpCardViews
                    if self.faceUpCardViewsMatch {
                        UIViewPropertyAnimator.runningPropertyAnimator(
                            withDuration: 0.75,
                            delay: 0,
                            options: [],
                            animations: {
                                cardsToAnimate.forEach {
                                    $0.transform = CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0)
                                }
                            },
                            completion: { position in
                                UIViewPropertyAnimator.runningPropertyAnimator(
                                    withDuration: 0.75,
                                    delay: 0,
                                    options: [],
                                    animations: {
                                        cardsToAnimate.forEach {
                                            // animations闭包中对属性的修改会立刻发生，只是让用户感觉像是在 withDuration 的时间里慢慢变化的
                                            $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                            $0.alpha = 0
                                        }
                                    },
                                    completion: { position in // 完成时做些清理工作
                                        cardsToAnimate.forEach {
                                            $0.isHidden = true
                                            $0.alpha = 1
                                            // transform属性默认值为CGAffineTransformIdentity,可以在形变之后设置该值以还原到最初状态
                                            $0.transform = .identity
                                        }
                                    }
                                )
                            }
                        )
                    
                    
                    } else if self.faceUpCardViews.count == 2 {
                        // 此判断是为了避免多个动画同时执行出现干扰
                        if chosenCardView == self.lastChosenCardView {
                            cardsToAnimate.forEach { cardView in
                                UIView.transition(with: cardView, duration: 0.6, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: {
                                    cardView.isFaceUp = false
                                }, completion: { finish in
                                    // 在UIView.transition中并不会导致循环引用，所以self不需要改成weak
                                    self.cardBehavior.addItem(cardView)
                                })
                            }
                        }
                        
                    } else {
                        if !chosenCardView.isFaceUp {
                            self.cardBehavior.addItem(chosenCardView)
                        }
                    }
                })
            }
        default:
            break
        }
    }
    
}

