//
//  GradientBackground.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 11/11/21.
//

import SwiftUI

struct GradientBackground: View {
    
    var gradient: Gradient {
        //You can control where the gradient changes using stops
        let color1 = Color("gradient-top")
        let color2 = Color("gradient-bottom")
        let background = Color("background")
        
        return Gradient(stops: [
            Gradient.Stop(color: color1, location: 0),
            Gradient.Stop(color: color2, location: 0.9),
            Gradient.Stop(color: background, location: 0.9),
            Gradient.Stop(color: background, location: 1)
        ])
        //Here you use purple to blue for 90% of the gradient. At the 90% mark, you switch to the background color for the rest of the gradient. As you have two stops right next to each other, you get a sharp line across instead of a gradient. If you want a striped background, you can achieve this using color stops in this way
    }
    
    var body: some View {
        LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
}

struct GradientBackground_Previews: PreviewProvider {
    static var previews: some View {
        GradientBackground()
            .frame(width: 300, height: 300)
            .previewLayout(.sizeThatFits)
    }
}
