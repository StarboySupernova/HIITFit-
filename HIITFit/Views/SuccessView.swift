//
//  SuccessView.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/21/21.
//

import SwiftUI

struct SuccessView: View {
    var body: some View {
        ZStack  {
            VStack {
                Spacer()
                Button(action:{}){
                    Text("Continue")
                }
                .padding()
            }
            
            VStack {
                Image(systemName: "hand.raised.fill")
                    .resizedToFill(width: 75, height: 75)
                    .foregroundColor(.purple)
                Text("High Five")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
    /* we could have used the following code instead of 3 text views but I opted against it because of the need to hard code the frame, which I feel is kind of hacky, and using multiline strings has some indentation problmes I am yet to resolve
     
        Text("Good job completing all four exercises! Remember tomorrow is    another day. So eat well and get some rest")
                    .frame(width: 200, height: 200)
                    .multilineTextAlignment(.center) */
                
                Text("Good job completing all four exercises!")
                    .foregroundColor(.gray)
                Text("Remember tomorrow is another day")
                    .foregroundColor(.gray)
                Text("So eat well and get some rest")
                    .foregroundColor(.gray)
            }
            
        }
        
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
