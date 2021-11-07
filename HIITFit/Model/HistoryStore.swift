//
//  HistoryStore.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/22/21.
//

import Foundation

struct  ExerciseDay : Identifiable {
    let id = UUID()
    let date: Date
    var exercises :[String]
}

class HistoryStore: ObservableObject {
    @Published var exerciseDays : [ExerciseDay] = []
    
    enum FileError: Error {
        case loadFailure
        case urlFailure
        case saveFailure
    }
    
    init(withChecking: Bool) throws {
        #if DEBUG
        //Currently, on initializing HistoryStore, you create a fake exerciseDays array (createDevData()). This was useful for testing, but now that you’re going to save real history, you no longer need to load the data
        //createDevData()
        #endif
        //was for debug purposes and learning to uses breakpoints
        //print("Initializing HistoryStore")
        
        do {
            try load()
        } catch {
            throw error
            //This will pass back the error to the object that initializes HistoryStore
        }
    }
    
    init(){}
    
    func addDoneExercise(_ exerciseName: String){
        //this code does not cope with the possibility of the array being nil, so we need to alter it to prevent runtime errors
        let today = Date()
        //if today.isSameDay(as: exerciseDays[0].date){
        if let firstDate = exerciseDays.first?.date,today.isSameDay(as: exerciseDays[0].date) {
            print("Adding \(exerciseName)")
            exerciseDays[0].exercises.append(exerciseName)
        } else {
            exerciseDays.insert(ExerciseDay(date: today, exercises: [exerciseName]), at: 0)
        }
        //was for debug purposes and learning to use breakpoints
        //print("History", exerciseDays)
    }
    
    func load () throws {
        //throw FileError.loadFailure
    }
    
    func getUrl () -> URL? {
        guard let documentsURL = FileManager.default.urls( for: .documentDirectory, in: .userDomainMask).first else {
        return nil }
        return documentsURL.appendingPathComponent("history.plist") //You add the file name to the documents path. This gives you the full URL of the file to which you’ll write the history data
    }
    func save () throws {
        guard let dataUrl = getUrl() else {throw FileError.saveFailure}
        
        var plistData: [[Any]] = []
        for exerciseDay in exerciseDays {
            plistData.append(([exerciseDay.id.uuidString, exerciseDay.date, exerciseDay.exercises])) //what is the significance of double parentheses?
        }
    }
    
}


