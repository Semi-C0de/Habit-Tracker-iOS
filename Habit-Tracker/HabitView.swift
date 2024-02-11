//
//  HabitView.swift
//  Habit-Tracker-V2
//
//  Created by Lalith Shravan Guruprasad on 1/11/24.
//

import SwiftUI

struct HabitView: View {

    @ObservedObject var dataManager:DataManager
    let index:Int
    @State var completionDateSelector:Date = Date.now
    
    
    
    init(habit:Habit, dataManager:DataManager) {

        self.dataManager = dataManager
        self.index = dataManager.habits.firstIndex(of: habit) ?? 0
        
    }
    
    var body: some View {
        
        List {
            
            Section {
                Text("Target: ")
            }
            
            Section {
                DatePicker("Date", selection: $completionDateSelector, in: ...Date.now)
                
                Button("Add"){
                    let completion = dataManager.addCompletion(date: completionDateSelector, habit: dataManager.habits[self.index])
                }
            }
            
            Section {
                ForEach(dataManager.habits[self.index].completionsArray, id: \.id){completion in
                    Text(completion.date?.formatted() ?? "NA")
                }
            }
        }
        .navigationTitle(dataManager.habits[index].name ?? "NA")
        
    }
}
