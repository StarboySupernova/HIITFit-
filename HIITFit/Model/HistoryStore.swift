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
    let exercises :[String]
}

struct HistoryStore{
    var exerciseDays : [ExerciseDay] = []
    init(){
        #if DEBUG
        createDevData()
        #endif
    }
}


