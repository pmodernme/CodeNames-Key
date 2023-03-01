import SwiftUI

struct CardView: View {
    
    @Binding private var selected: Bool
    
    internal init(_ card: Card, selected: Binding<Bool>) {
        self.card = card
        _selected = selected
    }
    
    let card: Card
    
    var body: some View {
        let roundedRect = RoundedRectangle(cornerRadius: 8)
        
        Button {
            selected.toggle()
        } label: {
            ZStack {
                roundedRect
                    .foregroundColor(card.color)
                    .shadow(radius: 2, y: 4)
            }
            .overlay {
                card.image
                    .resizable()
                    .imageScale(.large)
                    .fontWeight(.bold)
                    .aspectRatio(contentMode: .fit)
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: 44, maxHeight: 44)
                    .padding(12)
                    .foregroundColor(card == .assassin ? .white : .black)
            }
        }
        .overlay {
            roundedRect
                .stroke(.primary, lineWidth: 4)
        }
        .opacity(selected ? 0.25 : 1)
    }
    
}

extension Card {
    var color: Color {
        switch self {
            case .redAgent:
                return .red
            case .blueAgent:
                return .blue
            case .doubleAgent:
                return .brown
            case .bystander:
                return .white
            case .assassin:
                return .black
        }
    }
    
    var image: Image {
        switch self {
            case .redAgent:
                return Image(systemName: "dot.square")
            case .blueAgent:
                return Image(systemName: "plus.diamond")
            case .doubleAgent:
                return Image(systemName: "suit.diamond.fill")
            case .bystander:
                return Image(systemName: "minus")
            case .assassin:
                return Image("skull")
        }
    }
    
    var emoji: String {
        switch self {
            case .redAgent:
                return "♦︎"
            case .blueAgent:
                return "♧"
            case .doubleAgent:
                return "🟤"
            case .bystander:
                return "⚪️"
            case .assassin:
                return "💀"
        }
    }
}

struct CardView_Previews: PreviewProvider {
    
    static var previews: some View {
        Container()
    }
    
    struct Container: View {
        @State var selected = false
        
        var body: some View {
            CardView(.bystander, selected: $selected)
                .padding()
                .frame(width: 80, height: 120)
                .previewLayout(.sizeThatFits)
        }
    }
    
}
