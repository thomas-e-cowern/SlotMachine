//
//  ContentView.swift
//  SlotMachine
//
//  Created by Thomas Cowern New on 2/14/22.
//

import SwiftUI

struct ContentView: View {
    
    // MARK:  Properties
    
    
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
                        Image("gfx-bell")
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
                    HStack (alignment: .center, spacing: 0) {
                        // MARK:  Reel 2
                        ZStack {
                            ReelsView()
                            Image("gfx-seven")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        
                        Spacer()
                        
                        // MARK:  Reel 3
                        ZStack {
                            ReelsView()
                            Image("gfx-cherry")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                    } // End of HStack
                    .frame(maxWidth: 500)
                    
                    // MARK:  Spin button
                    Button {
                        print("Sping the wheels")
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
                    Button(action: {
                        print("Bet 20 coins")
                    }) {
                        Text("20")
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                            .font(.system(.title, design: .rounded))
                            .padding(.vertical, 5)
                            .frame(width: 90)
                            .shadow(color: Color("ColorTransparentBlack"), radius: 0, x: 0, y: 3)
                    }
                    .background(
                        Capsule()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom))
                    )
                    .padding(3)
                    .background(
                        Capsule()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .bottom, endPoint: .top))
                    )
                    
                }
                
            } // End of VStack
            
            // MARK:  Buttons
            .overlay(alignment: .topLeading, content: {

                // MARK:  Reset
                Button {
                    print("Reset the game")
                } label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                }
                .modifier(ButtonModifier())
            })
            .padding()
            
            .overlay(alignment: .topTrailing, content: {

                // MARK:  Info
                Button {
                    print("Info")
                } label: {
                    Image(systemName: "info.circle")
                }
                .modifier(ButtonModifier())
            })
            .padding()

            // MARK:  Pop-up
        } // End of ZStack
    }
}

// MARK:  Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
