//
//  ContentView.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/5/21.
//

import SwiftUI

struct ContentView: View {
    
    @SceneStorage("selectedTab") private var selectedTab = 9
    //Added an @SceneStorage property to ensure the app continues from the page a user was on in the event of exiting the app. It exposes a Binding as well through its projected value
    //@State private var selectedTab = 9
    
    var body: some View {
        ZStack {
            GradientBackground()
            TabView(selection: $selectedTab) {
                WelcomeView(selectedTab: $selectedTab)
                    .tag(9)
                ForEach(0 ..< Exercise.exercises.count){ index in
                    ExerciseView(selectedTab: $selectedTab, index: index)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
                
    }
        
        //Replaced Code
        /* TabView {
            WelcomeView()
            ForEach(0..<Exercise.exercises.count){index in
                ExerciseView(index: index)
            }
            
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        //Now, you’ll never show the index dots */
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.environment(\.sizeCategory, .accessibilityLarge)
           // .previewDevice("iPhone SE (2nd Generation)")
    }
}
