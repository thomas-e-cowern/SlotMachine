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
        ZStack () {
            
            // MARK:  Background
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            // MARK:  Interface
            VStack (alignment: .center, spacing: 5) {
                    
                // MARK:  Header
                LogoView()
                
                Spacer()
                
                // MARK:  Score
                HStack () {
                    Text("Your\nCoins".uppercased())
                        .foregroundColor(Color.white)
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                   Text("100")
                        .foregroundColor(Color.white)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.heavy)
                        .shadow(color: Color("ColorTransparentBlack"), radius: 0, x: 0, y: 3)
                        .layoutPriority(1)
                } // End of HStack
                .padding(.vertical, 4)
                .padding(.horizontal, 16)
                .frame(minWidth: 128)
                .background(
                    Capsule()
                        .foregroundColor(Color("ColorTransparentBlack"))
                )
                
                // MARK:  Slot Machine
                // MARK:  Footer
                
                Spacer()
            }
            
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

                // MARK:  Reset
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
