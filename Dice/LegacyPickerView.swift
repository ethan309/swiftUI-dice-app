//
//  LegacyPickerView.swift
//  Dice
//
//  Created by Ethan Bütt on 10.06.20.
//

import SwiftUI

struct LegacyPickerView: View {
    @State private var diceCountSelection: Int = 1
    @State private var diceValues: [Int] = []
    
    var body: some View {
        VStack {
            Text("Selection: \(self.diceCountSelection)")
            Text("Dice: \(self.diceValues.count)")
            Picker("Number of Dice", selection: $diceCountSelection) {
                ForEach(1..<6 + 1) {
                    Text("\($0)")
                }
            }
                .padding([.horizontal], 100)
        }
    }
}

//struct LegacyPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        LegacyPickerView()
//    }
//}
