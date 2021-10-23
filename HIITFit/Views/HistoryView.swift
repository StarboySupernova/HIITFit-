//
//  HistoryView.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/18/21.
//

import SwiftUI

struct HistoryView: View {
    
    let history = HistoryStore()
    /*
     In HistoryView.swift, delete the Date properties and the exercise arrays, then add this property: let history = HistoryStore()
     HistoryStore now encapsulates all the information in the stored properties today, yesterday and the exercises arrays.
     */
    
    //Deleted code
//    let today = Date()
//    let yesterday = Date().addingTimeInterval(-86400)
//
//    let exercises1 = ["Squat", "Step-up", "Burpee", "Sun-salute"]
//    let exercises2 = ["Squat", "Step-up", "Burpee"]
    
    var body: some View {
        ZStack (alignment: .topTrailing) {
            //Other views in the ZStack have their own alignment values, so the ZStack alignment value doesn’t affect them
            //This alignment only applies to the button
            Button(action: {}) {
                Image(systemName: "xmark.circle")
            }
            .font(.title)
            .padding(.trailing)
            
            VStack {
                Text(NSLocalizedString("History", comment: "view user activity"))
                    .font(.title)
                    .padding()
                
                Form {
                    /* initializer used here
                     init(Data, content: (Data.Element) -> Content)
                     Creates an instance that uniquely identifies and creates views across updates based on the identity of the underlying data.
                     Available when Data conforms to RandomAccessCollection (exerciseDays array), ID is Data.Element.ID, Content conforms to View, and Data.Element conforms to Identifiable (ExerciseDay struct conforms to ID here and is the element to the exerciseDays array)
                     
                     */
                    ForEach(history.exerciseDays) { day in
                        Section(header:Text(day.date.formatted(as: "MMMM d"))
                                    .font(.headline)) {
                            ForEach(day.exercises, id: \.self){ exercise in
                                Text(exercise)
                            }
                        }
                    }
                }
                
                
                
                //Deleted code
//                Form {
//                Section(
//                    header: Text(today.formatted(as: "MMM d"))
//                            .font(.headline)) {
//                                ForEach(exercises1, id: \.self){ exercise in
//                                    Text(exercise)
//                                }
//                }
//                Section(
//                    header: Text(yesterday.formatted(as: "MMM d"))
//                            .font(.headline)) {
//                                ForEach(exercises2, id: \.self){ exercise in
//                                    Text(exercise)
//                                }
//                            }
//                }
                
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
