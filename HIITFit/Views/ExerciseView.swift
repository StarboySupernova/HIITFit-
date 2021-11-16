//
//  ExerciseView.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/5/21.
//

import SwiftUI
import AVKit

struct ExerciseView: View {

    
    /* deleted hardcoded data
     let videoNames = ["squat", "step-up", "burpee", "sun-salute", ]
    let exerciseNames = ["Squat", "Step Up", "Burpee", "Sun Salute"] */
    
    @Binding var selectedTab : Int
    
    // @AppStorage("rating") private var rating = 0
    // Now that you’re going to store ratings, RatingView is a better source of truth than ExerciseView. Instead of storing ratings in ExerciseView, you’ll pass the current exercise index to RatingView, which can then read and write the rating
    //So that's why we had to delete @AppStorage in favour of using the string index
    // * * * * * * * * * * * * * * * * * * * * * * *
    
    //You set up a ratings view that allows the user to rate the exercise difficulty from one to five. You’ll save this rating to UserDefaults so that your ratings don’t disappear when you close the app. We will use @AppStorage for that and remove the @State variable
    /*
     when we did the above, passing $rating to the ratings view init in this folder still worked, which leads us to surmise that @AppStorage exposes a binding somehow
     */
    //deleted state variable
    // @State private var rating = 0
    
    @State private var showHistory = false
    /*
     ExerciseView needs its own showHistory source of truth because, with the way we coded our app, we did not call ExerciseView in WelcomeView so there is no way to pass WelcomeView's showHistory source of truth into ExerciseView. It still satisfies SwiftUI's requirement of having a single source of truth for a piece of UI because this view's historyButton only looks to this var for its source of truth and it is separate from WelcomeView's source of truth for its historyButton
    */
    @State private var showSuccess = false
    @State private var showSheet = false //new variable for a sheet, used to help determine which modal sheet to show
    
    @State private var showTimer = false
    @State private var timerDone = false
    
    @EnvironmentObject var history: HistoryStore
    /*
     we need to grab history from the Environment so that we can add a finished exercise to our datastore when a user is done with TimerView modal sheet view
    */
    @State private var exerciseSheet: ExerciseSheet? 
    
    enum ExerciseSheet { //new enum. Used to determine which modal sheet to show
      case history, timer, success
    }
    
    let index: Int //passed in from content view
    //index is local to exercise view, so it cannot be used in HeaderView extracted subview that was subsequently ported to headerView.swift
    
    // deleted code //let interval: TimeInterval = 30
    
    var lastExercise: Bool { //used to determine if it is the last exercise or not
        index + 1 == Exercise.exercises.count
    }
    
