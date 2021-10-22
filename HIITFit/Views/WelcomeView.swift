//
//  WelcomeView.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/5/21.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            VStack {
                HeaderView(titleText: "Welcome")
                Spacer()
                Button("History"){}
                .padding(.bottom)
            }
            VStack {
                HStack(alignment: .bottom) {
                    VStack (alignment: .leading) {
                    Text("Get fit")
                        .font(.largeTitle)
                    Text("with high intensity interval training")
                        .font(.headline)
                    } //This VStack is in an HStack because you’re going to place an Image to the right of the text. And the HStack is in an outer VStack because you’ll add a Button below the text and image
                    Image("step-up")
                        .resizedToFill(width: 240, height: 240)
                        .clipShape(Circle())
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 240.0, height: 240.0)
                        
                    
                }

                Button(action:{}){
//                    Label("Get Started", systemImage: "arrow.right.circle")
                    Text("Get Started")
                        .padding(.leading)
                    Image(systemName: "arrow.right.circle")
                        .font(.title2)
                        .padding()
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 2))

                
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
