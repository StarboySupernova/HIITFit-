//
//  HistoryView.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/18/21.
//

import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject var history: HistoryStore
    @Environment(\.presentationMode) var presentationMode
    @Binding var showHistory: Bool
    //You don’t want to create another HistoryStore object here. Instead, HistoryView can access history directly without needing it passed as a parameter.
    //deleted code let history = HistoryStore()
    @State var layoutType = LayoutType.list //this is our custom type


    enum LayoutType {
      case list, bar
    }
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
        /* encapsulated within closeButton view
        ZStack (alignment: .topTrailing) {
            //Other views in the ZStack have their own alignment values, so the ZStack alignment value doesn’t affect them
            //This alignment only applies to the button
            Button(action: {showHistory.toggle()}) {
                Image(systemName: "xmark.circle")
            }
            .font(.title)
            .padding(.trailing)
            */
        GeometryReader { geometry in
            ZStack {
                closeButton
                VStack {
                    VStack {
                        Text(NSLocalizedString("History", comment: "view user activity"))
                            .font(.title)
                            .padding()
                        layout
                        /*
                         no need for the form now,we're using different layouts based on user choice
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
                         */
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
                    .frame(height: geometry.size.height * 0.15)
                    Spacer()
                    if layoutType == .list {
                        HistoryListView()
                    } else {
                        HistoryBarView()
                    }
                }
            } //ZStack
        } //geometry reader
    }
    
    var layout: some View {
        HStack {
            if layoutType == .list {
                Button(action: {layoutType = .bar}, label: {Image(systemName: "square.grid.2x2.fill")
                        .padding([.leading, .trailing], 20)
                })
                    .buttonStyle(EmbossedButtonStyle())
                Button(action: {layoutType = .bar}, label: {Image(systemName: "chart.bar.fill")
                        .padding([.leading, .trailing], 20)
                        .foregroundColor(.gray)
                })
            } else {
                Button(action: {layoutType = .list}, label: {Image(systemName: "square.grid.2x2.fill")
                        .padding([.leading, .trailing], 20)
                        .foregroundColor(.gray)
                })
                Button(action: {layoutType = .list}, label: {Image(systemName: "chart.bar.fill")
                        .padding([.leading, .trailing], 20)
                })
                    .buttonStyle(EmbossedButtonStyle())
            }
        }
    }
    
    var closeButton: some View {
      ZStack(alignment: .topTrailing) {
        Color("background")
          .edgesIgnoringSafeArea(.all)
        Button(action: {
          presentationMode.wrappedValue.dismiss()
            //investigate this more
          // swiftlint:disable:next multiple_closures_with_trailing_closure
        }) {
          Image(systemName: "xmark")
            .foregroundColor(.primary)
        }
        .font(.title2)
        .padding([.top, .trailing], 25)
      }
    }
    
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(showHistory: .constant(true))
            .environmentObject(HistoryStore())
        //You must tell previews about this EnvironmentObject or it will crash with no useful information on what went wrong.
    }
}
