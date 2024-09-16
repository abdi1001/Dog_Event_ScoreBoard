//
//  EventFormView.swift
//  Dog_Event_ScoreBoard
//
//  Created by abdifatah ahmed on 9/15/24.
//

import SwiftUI

struct EventFormView: View {
    
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    @EnvironmentObject var eventData: EventModel
    //var onSave: () -> Void  // Closure to handle saving the event

    var body: some View {
        VStack {
            Text("Create New Event")
                .font(.headline)
                .padding()

            TextField("Event Name", text: $eventData.currentEvent.eventName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                eventData.saveEvent()
                navigationStateManager.popToRoot()
            }) {
                Text("Save Event")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    EventFormView()
        .environmentObject(EventModel())
        .environmentObject(NavigationStateManager())
}
