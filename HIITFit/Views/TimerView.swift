//
//  TimerView.swift
//  HIITFit
//
//  Created by user207077 on 11/2/21.
//

import SwiftUI

struct TimerView: View {
    
    @State private var timeRemaining = 3
    @Binding var timerDone: Bool
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
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
            }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timerDone: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
