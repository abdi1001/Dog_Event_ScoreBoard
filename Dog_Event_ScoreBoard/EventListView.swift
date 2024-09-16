import SwiftUI

struct EventListView: View {

    @EnvironmentObject var navigationStateManager: NavigationStateManager
    @EnvironmentObject var eventData: EventModel
    
    var body: some View {
        NavigationStack(path: $navigationStateManager.selectedPath) {
            List {
                ForEach(eventData.events) { event in
                    NavigationLink(value: SelectionState.editEvent(event)) {
                        HStack {
                            VStack {
                                Text(event.eventName)
                            }
                            Spacer()
                            Button(action: {
                                navigationStateManager.createEvent(event: event)

                            }) {
                                Text("Edit Name")
                                    .font(.system(size: 14, weight: .bold))  // Custom font size and weight
                                    .foregroundColor(.white)  // Text color
                                    .padding(.vertical, 8)  // Vertical padding
                                    .padding(.horizontal, 16)  // Horizontal padding
                                    .background(Color.blue)  // Button background color
                                    .cornerRadius(8)  // Rounded corners
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    //.contentShape(Rectangle())
                }
                .onMove(perform: eventData.moveEvent)
                .onDelete(perform: eventData.deleteEvent)
            }
            .navigationTitle("All Event")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()  // Wrap EditButton in closure
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        let newEvent = Event()
                        eventData.currentEvent = newEvent
                        navigationStateManager.createEvent(event: newEvent)
                    }) {
                        Label("Add Event", systemImage: "plus")
                    }
                }
            }
            .navigationDestination(for: SelectionState.self) { state in
                switch state {
                case .createEvent(let newEvent):
                    EventFormView().onAppear {
                        eventData.currentEvent = newEvent
                    }
//                case .allDogs(let allDogs):
//                    DogListView().onAppear {
//                        eventData.currentDogEvaluations = eventData.currentEvent.dogEvaluations
//                        eventData.currentEvent.dogEvaluations = allDogs
//                    }
                case .editEvent(let showEvent):
                    DogListView().onAppear {
                        eventData.currentDogEvaluations = showEvent.dogEvaluations
                        eventData.currentEvent = showEvent
                    }
                case .createDog(let newDog):
                    EvaluationForm().onAppear {
                        eventData.currentDog = newDog
                    }
                case .editDog(let EditDog):
                    EvaluationForm().onAppear {
                        eventData.currentDog = EditDog
                    }
                case .dogEvaluations(let dogEvaluations):
                    DogListView().onAppear {
                        eventData.currentEvent.dogEvaluations = dogEvaluations
                    }
                }
                
            }
        }
    }
}

#Preview {
    return NavigationStack {
        EventListView()
    }  .environmentObject(EventModel())  // Pass mock EventModel
        .environmentObject(NavigationStateManager())
}
