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
    
    enum ExerciseEnum: CustomStringConvertible {
        case squat
        case stepUp
        case burpee
        case sunSalute
        
        var description: String {
            switch self {
            case .squat:
                return NSLocalizedString("Squat", comment: "exercise")
            case .stepUp :
                return NSLocalizedString("Step Up", comment: "exercise")
            case .burpee :
                return NSLocalizedString("Burpee", comment: "exercise")
            case .sunSalute :
                return NSLocalizedString("Sun Salute", comment: "exercise")
            }
        }
    }
    
}

extension Exercise {
    static let exercises = [
        Exercise(exerciseName: String (describing: ExerciseEnum.squat), videoName: "squat"),
        Exercise(exerciseName: String (describing: ExerciseEnum.stepUp), videoName: "step-up"),
        Exercise(exerciseName: String (describing: ExerciseEnum.burpee), videoName: "burpee"),
        Exercise(exerciseName: String (describing: ExerciseEnum.sunSalute), videoName: "sun-salute")
    ]
}
