//
//  ContentView.swift
//  Wordcross
//
//  Created by Kaiyuan Qian on 28/1/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var gameState = GameState()
    
    var body: some View {
        let borderSize = CGFloat(-1)
        
        VStack(spacing: borderSize) {
            ForEach(0...4, id: \.self) {
                row in
                HStack(spacing: borderSize) {
                    ForEach(0...4, id: \.self) {
                        column in
                        
                        let cell = gameState.board[row][column]
                        
                        cell.tile.displayTile()
                            .onTapGesture {
                                gameState.placeLetter(row, column)
                            }
                    }
                }
            }
            Spacer()
            HStack(spacing: 5) {
                ForEach(0...24, id: \.self) {
                    i in
                    let letter = gameState.bagOfLetters[i]
                    Text(letter)
                        .font(.system(size: 13))
                        .bold()
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white)
                }
            }
            
        }

        .padding()
    }
}

#Preview {
    ContentView()
}
