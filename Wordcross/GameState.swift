//
//  GameState.swift
//  Wordcross
//
//  Created by Kaiyuan Qian on 28/1/2024.
//

import Foundation

class GameState: ObservableObject {
    
    @Published var board = [[Cell]]()
    @Published var bagOfLetters = [String]()
    
    let alphabet: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    let bagSize = 25
    
    init() {
        resetBoard()
        fillBagOfLetters()
    }
    
    // fills bag of letters
    func fillBagOfLetters() {
        for _ in 0..<bagSize {
            let rand = Int(arc4random_uniform(26))
            bagOfLetters.append(alphabet[rand])
        }
    }
    
    // places a letter on the board
    func placeLetter(_ row: Int, _ column: Int) {
        
    }
    
    // creates an empty board
    func resetBoard() {
        var newBoard = [[Cell]]()
        
        for _ in 0...4 {
            var row = [Cell]()
            for _ in 0...4 {
                row.append(Cell(tile: Tile(letter: "A", score: 1)))
            }
            
            newBoard.append(row)
        }
        board = newBoard
    }
}
