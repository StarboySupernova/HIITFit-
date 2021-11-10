//
//  WelcomeView.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/5/21.
//

import SwiftUI

struct WelcomeView: View {
    
    @Binding var selectedTab : Int
    @State private var showHistory = false
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView(selectedTab:
                            $selectedTab,
                           titleText:
                            NSLocalizedString("Welcome", comment: "greeting")
                )
                Spacer()
                /* Button(
                    NSLocalizedString("History", comment: "view user activity")){
                        showHistory.toggle()
                    }
                    .sheet(isPresented: $showHistory){
                        HistoryView(showHistory: $showHistory)
                    }
                .padding(.bottom) */
                historyButton
                    .sheet(isPresented: $showHistory){
                        HistoryView(showHistory: $showHistory)
                    }
            }
            VStack {
                HStack(alignment: .bottom) {
                    VStack (alignment: .leading) {
                    Text(
                        NSLocalizedString("Get Fit", comment: "invitation to exercise"))
                        .font(.largeTitle)
                    Text("with high intensity interval training")
                        .font(.headline)
                    } //This VStack is in an HStack because you’re going to place an Image to the right of the text. And the HStack is in an outer VStack because you’ll add a Button below the text and image
                    Image("step-up")
                        .resizedToFill(width: 240, height: 240)
                        .clipShape(Circle())
                    //encapsulated in an extension
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 240.0, height: 240.0)
                        
                    
                }
                /* Replaced code.Replaced by the more succint and abstract getStartedButton line
                 Button(action:{selectedTab = 0}){
//                    Label("Get Started", systemImage: "arrow.right.circle")
                    Text(NSLocalizedString("Get Started", comment: "invitation"))
                        .raisedButtonTextStyle()
                }
                .buttonStyle(RaisedButtonStyle())
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 2))
                 Replaced code */
                getStartedButton
            }
        }
    }
    
    var historyButton: some View {
        Button(action: {showHistory = true}, label: {
            Text("History")
                .fontWeight(.bold)
                .padding([.leading, .trailing], 5)
        })
            .padding(.bottom, 10)
            .buttonStyle(EmbossedButtonStyle())
    }
    
    var getStartedButton: some View {
        RaisedButton(
            buttonText: NSLocalizedString("Get Started", comment: "invitation"),
            action: {selectedTab = 0
        })
            .padding()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(selectedTab: .constant(9))
    }
}
