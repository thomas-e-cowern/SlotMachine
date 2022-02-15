//
//  ContentView.swift
//  SlotMachine
//
//  Created by Thomas Cowern New on 2/14/22.
//

import SwiftUI

struct ContentView: View {
    
    // MARK:  Properties
    @State private var showInfoView: Bool = false
    @State private var reels = [0, 1, 2]
    @State private var highScore: Int = 0
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    @State private var isActiveBet10: Bool = true
    @State private var isActiveBet20: Bool = false
    
    let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
    
    // MARK:  Functions
    
    // MARK:  Sping reels
    func spinReels() {

        reels = reels.map({ _ in
            Int.random(in: 0...symbols.count - 1)
        })
    }
    

    // MARK:  Check if win
    func checkWinning() {
        if reels[0] == reels[1] && reels[2] == reels[2] && reels[0] == reels[2] {
            
            // MARK:  Player Wins
            playerWins()
            
            // MARK:  New high score?
            if coins > highScore {
                newHighScore()
            }
            
        } else {
            
            // MARK:  Player Loses
            playerLoses()
            
        }
    }
    
    func playerWins () {
        coins += betAmount * 10
    }
    
    func newHighScore () {
        highScore = coins
    }
    
    func playerLoses () {
        coins -= betAmount
    }
    
    func acivateBet20() {
        betAmount = 20
        isActiveBet20 = true
        isActiveBet10 = false
    }
   
    func activateBet10() {
        betAmount = 10
        isActiveBet10 = true
        isActiveBet20 = false
    }
    
    // MARK:  Game over
    
    // MARK:  Body
    var body: some View {
        ZStack (alignment:.center) {
            
            // MARK:  Background
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            // MARK:  Interface
            VStack (alignment: .center, spacing: 5) {
                    
                // MARK:  Header
                LogoView()
                
                Spacer()
                
                // MARK:  Score
                HStack {
                    HStack () {
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                       Text("\(coins)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    } // End of HStack
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack () {
                        Text("\(highScore)")
                             .scoreNumberStyle()
                             .modifier(ScoreNumberModifier())
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                       
                    } // End of HStack
                    .modifier(ScoreContainerModifier())
                } // End of HStack
                // MARK:  Slot Machine
                VStack (alignment: .center, spacing: 0) {
                    // MARK:  Reel 1
                    ZStack {
                        ReelsView()
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
                    HStack (alignment: .center, spacing: 0) {
                        // MARK:  Reel 2
                        ZStack {
                            ReelsView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        
                        Spacer()
                        
                        // MARK:  Reel 3
                        ZStack {
                            ReelsView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                    } // End of HStack
                    .frame(maxWidth: 500)
                    
                    // MARK:  Spin button
                    
                    Button (action: {
                        self.spinReels()
                        
                        // Check win
                        self.checkWinning()

                    }, label: {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    })
                    

                    
                    
                } // MARK:  End of slot machine
                .layoutPriority(2)
                // MARK:  Footer
                Spacer()
                
                HStack {
                    // MARK:  Bet 20
                    HStack (alignment: .center, spacing: 10) {
                        Button(action: {
                            self.acivateBet20()
                        }) {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet20 ? Color.yellow : Color.white)
                                .modifier(BetNumberModifier())
                        }
                        .modifier(BetCapsuleModifier()
                        )
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(isActiveBet20 ? 1 : 0)
                            .modifier(CasinChipModifier())
                    } // End of HStack
                    
                    // Bet 10
                    HStack (alignment: .center, spacing: 10) {
                        Button(action: {
                            self.activateBet10()
                        }) {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet10 ? Color.yellow : Color.white)
                                .modifier(BetNumberModifier())
                        }
                        .modifier(BetCapsuleModifier()
                        )
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(isActiveBet10 ? 1 : 0)
                            .modifier(CasinChipModifier())
                    } // End of HStack
                    
                } // End of HStack
                
            } // End of VStack
            
            // MARK:  Buttons

            .overlay(
                Button(action: {
                    print("Reset")
                }, label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                })
                    .modifier(ButtonModifier())
                , alignment: .topLeading
            )
            .padding()
            
            .overlay(
                Button(action: {
                    self.showInfoView = true
                }, label: {
                    Image(systemName: "info.circle")
                })
                    .modifier(ButtonModifier())
                    .padding()
                , alignment: .topTrailing
            )

            // MARK:  Pop-up
        } // End of ZStack
        .sheet(isPresented: $showInfoView) {
            InfoView()
        }
    }
}

// MARK:  Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
