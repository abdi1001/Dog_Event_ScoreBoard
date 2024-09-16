import SwiftUI
import Foundation

class NavigationStateManager: ObservableObject {
    @Published var selectedPath = [SelectionState]()
    
    // Navigate to the root of the navigation stack
    func popToRoot() {
        selectedPath = []
    }
    
    // Navigate to create a new event
    func createEvent(event: Event) {
        selectedPath.append(SelectionState.createEvent(event))
    }
    
    // Navigate to create a new dog evaluation
    func createDog(dog: DogEvaluation) {
        selectedPath.append(SelectionState.createDog(dog))
    }
    
    // New function: Navigate to the current event's dog evaluations (DogListView)
    func goToCurrentEventDogs(event: Event) {
        selectedPath.append(SelectionState.dogEvaluations(event.dogEvaluations))
    }
    
    // Navigate back to the previous screen
    func popToPrevious() {
        if !selectedPath.isEmpty {
            selectedPath.removeLast()
        }
    }
}

enum SelectionState: Hashable {
    case editEvent(Event)  // Edit an event
    case createEvent(Event)  // Create a new event
    case editDog(DogEvaluation)  // Edit a dog evaluation
    case createDog(DogEvaluation)  // Create a new dog evaluation
    case dogEvaluations([DogEvaluation])  // Navigate to the list of dog evaluations for an event
}
