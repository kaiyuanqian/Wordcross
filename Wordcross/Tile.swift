//
//  Tile.swift
//  Wordcross
//
//  Created by Kaiyuan Qian on 1/2/2024.
//

import Foundation
import SwiftUI

struct Tile {
    var letter: String
    var score: Int?
    
    func displayTile() -> AnyView {
        
        if score != nil {
            return AnyView(HStack {
                Text(letter)
                    .font(.system(size: 60))
                
                Text(String(score!))
                    .font(.system(size: 22))
                    .offset(y: 15)
            }
                
                .foregroundColor(.black)
                .bold()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .background(Color.white)
                .border(.black, width: 1)
            )
        } else {
            return AnyView(HStack {
                Text(letter)
                    .font(.system(size: 60))
            }
                
                .foregroundColor(.black)
                .bold()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .background(Color.white)
                .border(.black, width: 1)
            )
        }
        
    }
}
