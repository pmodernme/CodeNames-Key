import Foundation
import Combine

class DataSource: ObservableObject {
    @Published private var _key: Key = Key()
    
    var key: Key {
        get { _key }
        set {
            _key = newValue
            keySubject.send(newValue)
        }
    }
    
    private var cancellable = Set<AnyCancellable>()
    private let keySubject = PassthroughSubject<Key, Never>()
    
    init() {
        _key = {
            if let data = UserDefaults.standard.data(forKey: cardsKey),
               let savedKey = try? JSONDecoder().decode(Key.self, from: data) {
                print("Success loading key!")
                return savedKey
            } else {
                print("Failed to load key!")
                return nil
            }
        }() ?? Key()
        
        keySubject
            .sink { key in
                if let data = try? JSONEncoder().encode(key) {
                    UserDefaults.standard.set(data, forKey: cardsKey)
                    print("Success saving key!")
                } else {
                    print("Failed to save key!")
                }
            }
            .store(in: &cancellable)
    }
    
    func shuffle() {
        key = Key()
    }
    
    var redCount: Int {
        filteredItems(.redAgent).count
    }
    
    var blueCount: Int {
        filteredItems(.blueAgent).count
    }
    
    private func filteredItems(_ type: Card) -> [Key.Item] {
        let remaining = key.items.remaining
        var result = remaining.matching(type)
        if type == .blueAgent, key.isBlueFirst {
            result += remaining.matching(.doubleAgent)
        } else if type == .redAgent, !key.isBlueFirst {
            result += remaining.matching(.doubleAgent)
        }
        return result
    }
}

extension Key {
    var items: [Key.Item] {
        grid.flatMap { $0 }
    }
}

extension Array where Element == Key.Item {
    var remaining: [Key.Item] {
        filter { !$0.isSelected }
    }
    
    func matching(_ type: Card) -> [Key.Item] {
        filter { $0.card == type }
    }
}

private let cardsKey = "io.zvb.code-names-helper.cards"
