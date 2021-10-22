//
//  ContentView.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/5/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            WelcomeView()
            ForEach(0..<Exercise.exercises.count){index in
                ExerciseView(index: index)
            }
            
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        //Now, you’ll never show the index dots
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
