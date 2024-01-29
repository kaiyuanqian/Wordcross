//
//  GameState.swift
//  Wordcross
//
//  Created by Kaiyuan Qian on 28/1/2024.
//

import Foundation

class GameState: ObservableObject {
    
    @Published var board = [[Cell]]()
    
    init() {
        resetBoard()
    }
    
    // creates an empty board
    func resetBoard() {
        var newBoard = [[Cell]]()
        
        for _ in 0...4 {
            var row = [Cell]()
            for _ in 0...4 {
                row.append(Cell())
            }
            
            newBoard.append(row)
        }
        board = newBoard
    }
}
