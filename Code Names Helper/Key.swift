//
//  Key.swift
//  Code Names Helper
//
//  Created by Zoe Van Brunt on 2/27/23.
//

import Foundation

struct Key: Equatable, Codable {
    
    var grid: [[Item]]
    var isBlueFirst: Bool
    
    init() {
        var cards: [Card] = [
            Array(repeating: .redAgent, count: 8),
            Array(repeating: .blueAgent, count: 8),
            [.doubleAgent],
            Array(repeating: .bystander, count: 7),
            [.assassin],
        ].flatMap { $0 }
        
        var newGrid: [[Item]] = []
        for row in 0..<5 {
            newGrid.append([])
            for _ in 0..<5 {
                let idx = cards.indices.randomElement()!
                let card = cards.remove(at: idx)
                newGrid[row].append(Item(card: card))
            }
        }
        self.grid = newGrid
        
        isBlueFirst = .random()
    }
    
    struct Item: Identifiable, Hashable, Equatable, Codable {
        var card: Card
        var id = UUID()
        var isSelected: Bool = false
        
        func copyWithCard(_ card: Card) -> Item {
            var item = self
            item.card = card
            return item
        }
    }
    
}

extension Array where Element == [Key.Item] {
    func printGrid() {
        for row in self {
            var str = ""
            for item in row {
                str += {
                    switch(item.card) {
                        case .redAgent: return item.isSelected ? "r" : "R"
                        case .blueAgent: return item.isSelected ? "b" : "B"
                        case .doubleAgent: return item.isSelected ? "d" : "D"
                        case .bystander: return item.isSelected ? "i" : "I"
                        case .assassin: return item.isSelected ? "a" : "A"
                    }
                }()
            }
            print(str)
        }
    }
}
