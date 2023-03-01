//
//  ContentView.swift
//  Code Names Helper
//
//  Created by Zoe Van Brunt on 2/27/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @StateObject var dataSource = DataSource()
    @State private var showShuffleWarning: Bool = false
    
    var body: some View {
        VStack {
            KeyView(key: $dataSource.key, isBlueFirst: dataSource.key.isBlueFirst)
            
            VStack {
                OptionView(key: $dataSource.key, showShuffleWarning: $showShuffleWarning)
                    .alert("Shuffle", isPresented: $showShuffleWarning) {
                        Button("Shuffle", role: .destructive, action: dataSource.shuffle)
                    } message: {
                        Text("You will lose your old key.")
                    }
                
                CounterView(redCount: dataSource.redCount, blueCount: dataSource.blueCount)
            }
            .padding(.horizontal, 8)
            .padding(.top)
        }
        .padding()
        .background(Color(.systemGroupedBackground))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
