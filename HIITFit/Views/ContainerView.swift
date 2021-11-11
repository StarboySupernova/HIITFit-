//
//  ContainerView.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 11/10/21.
//

import SwiftUI

struct ContainerView<Content: View>: View {
    
    var content: Content
    
    init(@ViewBuilder content: () -> Content){
        //You mark the closure method with the @ViewBuilder attribute, allowing it to return multiple child views of any type, essentially, a TupleView
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("background"))
            VStack{
                Spacer()
                Rectangle()
                    .frame(height: 25)
                    .foregroundColor(Color("background"))
                //Here you create a rounded rectangle using the background color from the asset catalog. You don’t want the bottom corners to be rounded, so you add a rectangle with sharp corners at the bottom to cover up the corners
            }
            content
        }
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView {
            VStack {
                RaisedButton(buttonText: "Hello!", action: {})
                    .padding(50)
                Button("Tap me!"){}
                    .buttonStyle(EmbossedButtonStyle(buttonShape: .round))
            }
        }
        .padding(50)
        .previewLayout(.sizeThatFits)
    }
}
