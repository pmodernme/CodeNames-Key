import SwiftUI

struct CounterView: View {
    
    var redCount: Int
    var blueCount: Int
    
    var body: some View {
        HStack {
            Label {
                Text("\(redCount) remaining")
            } icon: {
                Card.redAgent.image
            }.foregroundColor(.red)
            
            Spacer()
            
            Label {
                Text("\(blueCount) remaining")
            } icon: {
                Card.blueAgent.image
            }.foregroundColor(.blue)
            
        }
    }
}
