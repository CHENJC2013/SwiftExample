//
//  PlayingCardDeck.swift
//  PlayingCard
//
//  Created by ChenJiCai on 2019/8/23.
//  Copyright © 2019 CJC. All rights reserved.
//

import Foundation

struct PlayingCardDeck {
    
    ///
    /// Create a new deck of cards
    ///
    init() {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all {
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }
    
    ///
    /// The collection of cards
    ///
    private(set) var cards = [PlayingCard]()
    
    ///
    /// Draw a card from the deck(整付牌)
    ///
    mutating func draw() -> PlayingCard? {
        // If there are cards, return a random one
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        }
        // No more cards available
        return nil
    }
}
