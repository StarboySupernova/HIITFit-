//
//  RaisedButton.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 11/9/21.
//

import SwiftUI

struct RaisedButton: View {
    var body: some View {
        Button(action: {}){
            Text("Get Started")
                .raisedButtonStyle()
        }
        
    }
}

extension Text {
    func raisedButtonStyle () -> some View {
        self
            .font(.body)
            .fontWeight(.bold)
    }
}

struct RaisedButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RaisedButton()
                .padding(20)
        }
        .background(Color("background"))
        .previewLayout(.sizeThatFits)
        
    }
}
