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
        let borderSize = CGFloat(0)
        
        VStack(spacing: borderSize) {
            ForEach(0...4, id: \.self) {
                row in
                HStack(spacing: borderSize) {
                    ForEach(0...4, id: \.self) {
                        column in
                        
                        let cell = gameState.board[row][column]
                        Text(cell.displayTile())
                            .font(.system(size: 60))
                            .foregroundColor(.black)
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .background(Color.white)
                            .border(.black)
                    }
                }
            }
        }
        // .background(Color.black)
        .padding()
    }
}

#Preview {
    ContentView()
}
