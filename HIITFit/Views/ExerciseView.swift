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
    
    // @AppStorage("rating") private var rating = 0
    // Now that you’re going to store ratings, RatingView is a better source of truth than ExerciseView. Instead of storing ratings in ExerciseView, you’ll pass the current exercise index to RatingView, which can then read and write the rating
    //So that's why we had to delete @AppStorage in favour of using the string index
    // * * * * * * * * * * * * * * * * * * * * * * *
    
    //You set up a ratings view that allows the user to rate the exercise difficulty from one to five. You’ll save this rating to UserDefaults so that your ratings don’t disappear when you close the app. We will use @AppStorage for that and remove the @State variable
    /*when we did the above, passing $rating to the ratings view init in this folder still worked, which leads us to surmise that @AppStorage exposes a binding somehow */
    //deleted state variable
    // @State private var rating = 0
    
    @State private var showHistory = false
    @State private var showSuccess = false
    
    @State private var showTimer = false
    @State private var timerDone = false
    
    @EnvironmentObject var history: HistoryStore
    
    let index: Int
    //index is local to exercise view, so it cannot be used in HeaderView extracted subview that was subsequently ported to headerView.swift
    
    // deleted code //let interval: TimeInterval = 30
    
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
                
                
                HStack(spacing: 150){
                    Button(NSLocalizedString ("Start", comment: "begin exercise")) {
                        showTimer.toggle()
                    }
                    Button(NSLocalizedString("Done", comment: "mark as finished")){
                        history.addDoneExercise(Exercise.exercises[index].exerciseName)
                        timerDone = false
                        showTimer.toggle()
                        
                        if lastExercise {
                            showSuccess.toggle()
                        } else {
                            selectedTab += 1
                        }
                            //selectedTab = lastExercise ? 9 : selectedTab + 1
                            
                    }
                    .disabled(!timerDone)
                    .sheet(isPresented: $showSuccess){
                        SuccessView(selectedTab: $selectedTab)
                    }
                }
                .font(.title3)
                .padding()
                
                
                if showTimer {
                    TimerView(timerDone: $timerDone)
                }
                
                //deleted code
                //  Text(Date().addingTimeInterval(interval), style: .timer)
                //    .font(.system(size: 90))
                //this displays the discrepancy between the date value and the current time. Since we set date to be 30s in the future (Date.addingTimeInterval) it will count down as it approaches the current time. When the timer hits 0 it will start counting up again as the difference between that date and the current time grows again. This is just for the prototype, we'll use a real timer later
                Spacer()
                
                RatingsView(exerciseIndex: index)
                    .padding()
                
                
                Button(NSLocalizedString("History", comment: "view user activity")){
                    showHistory.toggle()
                }
                .sheet(isPresented: $showHistory){
                    HistoryView(showHistory: $showHistory)
                }
                    .padding(.bottom)
                
            }
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(selectedTab: .constant(0), index: 0)
            .environmentObject(HistoryStore())
    }
}

