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
        
        do {
            try save()
        } catch {
            fatalError(error.localizedDescription)
            //If there’s an error in saving, you crash the app, printing out the string description of your error. This isn’t a great way to ship your app, and you may want to change it later
        }
        
        //was for debug purposes and learning to use breakpoints
        //print("History", exerciseDays)
    }
    
    func load () throws {
        // First set up the URL just as you did with saving the file
        guard let dataURL = getUrl() else {
            throw FileError.urlFailure
        }
        
        do {
            //Read the data file into a byte buffer. This buffer is in the property list format. If history.plist doesn’t exist on disk, Data(contentsOf:) will throw an error. Throwing an error is not correct in this case, as there will be no history when your user first launches your app. You’ll fix this error as your challenge for this chapter.
            //let data = try Data(contentsOf: dataURL)
            // we made it check if history.plist exists first, if it doesn't it'll take no action
            guard let data = try? Data(contentsOf: dataURL) else {return}
            //Convert the property list format into a format that your app can read
            let plistData = try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
            //When you serialize from a property list, the result is always of type Any. To cast to another type, you use the type cast operator as?. This will return nil if the type cast fails. Because you wrote history.plist yourself, you can be pretty sure about the contents, and you can cast plistData from type Any to the [[Any]] type that you serialized out to file. If for some reason history.plist isn’t of type [[Any]], you provide a fall-back of an empty array using the nil coalescing operator ??.
            let convertedPlistData = plistData as? [[Any]] ?? []
            //With convertedPlistData cast to the expected type of [[Any]], you use map(_:) to convert each element of [Any] back to ExerciseDay. You also ensure that the data is of the expected type and provide fall-backs if necessary
            let exerciseDays = convertedPlistData.map {
                ExerciseDay(date: $0[1] as? Date ?? Date(), exercises: $0[2] as? [String] ?? [])
            }
        } catch {
            throw FileError.loadFailure
        }
    }
    
    func getUrl () -> URL? {
        guard let documentsURL = FileManager.default.urls( for: .documentDirectory, in: .userDomainMask).first else {
        return nil }
        return documentsURL.appendingPathComponent("history.plist") //You add the file name to the documents path. This gives you the full URL of the file to which you’ll write the history data
    }
    func save () throws {
        guard let dataUrl = getUrl() else {throw FileError.saveFailure}
        
        let plistData = exerciseDays.map{
            [$0.id.uuidString, $0.date, $0.exercises]
        }
        
        do {
            //You convert your history data to a serialized property list format. The result is a Data type, which is a buffer of bytes
            let data = try PropertyListSerialization.data(fromPropertyList: plistData, format: .binary, options: .zero)
            //You write to disk using the URL you formatted earlier.
            try data.write(to: dataUrl, options: .atomic) //seems like you can try multiple funcs in a single do scope and if any or both throw an error you can coalesce it into 1 compound error
        } catch {
            //The conversion and writing may throw an error, which you catch by throwing an error
            throw FileError.saveFailure
        }
        
        //longer version on using the map(_:) that accepts a closure as an argument and applies that closure to each element of the array and returns a new array with the transformations applied
        /* let plistData: [[Any]] = exerciseDays.map{ exerciseDay in
            [exerciseDay.id.uuidString, exerciseDay.date, exerciseDay.exercises]
        } */
        
        
        //we will use map for this. It performs basically the same functionality in this context
        /* var plistData: [[Any]] = []
        for exerciseDay in exerciseDays {
            plistData.append([exerciseDay.id.uuidString, exerciseDay.date, exerciseDay.exercises])
        } */
    }
    
}


