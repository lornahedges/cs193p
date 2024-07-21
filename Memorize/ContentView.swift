//
//  ContentView.swift
//  Memorize
//
//  Created by Lorna Hedges on 6/25/24.
//

import SwiftUI

struct ContentView: View {
    var emojis: [String] = ["🎃", "😈", "🧙🏼‍♀️", "🕷️", "🕷️", "🎃", "😈", "🧙🏼‍♀️", "🕷️", "🕷️"]
    @State var cardCount = 3
    
    var body: some View {
        VStack{
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjuster
        }
        
        .foregroundColor(.blue)
        .padding()
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
        
    }
    var cardCountAdjuster: some View {
        HStack {
            cardRemover
            Spacer() //puts space btwn buttons
            cardAdder
        }
    }
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3 , contentMode: .fit)
            }
        }
    }
    
    var cardRemover: some View {
        return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        return cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
}

struct CardView: View {
    @State var isFaceUp: Bool = true
    let base = RoundedRectangle(cornerRadius: 12)
    let content: String
    
    var body: some View {
        ZStack {
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
            }.onTapGesture() {
                isFaceUp.toggle() //add @State to isFaceUp declaration to allow (the wrong way) the cards to be toggled even though a view is immutable.
        }
    }
}

#Preview {
    ContentView()
}
