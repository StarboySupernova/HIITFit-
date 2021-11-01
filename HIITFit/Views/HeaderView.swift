//
//  HeaderView.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/14/21.
//

import SwiftUI

struct HeaderView: View {
    
    @Binding var selectedTab: Int
    let titleText: String
    
    var body: some View {
        VStack {
            Text(titleText)
                .font(.largeTitle)
            HStack {
                ForEach (0 ..< Exercise.exercises.count) { index in
                    let fill = index == selectedTab ? ".fill" : ""
                    Image(systemName: "\(index + 1).circle\(fill)")
                        .onTapGesture {
                            selectedTab = index
                        }
                }
                
            //Obsoleted in favour of using ForEach to calculate which image to use
            //The Welcome page doesn’t really need a page “number”, so we delete the "hand.wave" symbol from the HStack
            /*  Image(systemName: "hand.wave")
                Image(systemName: "1.circle")
                Image(systemName: "2.circle")
                Image(systemName: "3.circle")
                Image(systemName: "4.circle")  */
            }
            .font(.title2)
            
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeaderView(selectedTab: .constant(0),titleText: "Squat")
                .previewLayout(.sizeThatFits)
            HeaderView(selectedTab: .constant(1),titleText: "Step-Up")
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory, .accessibilityLarge)
                .previewLayout(.sizeThatFits)
        }
    }
}
