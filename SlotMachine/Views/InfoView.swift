//
//  InfoView.swift
//  SlotMachine
//
//  Created by Thomas Cowern New on 2/15/22.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack (alignment: .center, spacing:  10) {
            LogoView()
            
            Spacer()
            
            Form {
                Section (header: Text("About Slot Machine")) {
                    FormRowView(firstItem: "Application", secondItem: "Slot Machine")
                    FormRowView(firstItem: "Platforms", secondItem: "iPhone, iPad, Mac")
                    FormRowView(firstItem: "Developer", secondItem: "Thomas E Cowern")
                    FormRowView(firstItem: "Designer", secondItem: "Robert Petras")
                    FormRowView(firstItem: "Music", secondItem: "Dan Lebowitz")
                    FormRowView(firstItem: "Copyright", secondItem: "2022")
                    FormRowView(firstItem: "Version", secondItem: "1.0.0")
                }
            }
            .font(.system(.body, design: .rounded))
        } // End of VStack
        .padding(.top)
        .overlay(
            Button(action: {
                print("Info Page Closed")
            }, label: {
                Image(systemName: "xmark.circle")
            })
                .padding(.top, 20)
                .padding(.trailing, 20)
                .foregroundColor(Color.red)
                .font(.system(.headline, design: .rounded))
            , alignment: .topTrailing
            
        )
    }
}

struct FormRowView: View {
    
    var firstItem: String
    var secondItem: String
    
    var body: some View {
        HStack () {
            Text(firstItem).foregroundColor(Color.gray)
            Spacer()
            Text(secondItem)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}


