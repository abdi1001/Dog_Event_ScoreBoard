//
//  Modules.swift
//  Dog_Event_ScoreBoard
//
//  Created by abdifatah ahmed on 9/15/24.
//

import Foundation


struct DogEvaluation: Identifiable, Hashable, Codable {
    var id = UUID()  // Unique identifier for each DogEvaluation
    var dogName: String = ""
    var dogNumber: String = ""
    var testLevel: Int = 1  // Default to JR
    var markingSeries: [Double?] = Array(repeating: nil, count: 4)
    var markingStyle: [Double?] = Array(repeating: nil, count: 4)
    var markingPerseverance: [Double?] = Array(repeating: nil, count: 4)
    var markingTrainability: [Double?] = Array(repeating: nil, count: 4)
    var blindStyle: [Double?] = Array(repeating: nil, count: 4)
    var blindPerseverance: [Double?] = Array(repeating: nil, count: 4)
    var blindTrainability: [Double?] = Array(repeating: nil, count: 4)
    
    init(dogName: String, dogNumber: String, testLevel: Int, markingSeries: [Double?], markingStyle: [Double?], markingPerseverance: [Double?], markingTrainability: [Double?], blindStyle: [Double?], blindPerseverance: [Double?], blindTrainability: [Double?]) {
        self.id = UUID()
        self.dogName = dogName
        self.dogNumber = dogNumber
        self.testLevel = testLevel
        self.markingSeries = markingSeries
        self.markingStyle = markingStyle
        self.markingPerseverance = markingPerseverance
        self.markingTrainability = markingTrainability
        self.blindStyle = blindStyle
        self.blindPerseverance = blindPerseverance
        self.blindTrainability = blindTrainability
    }
    
    init() {
        self.id = UUID()
        self.dogName = ""
        self.dogNumber = ""
        self.testLevel = 1
        self.markingSeries = Array(repeating: nil, count: 4)
        self.markingStyle = Array(repeating: nil, count: 4)
        self.markingPerseverance = Array(repeating: nil, count: 4)
        self.markingTrainability = Array(repeating: nil, count: 4)
        self.blindStyle = Array(repeating: nil, count: 4)
        self.blindPerseverance = Array(repeating: nil, count: 4)
        self.blindTrainability = Array(repeating: nil, count: 4)
    }
}



struct Event: Identifiable, Hashable, Codable {
    var id = UUID()  // Unique identifier for each DogEvaluation
    var eventName: String = ""
    var dogEvaluations: [DogEvaluation]
    
    init() {
        self.id = UUID()
        self.eventName = ""
        self.dogEvaluations = []
    }
    
    init(eventName: String, dogEvaluations: [DogEvaluation]) {
        self.id = UUID()
        self.eventName = eventName
        self.dogEvaluations = dogEvaluations
    }
    
}



