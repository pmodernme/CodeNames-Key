import SwiftUI

struct KeyView: View {
    
    @Binding var key: Key
    var isBlueFirst: Bool
    
    var body: some View {
        Grid(alignment: .center, horizontalSpacing: 16, verticalSpacing: 16) {
            ForEach($key.grid, id: \.self) { row in
                GridRow {
                    ForEach(row) { item in
                        itemView(item: item.wrappedValue, selected: item.isSelected, isBlueFirst: isBlueFirst)
                    }
                }
            }
        }
        //        .onChange(of: key, perform: { $0.grid.printGrid() })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func itemView(item: Key.Item, selected: Binding<Bool>, isBlueFirst: Bool) -> CardView {
        switch item.card {
            case .doubleAgent:
                if isBlueFirst {
                    return itemView(item: item.copyWithCard(.blueAgent), selected: selected)
                } else {
                    return itemView(item: item.copyWithCard(.redAgent), selected: selected)
                }
            default: return itemView(item: item, selected: selected)
        }
    }
    
    private func itemView(item: Key.Item, selected: Binding<Bool>) -> CardView {
        CardView(item.card, selected: selected)
    }
    
}
