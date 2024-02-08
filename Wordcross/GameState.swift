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
    let tileScores = ["A": 1, "B": 3, "C": 3, "D": 2, "E": 1, "F": 4, "G": 2, "H": 4, "I": 1, "J": 8, "K": 5, "L": 1, "M": 3, "N": 1, "O": 1, "P": 3, "Q": 10, "R": 1, "S": 1, "T": 1, "U": 1, "V": 4, "W": 4, "X": 8, "Y": 4, "Z": 10]
    
    var numPlaced = 0 // number of letters that have been placed
    
    init() {
        fillBagOfLetters()
        resetBoard()
        readWordsDict()
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
        // is the cell empty?
        if (board[row][column].tile.letter != "") {
            return
        }
        
        // placed the letter in this cell
        board[row][column].tile = Tile(letter: bagOfLetters[numPlaced], score: tileScores[bagOfLetters[numPlaced]])
        
        // move on to next letter
        numPlaced += 1
    }
    
    // reads the words dictionary and keeps array of 3 to 5 letter words
    func readWordsDict() {
        
        if let fileURL = Bundle.main.url(forResource: "dictionary", withExtension: "txt") {
            do {
                let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
                let text: [String] = fileContents.components(separatedBy: "\n")
                
                Swift.print(text[0])
            } catch let error {
                Swift.print("Fatal Error: \(error.localizedDescription)")
            }
        }
    }
    
    // creates an empty board
    func resetBoard() {
        var newBoard = [[Cell]]()
        
        for _ in 0...4 {
            var row = [Cell]()
            for _ in 0...4 {
                row.append(Cell(tile: Tile(letter: "")))
            }
            
            newBoard.append(row)
        }
        board = newBoard
    }
}
