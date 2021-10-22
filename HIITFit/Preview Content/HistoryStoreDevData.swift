//
//  HistoryStoreDevData.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/22/21.
//

import Foundation

extension HistoryStore {
    mutating func createDevData () {
        //Development data
        exerciseDays = [
            //ExerciseDay(date: Date().addingTimeInterval(-86400), exercise: [Exercise.exercises[0].exerciseName])
            ExerciseDay(date: Date().addingTimeInterval(-86400), exercises :
                            [Exercise.exercises[0].exerciseName, Exercise.exercises[1].exerciseName, Exercise.exercises[2].exerciseName]),
            ExerciseDay(date: Date().addingTimeInterval(-86400 * 2), exercises:
                            [Exercise.exercises[1].exerciseName, Exercise.exercises[0].exerciseName])
        ]
    }
}
