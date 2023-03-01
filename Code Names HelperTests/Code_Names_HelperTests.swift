//
//  Code_Names_HelperTests.swift
//  Code Names HelperTests
//
//  Created by Zoe Van Brunt on 2/27/23.
//

import Quick
import Nimble
@testable import Code_Names_Helper

class KeySpec: QuickSpec {
    override func spec() {
        describe("Key") {
            it ("is a 5 by 5 grid") {
                let key = Key()
                expect(key.grid.count).to(equal(5))
                for row in key.grid {
                    expect(row.count).to(equal(5))
                }
            }
            it ("has the correct number of cards") {
                let key = Key()
                var counts = [Card: Int]()
                
                for row in key.grid {
                    var str = ""
                    for item in row {
                        let card = item.card
                        counts[card] = counts[card, default: 0] + 1
                        str += {
                            switch(card) {
                                case .redAgent: return "r"
                                case .blueAgent: return "b"
                                case .doubleAgent: return "d"
                                case .bystander: return "i"
                                case .assassin: return "a"
                            }
                        }()
                    }
                    print(str)
                }
                
                expect(counts[.redAgent]).to(equal(8))
                expect(counts[.blueAgent]).to(equal(8))
                expect(counts[.doubleAgent]).to(equal(1))
                expect(counts[.bystander]).to(equal(7))
                expect(counts[.assassin]).to(equal(1))
            }
        }
    }
}
