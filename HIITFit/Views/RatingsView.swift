//
//  RatingsView.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/14/21.
//

import SwiftUI

struct RatingsView: View {
    
    @Binding var rating: Int
    let maximumRating = 5
    
    let onColor = Color.orange
    let offColor = Color.blue
    
    var body: some View {
        HStack {
            ForEach(1 ..< maximumRating + 1) { index in
                Image(systemName: "waveform.path.ecg")
                    .foregroundColor(index > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = index
                    }
            }
        }
        .font(.largeTitle)
    }
}

struct RatingsView_Previews: PreviewProvider {
    static var previews: some View {
        RatingsView(rating: .constant(3))
            .previewLayout(.fixed(width: 300, height: 100))
        
    }
}
