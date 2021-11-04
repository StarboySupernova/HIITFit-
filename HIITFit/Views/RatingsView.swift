//
//  RatingsView.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/14/21.
//

import SwiftUI

struct RatingsView: View {
    
    //deleted code
    // explanation in ExerciseView
    // @Binding var rating: Int
    let exerciseIndex: Int
    @AppStorage("ratings") private var ratings = "0000"
    @State private var rating = 0
    //RatingsView is a better source of truth than ExerciseView so it is better for rating view to own the ratings instead of being passed a binding to them
    //Here you hold rating locally and set up ratings to be a string of four zeros
    let maximumRating = 5
    
    let onColor = Color.orange
    let offColor = Color.blue
    
    func updateRating(index: Int){
        rating = index
        // I think we need rating to be a State variable because that way the view depends  on its State. When rating changes in this func, the whole view is redrawn with the correct and updated rating
        let StringIndex = ratings.index(ratings.startIndex, offsetBy: exerciseIndex)
        ratings.replaceSubrange(StringIndex...StringIndex, with: String(rating))
        //using index for both the parameter and name of index in string was ambiguous so instead I used StringIndex
    }
    
    var body: some View {
        HStack {
            ForEach(1 ..< maximumRating + 1) { index in
                Image(systemName: "waveform.path.ecg")
                    .onAppear{
                        let index = ratings.index(ratings.startIndex, offsetBy: exerciseIndex)
                        let character = ratings[index]
                        rating = character.wholeNumberValue ?? 0
                    }
                    .foregroundColor(index > rating ? offColor : onColor)
                    .onTapGesture {
                        updateRating(index: index)
                    }
            }
        }
        .font(.largeTitle)
    }
}

//Preview holds its own version of @AppStorage, which can be hard to clear
struct RatingsView_Previews: PreviewProvider {
    @AppStorage("ratings") static var ratings: String?
    static var previews: some View {
        ratings = nil
        return RatingsView(exerciseIndex: 0)
            .previewLayout(.fixed(width: 300, height: 100))
        // To remove a key from the Preview UserDefaults, you need to set it to a nil value. Only optional types can hold nil, so you define ratings as String?. You can then set the @AppStorage ratings to have a nil value, ensuring that your Preview doesn’t load previous values
        
    }
}
