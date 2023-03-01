import SwiftUI

struct OptionView: View {
    
    @Binding var key: Key
    @Binding var showShuffleWarning: Bool
    
    var body: some View {
        HStack {
            Text("1st Player")
                .foregroundColor(key.isBlueFirst ? .blue : .red)
            Picker(selection: .init(get: {
                key.isBlueFirst ? Card.blueAgent : Card.redAgent
            }, set: { newValue in
                key.isBlueFirst = newValue == Card.blueAgent
            })) {
                Card.redAgent.image
                    .tag(Card.redAgent)
                Card.blueAgent.image
                    .tag(Card.blueAgent)
            } label: { }
                .pickerStyle(.segmented)
                .labelsHidden()
                .frame(maxWidth: 120)
                .padding(.trailing)
            
            Spacer()
            
            Button("Shuffle") { showShuffleWarning = true }
        }
    }
}
