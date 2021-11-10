//
//  RaisedButton.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 11/9/21.
//

import SwiftUI

struct RaisedButton: View {
    
    let buttonText: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }){
            Text(buttonText)
                .raisedButtonTextStyle()
        }
        .buttonStyle(RaisedButtonStyle())
        
    }
}

extension Text {
    func raisedButtonTextStyle () -> some View {
        self
            .font(.body)
            .fontWeight(.bold)
    }
}
//Notes
    /*Apple knows that you often want to style objects, so it created a range of style protocols for you to customize. You’ll find the list at https://apple.co/3kzvD2e. Styling text is not on that list, which is why you created your own view modifier.
     You’ve already used one of these styles, the built-in PageTabViewStyle, on your TabView. In the documentation, it appears that there are a number of button styles available, however most of these apply to specific operating systems. For example you can only use BorderedButtonStyle on macOS, tvOS and watchOS.
     You can customize buttons by setting up a structure that conforms to ButtonStyle
    */


struct RaisedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
        //When you set frame(maxWidth:) to .infinity, you ask the view to take up as much of the width as its parent gives it
            .padding([.top, .bottom], 12)
            .background(
                Capsule()
                //When you use Shapes, such as Rectangle, Circle and Capsule, the default fill color is black, so you’ll change that in your neumorphic style to match the background color
                    .foregroundColor(Color("background"))
                    .shadow(color: Color("drop-shadow"), radius: 4, x: 6, y: 6)
                    .shadow(color: Color("drop-highlight"), radius: 4, x: -6, y: -6)
                //The buttons work in Dark Mode too, because each color in the asset catalog has a value for both Light Mode and Dark Mode
            )
        
    }
}
//Here you make a simple style giving the button text a red background. ButtonStyle has one required method: makeBody(configuration:). The configuration gives you the button’s label text and a Boolean isPressed telling you whether the button is currently depressed
//Swift Tip: If you want to customize how the button action triggers with gestures, you can use PrimitiveButtonStyle instead of ButtonStyle

struct RaisedButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RaisedButton(buttonText: "Get Started"){print("Hello World")}
                .padding(20)
                .buttonStyle(RaisedButtonStyle()) //seems here that if a type has no properties but only methods,the methods are automatically called during initialization
            
        }
        .background(Color("background"))
        .previewLayout(.sizeThatFits)
        
    }
}
