//
//  DiceUtils.swift
//  Dice
//
//  Created by Ethan Bütt on 10.06.20.
//

import Foundation

enum InvalidArgumentError: Error {
    case InvalidArgumentError
}

func getRandomDieValue() -> Int {
    let value = Int.random(in: 1..<7)
    return value
}

func getRandomDiceValues(_ numberOfDice: Int) -> [Int] {
    var dice: [Int] = []
    for _ in 0..<numberOfDice {
        dice.append(getRandomDieValue())
    }
    
    return dice
}

enum DisplayMode: String {
    case Font = "Font"
    case Face = "Face"
}
