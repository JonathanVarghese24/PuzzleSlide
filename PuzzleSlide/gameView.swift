//
//  gameView.swift
//  PuzzleSlide
//
//  Created by JV on 1/31/25.
//


import SwiftUI

struct Tile: Identifiable {
    let id = UUID()
    var number: Int
    var isBlank: Bool
}

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
                    Button(action: {
                        handleTileTap(at: index)
                    }) {
                        if shuffledTiles[index].isBlank {
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
            
            if isPuzzleSolved() {
                Text("Congratulations! You solved the puzzle.")
                    .padding()
            }
        }
        .onAppear {
            shuffledTiles = tiles.shuffled()
        }
    }
    
    // Function to handle tile tap
    func handleTileTap(at index: Int) {
        // Check if the tapped tile is adjacent to the blank tile
        if isAdjacentToBlank(index: index) {
            // Swap the tapped tile with the blank tile
            swapTiles(at: index)
        }
    }
    
    // Function to check if a tile is adjacent to the blank tile
    func isAdjacentToBlank(index: Int) -> Bool {
        let blankIndex = shuffledTiles.firstIndex(where: { $0.isBlank }) ?? 0
        
        // Check if the indices are adjacent
        return abs(index - blankIndex) == 1 || abs(index - blankIndex) == 3
    }
    
    // Function to swap two tiles
    func swapTiles(at index: Int) {
        let blankIndex = shuffledTiles.firstIndex(where: { $0.isBlank }) ?? 0
        
        // Swap the tiles
        shuffledTiles.swapAt(index, blankIndex)
    }
    
    // Function to check if the puzzle is solved
    func isPuzzleSolved() -> Bool {
        // Check if the tiles are in ascending order
        return shuffledTiles.enumerated().allSatisfy { index, tile in
            if tile.isBlank {
                return index == 8
            } else {
                return tile.number == index + 1
            }
        }
    }
}

// Preview the game view
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
