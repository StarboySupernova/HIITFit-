//
//  TimerView.swift
//  HIITFit
//
//  Created by user207077 on 11/2/21.
//

import SwiftUI

struct TimerView: View {
    /* GeometryReader { geometry in
     ZStack {
       Color("background")
         .edgesIgnoringSafeArea(.all)
       circle(size: geometry.size)
         .overlay(
           GradientBackground()
             .mask(circle(size: geometry.size))
         )
       VStack {
         Text(exerciseName)
           .font(.largeTitle)
           .fontWeight(.black)
           .foregroundColor(.white)
           .padding(.top, 20)
         Spacer()
         IndentView {
           timerText
         }
         Spacer()
         RaisedButton(buttonText: "Done") {
           presentationMode.wrappedValue.dismiss()
         }
         .opacity(timerDone ? 1 : 0)
         .padding([.leading, .trailing], 30)
         .padding(.bottom, 60)
         .disabled(!timerDone)
       }
       .onAppear {
         timerDone = false
       }
     }
   }*/
    
    @Environment(\.presentationMode) var presentationMode
    @State private var timeRemaining = 3 //30
    @Binding var timerDone: Bool
    let exerciseName: String
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    /*
     extension Timer {
     
     /// Returns a publisher that repeatedly emits the current date on the given interval.
     ///
     /// - Parameters:
     ///   - interval: The time interval on which to publish events. For example, a value of `0.5` publishes an event approximately every half-second.
     ///   - tolerance: The allowed timing variance when emitting events. Defaults to `nil`, which allows any variance.
     ///   - runLoop: The run loop on which the timer runs.
     ///   - mode: The run loop mode in which to run the timer.
     ///   - options: Scheduler options passed to the timer. Defaults to `nil`.
     /// - Returns: A publisher that repeatedly emits the current date on the given interval.
     public static func publish(every interval: TimeInterval, tolerance: TimeInterval? = nil, on runLoop: RunLoop, in mode: RunLoop.Mode, options: RunLoop.SchedulerOptions? = nil) -> Timer.TimerPublisher
     */
    
    
    var body: some View {
        /* deleted in refactor
         Text("\(timeRemaining)")
            .font(.system(size: 90, design: .rounded))
            .padding()
            .onReceive(timer) { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    timerDone = true
                }
                /*Note: onReceive(_:perform:) returns a published event, but your action doesn’t use it, so you acknowledge its existence with _ */
            } */
        GeometryReader { geometry in
            ZStack{
                Color("background")
                    .edgesIgnoringSafeArea(.all)
                circle(size: geometry.size)
                    .overlay(//A view that layers the specified content in front of the view. Content is the closure parameter that returns the View to overlay with (a view builder that produces views to layer in front of this view). Multiple views provided by content are organized in to a ZStack
                        GradientBackground()
                            .mask(circle(size: geometry.size)) //Use mask(_:) when you want to apply the alpha (opacity) value of another view to the current view
                    )
                VStack {
                    Text(exerciseName)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    Spacer()
                    IndentView{
                        timerText
                    }
                    Spacer()
                    RaisedButton(buttonText: NSLocalizedString("Done", comment: "exercise finished"), action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                        .opacity(timerDone ? 1 : 0)
                        .padding([.leading, .trailing], 30)
                        .padding(.bottom, 60)
                        .disabled(!timerDone)
                }
                .onAppear{
                    timerDone = false
                }
            }
        }
    }
    
    var timerText: some View {
      Text("\(timeRemaining)")
        .font(.system(size: 90, design: .rounded))
        .fontWeight(.heavy)
        .frame(
          minWidth: 180,
          maxWidth: 200,
          minHeight: 180,
          maxHeight: 200)
        .padding()
        .onReceive(timer) { _ in
          if self.timeRemaining > 0 {
            self.timeRemaining -= 1
          } else {
            timerDone = true
          }
        }
    }
    
    func circle(size: CGSize) -> some View {
      Circle()
        .frame(
          width: size.width,
          height: size.height)
        .position(
          x: size.width * 0.5,
          y: -size.width * 0.2)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timerDone: .constant(true), exerciseName: "Step-up")
            .previewLayout(.sizeThatFits)
    }
}
