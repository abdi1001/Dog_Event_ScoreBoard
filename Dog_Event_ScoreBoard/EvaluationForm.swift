//
//  EvaluationForm.swift
//  Dog_Event_ScoreBoard
//
//  Created by abdifatah ahmed on 9/15/24.
//

import SwiftUI



struct EvaluationForm: View {
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    @EnvironmentObject var eventData: EventModel
    
    //let currentEvaluation = eventData.currentDog
    
    
    var totalScore: Double {
        let allSeries = [eventData.currentDog.markingSeries, eventData.currentDog.markingStyle, eventData.currentDog.markingPerseverance, eventData.currentDog.markingTrainability,
                         eventData.currentDog.blindStyle, eventData.currentDog.blindPerseverance, eventData.currentDog.blindTrainability]
        return allSeries.flatMap { $0.compactMap { $0 } }.reduce(0, +)
    }
    
    var overallAverage: Double {
        let allSeries = [eventData.currentDog.markingSeries, eventData.currentDog.markingStyle, eventData.currentDog.markingPerseverance, eventData.currentDog.markingTrainability,
                         eventData.currentDog.blindStyle, eventData.currentDog.blindPerseverance, eventData.currentDog.blindTrainability]
        let averages = allSeries.compactMap { calculateAverage(series: $0) }
        
        guard !averages.isEmpty else { return 0.0 }
        return averages.reduce(0, +) / Double(averages.count)
    }
    
    func calculateAverage(series: [Double?]) -> Double? {
        let filteredValues = series.compactMap { $0 }
        guard !filteredValues.isEmpty else { return nil }
        return Double(filteredValues.reduce(0, +)) / Double(filteredValues.count)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Dog Test Evaluation Form")
                    .font(.title)
                    .padding(.top)
                
                // Dog Name and Dog Number Inputs
                VStack(spacing: 15) {
                    HStack {
                        Text("Dog Name:")
                            .frame(width: 100, alignment: .leading)
                        TextField("Enter Dog Name", text: $eventData.currentDog.dogName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: .infinity)
                    }
                    HStack {
                        Text("Dog #:")
                            .frame(width: 100, alignment: .leading)
                        TextField("Enter Dog #", text: $eventData.currentDog.dogNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal)
                
                // Test Level Picker
                HStack {
                    Text("Test Level (pick one):")
                        .frame(width: 150, alignment: .leading)
                    Spacer()
                    Picker("Test Level", selection: $eventData.currentDog.testLevel) {
                        Text("JR").tag(1)
                        Text("SR").tag(2)
                        Text("MR").tag(3)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)
                
                // Marking Series Section
                VStack(spacing: 5) {
                    Text("Marking Series")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    
                    HStack {
                        Spacer().frame(width: UIScreen.main.bounds.width * 0.25)
                        ForEach(0..<4) { i in
                            Text("Series \(i + 1)")
                                .frame(width: UIScreen.main.bounds.width * 0.12, alignment: .center)
                        }
                        Text("Average")
                            .frame(width: UIScreen.main.bounds.width * 0.12, alignment: .center)
                    }
                    EvaluationRow(title: "Marking (Memory)", values: $eventData.currentDog.markingSeries)
                    EvaluationRow(title: "Style", values: $eventData.currentDog.markingStyle)
                    EvaluationRow(title: "Perseverance", values: $eventData.currentDog.markingPerseverance)
                    EvaluationRow(title: "Trainability", values: $eventData.currentDog.markingTrainability)
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // Blind Series Section
                VStack(spacing: 5) {
                    Text("Blind Series")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    
                    HStack {
                        Spacer().frame(width: UIScreen.main.bounds.width * 0.25)
                        ForEach(0..<4) { i in
                            Text("Series \(i + 1)")
                                .frame(width: UIScreen.main.bounds.width * 0.12, alignment: .center)
                        }
                        Text("Average")
                            .frame(width: UIScreen.main.bounds.width * 0.12, alignment: .center)
                    }
                    EvaluationRow(title: "Style", values: $eventData.currentDog.blindStyle)
                    EvaluationRow(title: "Perseverance", values: $eventData.currentDog.blindPerseverance)
                    EvaluationRow(title: "Trainability", values: $eventData.currentDog.blindTrainability)


                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // Total Score and Overall Average
                VStack(spacing: 5) {
                    Text("Total Score: \(totalScore, specifier: "%.1f")")
                        .font(.title2)
                    Text("Overall Average: \(overallAverage, specifier: "%.1f")")
                        .font(.title2)
                        .padding(.top, 5)
                }
                .padding(.horizontal)
                
                // Buttons for Save and Delete
                HStack {
                    Button(action: {
                        eventData.deleteCurrentEvaluation()
                        navigationStateManager.goToCurrentEventDogs(event: eventData.currentEvent)
                    }) {
                        Text("Delete")
                            .foregroundColor(.red)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                    }
                    Button(action: {
                        eventData.saveDog()
                        navigationStateManager.goToCurrentEventDogs(event: eventData.currentEvent)
                    }) {
                        Text("Save")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
        }

    }
}

#Preview {
    NavigationStack{
        EvaluationForm()
    }
    .environmentObject(EventModel())  // Pass mock EventModel
    .environmentObject(NavigationStateManager())  // Pass NavigationStateManager if needed

}
