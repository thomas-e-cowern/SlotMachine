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
    
    let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
    
    // MARK:  Functions
    func spinReels() {
        reels[0] = Int.random(in: 0...symbols.count - 1)
        reels[1] = Int.random(in: 0...symbols.count - 1)
        reels[2] = Int.random(in: 0...symbols.count - 1)
    }
    
    // MARK:  Sping reels
    
    // MARK:  Check if win
    
    // MARK:  Wins
    
    // MARK:  New high score
    
    // MARK:  Loses
    
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
                       Text("100")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    } // End of HStack
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack () {
                        Text("200")
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
                    Button {
                        self.spinReels()
                    } label: {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                        
                    }

                    
                    
                } // MARK:  End of slot machine
                .layoutPriority(2)
                // MARK:  Footer
                Spacer()
                
                HStack {
                    // MARK:  Bet 20
                    HStack (alignment: .center, spacing: 10) {
                        Button(action: {
                            print("Bet 20 coins")
                        }) {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                                .modifier(BetNumberModifier())
                        }
                        .modifier(BetCapsuleModifier()
                        )
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(0)
                            .modifier(CasinChipModifier())
                    } // End of HStack
                    
                    // Bet 10
                    HStack (alignment: .center, spacing: 10) {
                        Button(action: {
                            print("Bet 10 coins")
                        }) {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.yellow)
                                .modifier(BetNumberModifier())
                        }
                        .modifier(BetCapsuleModifier()
                        )
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(1)
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
