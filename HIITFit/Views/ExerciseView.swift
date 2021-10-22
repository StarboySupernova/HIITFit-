//
//  ExerciseView.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/5/21.
//

import SwiftUI
import AVKit

struct ExerciseView: View {
    let videoNames = ["squat", "step-up", "burpee", "sun-salute", ]
    let exerciseNames = ["Squat", "Step Up", "Burpee", "Sun Salute"]
    let index: Int
    //index is local to exercise view, so it cannot be used in HeaderView extracted subview that was subsequently ported to headerView.swift
    let interval: TimeInterval = 30
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HeaderView(titleText: Exercise.exercises[index].exerciseName)
                    .padding(.bottom)
                if let url =
                    Bundle.main.url(forResource: Exercise.exercises[index].videoName, withExtension: "mp4") {
                    VideoPlayer(player: AVPlayer(url: url))
                        .frame(height: geometry.size.height * 0.45)
                } else {
                    Text("Couldn't find \(videoNames[index])")
                        .foregroundColor(.red)
                }
                
                Text(Date().addingTimeInterval(interval), style: .timer)
                    .font(.system(size: 90))
                //this displays the discrepancy between the date value and the current time. Since we set date to be 30s in the future (Date.addingTimeInterval) it will count down as it approaches the current time. When the timer hits 0 it will start counting up again as the difference between that date and the current time grows again. This is just for the prototype, we'll use a real timer later
                
                Button("Start/Done") {}
                    .font(.title3)
                    .padding()
                
                RatingsView()
                    .padding()
                
                Spacer()
                Button("History button"){}
                    .padding(.bottom)
                
            }
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(index: 0)
    }
}

