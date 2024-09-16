//
//  StructModels.swift
//  Dog_Event_ScoreBoard
//
//  Created by abdifatah ahmed on 9/15/24.
//
import Foundation
import SwiftUI

class EventModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var currentEvent: Event = Event()
    @Published var currentDogEvaluations: [DogEvaluation] = []
    @Published var currentDog: DogEvaluation = DogEvaluation()

    func moveEvent(from source: IndexSet, to destination: Int) {
        events.move(fromOffsets: source, toOffset: destination)
    }

    func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
    }
    
    func moveDog(from source: IndexSet, to destination: Int) {
        currentEvent.dogEvaluations.move(fromOffsets: source, toOffset: destination)
        
        currentDogEvaluations = currentEvent.dogEvaluations
        
        saveEvent()
    }
    
    func deleteDog(at offsets: IndexSet) {
        currentEvent.dogEvaluations.remove(atOffsets: offsets)
        
        currentDogEvaluations = currentEvent.dogEvaluations
        currentDog = DogEvaluation()  // Reset after deleting to a blank state
        saveEvent()
    }

    func saveEvent() {
        if let index = events.firstIndex(where: { $0.id == currentEvent.id }) {
            events[index] = currentEvent
        } else {
            events.append(currentEvent)
        }
    }
    
    func saveDog() {
        print("save dog called")
        
        // Check if the dog already exists in the current event's dogEvaluations
        if let dogIndex = currentEvent.dogEvaluations.firstIndex(where: { $0.id == currentDog.id }) {
            // Update existing dog evaluation
            currentEvent.dogEvaluations[dogIndex] = currentDog
        } else {
            print("current current event  \(currentEvent.eventName)")
            print("current dogeval \(currentEvent.dogEvaluations.count)")
            print("current dog \(currentDog.dogName)")

            // Add new dog evaluation
            currentEvent.dogEvaluations.append(currentDog)
            print("current dogeval after \(currentEvent.dogEvaluations.count)")
        }
        
        // Keep `currentDogEvaluations` synchronized with `currentEvent`
        currentDogEvaluations = currentEvent.dogEvaluations
        
        // Save the current event to the events list
        saveEvent()
        
        // Reset the current dog after saving
        currentDog = DogEvaluation()

    }

    
    func deleteCurrentEvaluation() {
        print ("dog name to delete \(currentDog.dogName)")
        print ("event evaluations\(currentEvent.dogEvaluations.count)")
        currentEvent.dogEvaluations.removeAll { $0.id == currentDog.id }  // Delete current evaluation
        
        print ("after dog name to delete \(currentDog.dogName)")
        print ("after event evaluations\(currentEvent.dogEvaluations.count)")
        
        currentDogEvaluations = currentEvent.dogEvaluations
        currentDog = DogEvaluation()  // Reset after deleting to a blank state
        
        saveEvent()
        
        
    }

}

