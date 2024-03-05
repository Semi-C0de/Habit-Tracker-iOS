//
//  HabitView.swift
//  Habit-Tracker-V2
//
//  Created by Lalith Shravan Guruprasad on 1/11/24.
//

import SwiftUI

struct HabitView: View {

    @ObservedObject var dataManager:DataManager
    let habit:Habit
    @State var completionDateSelector:Date = Date.now
    
    
    
    init(habit:Habit, dataManager:DataManager) {

        self.dataManager = dataManager
        self.habit = habit
        
    }
    
    var body: some View {
        
        List {
            
            Section {
                Text("Target: \(habit.target)")
            }
            
            Section {
                DatePicker("Date", selection: $completionDateSelector, in: ...Date.now)
                
                Button("Add"){
                    _ = dataManager.addCompletion(date: completionDateSelector, habit: habit)
                }
            }
            
            Section {
                ForEach(habit.completionsArray, id: \.id){completion in
                    Text(completion.date?.formatted() ?? "NA")
                }
            }
        }
        .navigationTitle(habit.name ?? "NA")
        
    }
}
