import SwiftUI

struct OptionView: View {
    
    @Binding var key: Key
    @Binding var showShuffleWarning: Bool
    
    var body: some View {
        HStack {
            Text("1st Player")
            Picker(selection: .init(get: {
                key.isBlueFirst ? Card.blueAgent : Card.redAgent
            }, set: { newValue in
                key.isBlueFirst = newValue == Card.blueAgent
            })) {
                Label(
                    title: { Text("Red") },
                    icon: {
                        Card.redAgent.image
                            .foregroundStyle(.white, .red)
                    }
                ).tag(Card.redAgent)
                Label(
                    title: { Text("Blue") },
                    icon: {
                        Card.blueAgent.image
                            .foregroundStyle(.white, .blue)
                    }
                ).tag(Card.blueAgent)
            } label: { }
                .frame(maxWidth: 120)
                .padding(.trailing)
                .tint(.black)
            
            Spacer()
            
            Button("Shuffle") { showShuffleWarning = true }
        }
    }
}
