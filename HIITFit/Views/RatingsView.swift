//
//  RatingsView.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/14/21.
//

import SwiftUI

struct RatingsView: View {
    var body: some View {
        HStack {
            ForEach(0 ..< 5) { _ in
                Image(systemName: "waveform.path.ecg")
                    .foregroundColor(.gray)
                    .font(.largeTitle)
            }
        }
    }
}

struct RatingsView_Previews: PreviewProvider {
    static var previews: some View {
        RatingsView()
            .previewLayout(.sizeThatFits)
        
    }
}
