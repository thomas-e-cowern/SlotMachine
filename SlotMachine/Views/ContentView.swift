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
    @State private var highScore: Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    @State private var isActiveBet10: Bool = true
    @State private var isActiveBet20: Bool = false
    @State private var showModal: Bool = false
    @State private var animatingSymbol: Bool = false
    @State private var animatingModel: Bool = false
    
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
        UserDefaults.standard.set(highScore, forKey: "HighScore")
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
    
    func isGameOver() {
        if coins <= 0 {
            // MARK:  Show popup end of game
            showModal = true
        }
    }
    
    func resetGame() {
        highScore = 0
        UserDefaults.standard.set(highScore, forKey: "HighScore")
        coins = 100
        activateBet10()
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
                            .opacity(animatingSymbol ? 1 : 0)
                            .offset(y: animatingSymbol ? 0 : -150)
                            .animation(.easeOut(duration: Double.random(in: 0.5...1.0)), value: animatingSymbol)
                            .onAppear {
                                self.animatingSymbol.toggle()
                            }
                    }
                    
                    HStack (alignment: .center, spacing: 0) {
                        // MARK:  Reel 2
                        ZStack {
                            ReelsView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -150)
                                .animation(.easeOut(duration: Double.random(in: 0.5...1.0)), value: animatingSymbol)
                                .onAppear {
                                    self.animatingSymbol.toggle()
                                }
                        }
                        
                        Spacer()
                        
                        // MARK:  Reel 3
                        ZStack {
                            ReelsView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -150)
                                .animation(.easeOut(duration: Double.random(in: 0.5...1.0)), value: animatingSymbol)
                                .onAppear {
                                    self.animatingSymbol.toggle()
                                }
                        }
                    } // End of HStack
                    .frame(maxWidth: 500)
                    
                    // MARK:  Spin button
                    
                    Button (action: {
                        // MARK:  Animation default state
                        withAnimation {
                            self.animatingSymbol = false
                        }
                        
                        // MARK:  Spin reels
                        self.spinReels()
                        
                        // MARK:  Trigger animation
                        withAnimation   {
                            self.animatingSymbol = true
                        }
                        
                        // Check win
                        self.checkWinning()
                        
                        // MARK:  Game over
                        self.isGameOver()

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
                            .offset(x: isActiveBet20 ? 0 : 20)
                            .opacity(isActiveBet20 ? 1 : 0)
                            .modifier(CasinChipModifier())
                    } // End of HStack
                    
                    Spacer()
                    
                    // Bet 10
                    HStack (alignment: .center, spacing: 10) {
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .offset(x: isActiveBet10 ? 0 : -20)
                            .opacity(isActiveBet10 ? 1 : 0)
                            .modifier(CasinChipModifier())
                        
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
                    } // End of HStack
                    
                } // End of HStack
                
            } // End of VStack
            
            // MARK:  Buttons

            .overlay(
                Button(action: {
                    self.resetGame()
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
            .frame(maxWidth: 720)
            .blur(radius: $showModal.wrappedValue ? 5 : 0, opaque: false)

            // MARK:  Pop-up
            if $showModal.wrappedValue {
                ZStack {
                    Color("ColorTransparentBlack").edgesIgnoringSafeArea(.all)
                }
                
                // MARK:  Modal
                VStack (spacing: 0) {
                    
                    // MARK:  Title
                    Text("Game Over!")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.heavy)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color("ColorPink"))
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    // MARK:  Messge
                    VStack(alignment: .center, spacing: 16) {
                            Image("gfx-seven-reel")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 72)
                        
                        Text("Bad Luck, You Lost!. \n Lets Play Again")
                            .font(.system(.body, design: .rounded))
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.gray)
                            .layoutPriority(1)
                        
                        Button {
                            self.showModal = false
                            self.animatingModel = false
                            self.activateBet10()
                            self.coins = 100
                        } label: {
                            Text("New Game".uppercased())
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.semibold)
                                .accentColor(Color("ColorPink"))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .frame(minWidth: 128)
                                .background(
                                    Capsule()
                                        .strokeBorder(lineWidth: 1.75, antialiased: false)
                                        .foregroundColor(Color.pink
                                                        )
                                )
                        }
                    }
                    
                    Spacer()
                    
                }
                .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color("ColorTransparentBlack"), radius: 6, x: 0, y: 8)
                .opacity($animatingModel.wrappedValue ? 1 : 0)
                .offset(y: $animatingModel.wrappedValue ? 0 : -100)
                .animation(Animation.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0), value: animatingModel)
                .onAppear {
                    self.animatingModel = true
                }
            }
            
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