    var body: some View {
        GeometryReader { geometry in
                VStack {
                    HeaderView(selectedTab:$selectedTab,
                               titleText:Exercise.exercises[index].exerciseName
                    )
                        .padding(.bottom)
                    Spacer()
                    ContainerView {
                        VStack {
                            video(size: geometry.size) //refactored so we called our videoPlayer(AVKit) in a func
                            startExerciseButton
                                .padding(20)
                            RatingsView(exerciseIndex: index) //we pass index into ratingsView
                                .padding()
                            Spacer()
                            historyButton
                            /* deleted in the refactor
                             if let url =
                                Bundle.main.url(forResource: Exercise.exercises[index].videoName, withExtension: "mp4") {
                                VideoPlayer(player: AVPlayer(url: url))
                                    .frame(height: geometry.size.height * 0.45)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            } else {
                                Text("Couldn't find \(videoNames[index])")
                                    .foregroundColor(.red)
                            }*/
                            
                            
                            /* deleted in refactor
                             HStack(spacing: 150){
                                startExerciseButton
                                /*Button(NSLocalizedString ("Start", comment: "begin exercise")) {
                                    showTimer.toggle()
                                }*/
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
                            
                            
                            /* Button(NSLocalizedString("History", comment: "view user activity")){
                                showHistory.toggle()
                            } */
                            historyButton
                            .sheet(isPresented: $showHistory){
                                HistoryView(showHistory: $showHistory)
                            }
                                .padding(.bottom)
                        } */
                        }
                    }
                    .frame(height: geometry.size.height * 0.8)
                    /*
                    //new modal sheet
                    /*
                     SwiftUI’s sheets are used to present new views over existing ones, while still allowing users to drag down to dismiss the new view when they are ready.
                     
                     To use a sheet, give it something to show (some text, an image, a custom view, etc), add a Boolean that defines whether the detail view should be showing, then attach it to your main view as a modal sheet.
                     */
                    //perhaps this sheet is used on historyButton as it is the last view in the TupleView returned from ContainerView // alright now idk
                    //new hypothesis: By putting the .sheet method on the encapsulating ContainerView, the modal sheet is called by any button that changes its isPresented parameter
                    */
                    .sheet(isPresented: $showSheet, onDismiss: { //do something on dismiss
                        showSuccess = false
                        showHistory = false
                        if exerciseSheet == .timer {
                            if timerDone { //needed because someone may dismiss the sheet before completing an exercise, and in that case the exercise willed not be saved to history
                                history.addDoneExercise(Exercise.exercises[index].exerciseName)
                                timerDone = false //needs to be made false so as to start the timer from zero on the next exercise i.e the next time the sheet is called
                            }
                            showTimer = false //dismissing TimerView
                            if lastExercise {
                                showSuccess = true
                                showSheet = true
                                exerciseSheet = .success //success view is only brought up by completing the very last exercise
                            } else {
                                selectedTab += 1
                            }
                        } else {
                            exerciseSheet = nil
                        }
                        showTimer = false //TimerView needs to be dismissed regardless of the condition of exerciseSheet hence the dual appearance
                    }, content: {
                        if let exerciseSheet = exerciseSheet {
                            switch exerciseSheet {
                            case .history:
                                HistoryView(showHistory: $showHistory)
                                    .environmentObject(history) //hypothesis: we need to pass history to the environment for it to be used in HistoryView becase HistoryView may not be an exact subview of ExerciseView, maybe since it's in a select case block. In either case it is the same history object passed in from HIITFit to ContentView to ExerciseView (ExerciseView grabs it as well)
                                //updated hypothesis: we need to pass history to the environment so that it can be used by view that are subviews of HistoryView but not necessarily in the same hierarchy as HIITFit - ContentView - ExerciseView
                            case .timer:
                                TimerView(timerDone: $timerDone,
                                          exerciseName: Exercise.exercises[index].exerciseName)
                            case .success:
                                SuccessView(selectedTab: $selectedTab) //selectedTab passed into SuccessView so that SuccessView can change it to 9, thus returning us to WelcomeView. 9 is the selectedTab value associated with WelcomeView courtesy of the .tag() modifier
                            }
                        }
                    })
                }//outer VStack
            
        } //geometryReader
    } //body
    
    

    @ViewBuilder
    func video(size: CGSize) -> some View {
      if let url = Bundle.main.url(
        forResource: Exercise.exercises[index].videoName,
          withExtension: "mp4") {
        VideoPlayer(player: AVPlayer(url: url))
          .frame(height: size.height * 0.25)
          .clipShape(RoundedRectangle(cornerRadius: 12))
          .padding(20)
      } else {
        Text(
          "Couldn't find \(Exercise.exercises[index].videoName).mp4")
          .foregroundColor(.red)
      }
    }

    
    var startExerciseButton: some View {
        RaisedButton(buttonText: NSLocalizedString("Start Exercise", comment: "begin")){
            showTimer.toggle()
            showSheet = true
            exerciseSheet = .timer
        }
    }
    
    var historyButton: some View {
        Button(action: {
            showSheet = true
            showHistory = true
            exerciseSheet = .history
        }, label: {
            Text(NSLocalizedString("History", comment: "view user activity"))
                .fontWeight(.bold)
                .padding([.leading, .trailing], 5)
        })
            .padding(.bottom, 10)
            .buttonStyle(EmbossedButtonStyle())
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(selectedTab: .constant(0), index: 0)
            .environmentObject(HistoryStore())
        //you have to explicitly pass an environmentObject to the previews for it to work
    }
}

