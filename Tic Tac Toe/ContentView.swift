//
//  ContentView.swift
//  Tic Tac Toe
//
//  Created by Nolan Brian McSweeney on 10/14/24.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = Array(repeating: "", count: 9 )
    @State private var xTurn = true
    @State private var gameOver = false
    @State private var winMessage = ""
    var body: some View {
        VStack {
            
            //Tic tac toe text
            Text("Tic Tac Toe")
                .font(.title).bold()
            //Grid with the x and o
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(120)), count: 3), content: {
                //Loop that asigns value
                ForEach(0..<9) { index in
                    ZStack {
                        Color.blue
                        Color.white
                            .opacity(moves[index] == "" ? 1 : 0)
                        Text(moves[index])
                            .font(.system(size: 90))
                            .fontWeight(.heavy)
                    }
                    .frame(width: 120, height: 120, alignment: .center)
                    .cornerRadius(30)
                    //Tap gesture that turns it into a X when tapped
                    .onTapGesture {
                        //Makes it where you can only change value once
                        //Animation
                        withAnimation(.default) {
                            if moves[index] == "" {
                                moves[index] = xTurn ? "X" : "O"
                                //Sets xTurn to true or false
                                xTurn.toggle()
                            }
                        }
                    }
                    //Rotation animation
                    .rotation3DEffect(.degrees(moves[index] == "" ? 180 : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
                }
            })
            
            
        }
        //Background color
        .preferredColorScheme(.dark)
        
        //Alert fot game win
        .alert(isPresented: $gameOver) {
            Alert(title: Text(winMessage), dismissButton: .destructive(Text("Play again"),
            action: {
                withAnimation {
                    moves = Array(repeating: "", count: 9)
                    gameOver = false
                }
            }))
        }
        //On change
        .onChange(of: moves) {
            oldValue, newValue in checkForWinner()
        }
    }
    //Function for game win
    private func checkForWinner() {
        checkLine(a: 0, b: 1, c: 2)
        checkLine(a: 3, b: 4, c: 5)
        checkLine(a: 6, b: 7, c: 8)
        checkLine(a: 0, b: 4, c: 8)
        checkLine(a: 2, b: 4, c: 6)
        checkLine(a: 2, b: 5, c: 8)
        checkLine(a: 0, b: 3, c: 6)
        checkLine(a: 1, b: 4, c: 7)
        
        if !(gameOver || moves.contains("")) {
            winMessage = "Cat's Game"
            gameOver = true
        }
    }
    //New function for all possible wins
    private func checkLine(a: Int, b: Int, c: Int) {
        if moves[a] != "" && moves[a] == moves[b] && moves[b] == moves[c] {
            winMessage = "\(moves[a]) is the winner!"
            gameOver = true
        }
    }
}


#Preview {
    ContentView()
}
