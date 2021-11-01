//
//  ContentView.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/5/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 9
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            WelcomeView(selectedTab: $selectedTab)
                .tag(9)
            ForEach(0 ..< Exercise.exercises.count){ index in
                ExerciseView(selectedTab: $selectedTab, index: index)
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
