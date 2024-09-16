import Foundation
import SwiftUI

class EventModel: ObservableObject {
    @Published var events: [Event] = [] {
        didSet {
            saveToFile()
        }
    }
    @Published var currentEvent: Event = Event()
    @Published var currentDogEvaluations: [DogEvaluation] = []
    @Published var currentDog: DogEvaluation = DogEvaluation()
    
    let fileName = "eventsData.json"
    
    init() {
        loadFromFile()
    }

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
        if let dogIndex = currentEvent.dogEvaluations.firstIndex(where: { $0.id == currentDog.id }) {
            currentEvent.dogEvaluations[dogIndex] = currentDog
        } else {
            currentEvent.dogEvaluations.append(currentDog)
        }
        currentDogEvaluations = currentEvent.dogEvaluations
        saveEvent()
        currentDog = DogEvaluation()  // Reset the current dog after saving
    }
    
    func deleteCurrentEvaluation() {
        currentEvent.dogEvaluations.removeAll { $0.id == currentDog.id }
        currentDogEvaluations = currentEvent.dogEvaluations
        currentDog = DogEvaluation()  // Reset after deleting to a blank state
        saveEvent()
    }

    // MARK: - File Handling

    // Save the events array to a JSON file in the documents directory
    func saveToFile() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(events)
            if let fileURL = getDocumentsDirectory()?.appendingPathComponent(fileName) {
                try data.write(to: fileURL)
                print("Data saved to file")
            }
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }

    // Load the events array from a JSON file in the documents directory
    func loadFromFile() {
        do {
            if let fileURL = getDocumentsDirectory()?.appendingPathComponent(fileName) {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                events = try decoder.decode([Event].self, from: data)
                print("Data loaded from file")
            }
        } catch {
            print("Failed to load data: \(error.localizedDescription)")
        }
    }

    // Helper function to get the documents directory URL
    func getDocumentsDirectory() -> URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}
