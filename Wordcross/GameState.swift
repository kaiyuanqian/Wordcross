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
    @Published var foundWords = [String]()
    
    let alphabet: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    let bagSize = 25
    let tileScores = ["A": 1, "B": 3, "C": 3, "D": 2, "E": 1, "F": 4, "G": 2, "H": 4, "I": 1, "J": 8, "K": 5, "L": 1, "M": 3, "N": 1, "O": 1, "P": 3, "Q": 10, "R": 1, "S": 1, "T": 1, "U": 1, "V": 4, "W": 4, "X": 8, "Y": 4, "Z": 10]
    let maxWordLen = 5
    let minWordLen = 3
    
    var numPlaced = 0 // number of letters that have been placed
    
    var allWords = [String]()
    
    init() {
        fillBagOfLetters()
        resetBoard()
        readWordsDict()
        retainSuitableWords()
        
    }
    
    // fills bag of letters
    func fillBagOfLetters() {
        for _ in 0..<bagSize {
            let rand = Int(arc4random_uniform(26))
            bagOfLetters.append(alphabet[rand])
        }
    }
    
    // places a letter on the board and checks whether any words were formed
    func placeLetter(_ row: Int, _ column: Int) {
        // is the cell empty?
        if (board[row][column].tile.letter != "") {
            return
        }
        
        // placed the letter in this cell
        board[row][column].tile = Tile(letter: bagOfLetters[numPlaced], score: tileScores[bagOfLetters[numPlaced]])
        
        // move on to next letter
        numPlaced += 1
        
        newWords(row, column)
    }
    
    // calculates the number of letters directly before the letter that just got placed
    func leftLength(_ row: Int, _ column: Int) -> Int {
        var currCol = column // we initially start w the new letter which was placed in this column
        var leftLen = 0
        var tile: Tile = board[row][currCol].tile
        
        while tile.letter != "" && currCol > 0 {
            tile = board[row][currCol - 1].tile
            currCol -= 1
            if tile.letter != "" {
                leftLen += 1
            }
        }

        return leftLen
    }
    
    // calculates the number of letters directly after the letter that just got placed
    func rightLength(_ row: Int, _ column: Int) -> Int {
        var currCol = column // we initially start w the new letter which was placed in this column
        var rightLen = 0
        var tile: Tile = board[row][currCol].tile
        
        while tile.letter != "" && currCol < maxWordLen - 1 {
            tile = board[row][currCol + 1].tile
            currCol += 1
            if tile.letter != "" {
                rightLen += 1
            }
        }

        return rightLen
    }

    // check for new words created when a new character is placed
    func newWords(_ row: Int, _ column: Int) -> [String] {
        var leftLen = leftLength(row, column)
        var rightLen = rightLength(row, column)
        var currWord = ""
        var newWords: [String] = []
        
        if leftLen + rightLen + 1 >= minWordLen  {
            for i in 0...leftLen {
                if i + 1 + rightLen >= minWordLen {
                    var startCol = column - i // we are searching for words starting at this point
                    var maxLen = i + 1 + rightLen
                    
                    for j in max(i + 1, minWordLen)...maxLen {
                        for k in 0...j {
                            currWord.append(board[row][startCol + k].tile.letter)
                        }
                        
                        if allWords.contains(currWord) {
                            newWords.append(currWord)
                            Swift.print(currWord)
                        }
                        currWord = ""
                    }
                }
            }
        } else {
            return newWords
        }

        return newWords
    }
    
    // reads the words dictionary
    func readWordsDict() {
        
        if let fileURL = Bundle.main.url(forResource: "dictionary", withExtension: "txt") {
            do {
                let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
                allWords = fileContents.components(separatedBy: "\n")
                
                
                Swift.print(allWords[0])
            } catch let error {
                Swift.print("Fatal Error: \(error.localizedDescription)")
            }
        }
    }
    
    // remove every word that isn't between 3 and 5 characters in length
    func retainSuitableWords() {
        Swift.print(allWords.count)
        allWords.removeAll { $0.count > maxWordLen}
        allWords.removeAll { $0.count < minWordLen}
        Swift.print(allWords.count)
        Swift.print(allWords[0])
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
