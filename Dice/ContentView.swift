//
//  ContentView.swift
//  Dice
//
//  Created by Ethan Bütt on 10.06.20.
//

import SwiftUI

let DEFAULT_DIE_VALUE = 5
let MAX_DICE_COUNT: Int = 6

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State private var diceCountSelection: Int = 1
    @State private var diceValues: [Int] = [DEFAULT_DIE_VALUE]
    
    @State private var displayMode: DisplayMode = .Face
    @State private var showTotal: Bool = false
    
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
                .onTapGesture {
                    self.showTotal = true
                }
            Spacer()
            Stepper("Dice: \(self.diceCountSelection)", value: $diceCountSelection, in: 1...MAX_DICE_COUNT, onEditingChanged: { isStartGesture in
                if !isStartGesture {
                    if diceCountSelection > diceValues.count {
                        diceValues.append(contentsOf: Array(repeating: DEFAULT_DIE_VALUE, count: diceCountSelection - diceValues.count))
                    } else if diceCountSelection < diceValues.count {
                        diceValues = Array(diceValues.prefix(diceCountSelection))
                    }
                }
            })
                .padding([.horizontal], 40)
                .padding([.bottom], 30)
            Button(action: {
                self.diceValues = getRandomDiceValues(diceCountSelection)
            }) {
                HStack {
                    Image(systemName: "play.fill")
                    Text("Roll")
                }
                    .padding()
                    .padding([.horizontal], 125)
            }
                .accentColor(colorScheme == .light ? Color.white : Color.black)
                .background(colorScheme == .light ? Color.black : Color.white)
                .cornerRadius(15)
                .padding([.bottom], 20)
        }
        .alert("Dice Total: \(self.diceValues.reduce(0, { $0 + $1 }))", isPresented: self.$showTotal) {
            Button("Copy") {
                UIPasteboard.general.string = "\(self.diceValues.reduce(0, { $0 + $1 }))"
                self.showTotal = false
            }
            Button("Dismiss") {
                self.showTotal = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
