//
//  SuccessView.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/21/21.
//

import SwiftUI

struct SuccessView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedTab: Int
    
    /*
     @Environment(\.presentationMode) gives read access to the environment variable referenced by the key path \.presentationMode.
     Every view’s environment has properties like colorScheme, locale and the device’s accessibility settings. Many of these are inherited from the app, but a view’s presentationMode is specific to the view. It’s a binding to a structure with an isPresented property and a dismiss() method.
     When you’re viewing SuccessView, its isPresented value is true. You want to change this value to false when the user taps the Continue button. But the @Environment property wrapper doesn’t let you set an environment value directly. You can’t write presentationMode.isPresented = false
     You will need to write it as presentationMode.wrappedValue.dismiss()
     You access the underlying PresentationMode instance as the wrappedValue of the presentationMode binding, then call the PresentationMode method dismiss(). This method isn’t a toggle. It dismisses the view if it’s currently presented. It does nothing if the view isn’t currently presented
     */
    
    var body: some View {
        ZStack  {
            VStack {
                Spacer()
                Button(action:{
                    presentationMode.wrappedValue.dismiss()
                    selectedTab = 9
                }){
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
        SuccessView(selectedTab: .constant(3))
    }
}
