//
//  ContentView.swift
//  Dice
//
//  Created by Ethan Bütt on 10.06.20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    private let MAX_DICE_COUNT: Int = 6
    @State private var diceCountSelection: Int = 1
    @State private var diceValues: [Int] = [5]
    
    @State private var displayMode: DisplayMode = .Face
    
    var body: some View {
        VStack {
            HStack {
                Text("Dice!")
                    .font(.headline)
                    .padding()
                Spacer()
                Button(action: {
                    if self.displayMode == .Face { self.displayMode = .Font }
                    else { self.displayMode = .Face }
                }) {
                    HStack {
                        Image(systemName: "arrow.right.arrow.left.circle")
                        Text("\(self.displayMode.rawValue)")
                    }
                }
                    .accentColor(colorScheme == .light ? Color.white : Color.black)
                    .padding(7)
                    .background(colorScheme == .light ? Color.black : Color.white)
                    .cornerRadius(8)
            }
                .padding()
            Spacer()
            LazyVGrid(columns: Array(repeating: .init(), count: diceValues.count > 1 ? 2 : 1)) {
                ForEach(0..<diceValues.count, id: \.self) {
                    Image(systemName: self.displayMode == .Face ? "die.face.\(diceValues[$0]).fill" : "\(diceValues[$0]).square.fill")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                }
            }
            Spacer()
            Stepper("Dice: \(self.diceCountSelection)", value: $diceCountSelection, in: 1...6)
                .padding([.horizontal], 40)
                .padding([.bottom], 30)
            Button(action: {
                self.diceValues = getRandomDiceValues(diceCountSelection)
            }) {
                HStack {
                    Image(systemName: "play.fill")
                    Text("Roll!")
                }
                    .padding()
                    .padding([.horizontal], 125)
            }
                .accentColor(colorScheme == .light ? Color.white : Color.black)
                .background(colorScheme == .light ? Color.black : Color.white)
                .cornerRadius(15)
                .padding([.bottom], 20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
