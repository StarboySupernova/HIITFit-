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
    
    @Binding var selectedTab : Int
    @State private var rating = 0
    
    let index: Int
    //index is local to exercise view, so it cannot be used in HeaderView extracted subview that was subsequently ported to headerView.swift
    
    let interval: TimeInterval = 30
    
    var lastExercise: Bool {
        index + 1 == Exercise.exercises.count
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HeaderView(selectedTab:
                            $selectedTab,
                           titleText:
                            Exercise.exercises[index].exerciseName
                )
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
                HStack(spacing: 150){
                    Button(NSLocalizedString ("Start", comment: "begin exercise")) {}
                    Button(NSLocalizedString("Done", comment: "mark as finished"))
                        {selectedTab = lastExercise ? 9 : selectedTab + 1}
                }
                .font(.title3)
                .padding()
                /*Button(NSLocalizedString( "Start/Done", comment: "begin exercise / mark as finished")) {}
                    .font(.title3)
                    .padding()*/
                
                RatingsView(rating: $rating)
                    .padding()
                
                Spacer()
                Button(NSLocalizedString("History", comment: "view user activity")){}
                    .padding(.bottom)
                
            }
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(selectedTab: .constant(1), index: 0)
    }
}

