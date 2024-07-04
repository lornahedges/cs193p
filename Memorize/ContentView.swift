//
//  ContentView.swift
//  Memorize
//
//  Created by Lorna Hedges on 6/25/24.
//

import SwiftUI

struct ContentView: View {
    var emojis: [String] = ["🎃", "😈", "🧙🏼‍♀️", "🕷️", "🕷️"]
    
    var body: some View {
        HStack {
            ForEach(emojis.indices, id: \.self)
            {
                index in CardView(content: emojis[index])
            }
        }
        .foregroundColor(.blue)
        .padding()
    }
}

struct CardView: View {
    @State var isFaceUp: Bool = false
    let base = RoundedRectangle(cornerRadius: 12)
    let content: String
    
    var body: some View {
        ZStack {
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }else{
                base
                }
            }.onTapGesture() {
                isFaceUp.toggle() //add @State to isFaceUp declaration to allow (the wrong way) the cards to be toggled even though a view is immutable.
        }
    }
}

#Preview {
    ContentView()
}
