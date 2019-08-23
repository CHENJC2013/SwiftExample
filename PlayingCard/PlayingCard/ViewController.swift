//
//  ViewController.swift
//  PlayingCard
//
//  Created by ChenJiCai on 2019/8/23.
//  Copyright © 2019 CJC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var deck = PlayingCardDeck()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for _ in 0...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }


}

