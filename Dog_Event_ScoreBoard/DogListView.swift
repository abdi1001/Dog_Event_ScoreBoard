//
//  DogListView.swift
//  Dog_Event_ScoreBoard
//
//  Created by abdifatah ahmed on 9/15/24.
//

import SwiftUI

struct DogListView: View {
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    @EnvironmentObject var eventData: EventModel



    
    var body: some View {
            List {
                ForEach(eventData.currentEvent.dogEvaluations) { dogEval in
                    NavigationLink(value: SelectionState.editDog(dogEval)) {
                        HStack {
                            VStack {
                                Text(dogEval.dogName)
                                Text("Dog #: \(dogEval.dogNumber)").font(.subheadline).foregroundColor(.gray)
                            }
                            Spacer()
                        }
                    }
                    .contentShape(Rectangle())
                }
                .onMove(perform: eventData.moveDog)
                .onDelete(perform: eventData.deleteDog)
            }
            .navigationTitle("Dogs in \(eventData.currentEvent.eventName)")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        let newDog = DogEvaluation()
                        eventData.currentDog = newDog
                        navigationStateManager.createDog(dog: newDog)
                    }, label: {
                        Label("Add Dog", systemImage: "plus")
                    })
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        navigationStateManager.popToRoot()
                    }, label: {
                        Label("Add Dog", systemImage: "arrowshape.backward.fill")
                    })
                }
            }
            .navigationBarBackButtonHidden(true)  // Hide default back button
        }
       
}


#Preview {
    NavigationStack{
        DogListView()
            .environmentObject(EventModel())  // Pass mock EventModel
            .environmentObject(NavigationStateManager())  // Pass NavigationStateManager if needed
    }

}
