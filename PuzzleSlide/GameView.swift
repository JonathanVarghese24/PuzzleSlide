//
//  gameView.swift
//  PuzzleSlide
//
//  Created by JV on 1/31/25.
//

import SwiftUI

struct GameView: View {
    @State private var tiles: [Tile] = [
        Tile(number: 1, isBlank: false),
        Tile(number: 2, isBlank: false),
        Tile(number: 3, isBlank: false),
        Tile(number: 4, isBlank: false),
        Tile(number: 5, isBlank: false),
        Tile(number: 6, isBlank: false),
        Tile(number: 7, isBlank: false),
        Tile(number: 8, isBlank: false),
        Tile(number: 0, isBlank: true)
    ]
    
    @State private var shuffledTiles: [Tile] = []
    
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
                ForEach(shuffledTiles.indices, id: \.self) { index in
                    // Button for each tile
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            handleTileTap(at: index)
                        }
                    }) {
                        if shuffledTiles[index].isBlank {
                            // Blank tile is gray
                            Text("")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.gray.opacity(0.2))
                        } else {
                            Text("\(shuffledTiles[index].number)")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(height: 50)
                    .cornerRadius(5)
                }
            }
            .padding()
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: shuffledTiles)
            
            if isPuzzleSolved() {
                Text("Congratulations! You solved the puzzle.")
                    .padding()
            }
        }
        .onAppear {
            shuffledTiles = tiles.shuffled()
        }
    }
    
    func handleTileTap(at index: Int) {
        if isAdjacentToBlank(index: index) {
            // Swap the tapped tile with the blank tile
            swapTiles(at: index)
        }
    }
    
    func isAdjacentToBlank(index: Int) -> Bool {
        // find the index of the blank tile
        let blankIndex = shuffledTiles.firstIndex(where: { $0.isBlank }) ?? 0
        
        // Check if the indices are adjacent, horizontally or vertically
        return abs(index - blankIndex) == 1 || abs(index - blankIndex) == 3
    }
    
    func swapTiles(at index: Int) {
        // finds blank tile and swaps position with tile that is clicked
        let blankIndex = shuffledTiles.firstIndex(where: { $0.isBlank }) ?? 0
        // Swap the tiles
        shuffledTiles.swapAt(index, blankIndex)
    }
    
    func isPuzzleSolved() -> Bool {
        // Used AI to help check that all numbers are in correct numerical order
        // Check if the tiles are in ascending order (except for the blank tile at the end)
        return shuffledTiles.enumerated().allSatisfy { index, tile in
            if tile.isBlank {
                // Blank tile should be at the end
                return index == 8
            } else {
                // Checks to see if numbers are in order
                return tile.number == index + 1
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

struct Tile: Identifiable, Equatable {
    let id = UUID()
    var number: Int
    var isBlank: Bool //empty space tile
    
    // function to make sure there isnt any duplicate tiles
    //checks to see if tiles to the left and right of a current tile are equal value
    static func == (lhs: Tile, rhs: Tile) -> Bool {
        return lhs.number == rhs.number && lhs.isBlank == rhs.isBlank
    }
}
