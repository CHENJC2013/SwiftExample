//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by ChenJiCai on 2019/8/23.
//  Copyright © 2019 CJC. All rights reserved.
//

import Foundation

struct PlayingCard {
    
    var suit: Suit
    
    var rank: Rank
    
    enum Suit: String {
        case spades     = "♠️"
        case hearts     = "♥️"
        case clubs      = "♣️"
        case diamonds   = "♦️"
        //enum的集合
        static var all: [Suit] = [.spades, .hearts, .clubs, .diamonds]
    }
    
    
    enum Rank {
        case ace
        case face(String) // ugly design
        case numeric(Int)
        
        ///
        /// The order of each Rank
        ///
        var order: Int {
            switch self {
            case .ace: return 1
            case .numeric(let pips): return pips
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            default: return 0 // ugly design
            }
        }
        
        //enum的集合
        static var all: [Rank] {
            // Ace
            var allRanks: [Rank] = [.ace]
            
            // 2...10
            for pips in 2...10 {
                allRanks.append(.numeric(pips))
            }
            
            // Jack, Queen, King
            allRanks += [.face("J"), .face("Q"), .face("K")]
            return allRanks
        }
    }
}

// CustomStringConvertible 提供了一种用文本表示一个对象或者结构的方式
extension PlayingCard: CustomStringConvertible {
    ///
    /// String representation of a `PlayingCard`
    ///
    var description: String {
        return "\(rank)\(suit)"
    }
}

// Make `PlayingCard.Suit` confrom to `CustomStringConvertible`
extension PlayingCard.Suit: CustomStringConvertible {
    var description: String {
        return rawValue
    }
}

// Make `PlayingCard.Rank` confrom to `CustomStringConvertible`
extension PlayingCard.Rank: CustomStringConvertible {
    var description: String {
        switch self {
        case .ace: return "A"
        case .numeric(let pips): return String(pips)
        case .face(let kind): return kind
        }
    }
}
