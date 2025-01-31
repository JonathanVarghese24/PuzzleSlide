//
//  ContentView.swift
//  PuzzleSlide
//
//  Created by JV on 1/31/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                
                VStack {
                    Text("Sliding Puzzle")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("Challenge Your Mind!")
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    NavigationLink(destination: gameView()) {
                        Text("Start Game")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
