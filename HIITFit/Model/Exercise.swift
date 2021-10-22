//
//  Exercise.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/22/21.
//

import Foundation

struct Exercise {
    let exerciseName: String
    let videoName: String
    
    enum ExerciseEnum: String {
        case squat = "Squat"
        case stepUp = "Step Up"
        case burpee = "Burpee"
        case sunSalute = "Sun Salute"
    }
    
}

extension Exercise {
    static let exercises = [
        Exercise(exerciseName: ExerciseEnum.squat.rawValue, videoName: "squat"),
        Exercise(exerciseName: ExerciseEnum.stepUp.rawValue, videoName: "step-up"),
        Exercise(exerciseName: ExerciseEnum.burpee.rawValue, videoName: "burpee"),
        Exercise(exerciseName: ExerciseEnum.sunSalute.rawValue, videoName: "sun-salute")
    ]
}
