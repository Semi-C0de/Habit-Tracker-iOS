//
//  ContentView.swift
//  Habit-Tracker-V2
//
//  Created by Lalith Shravan Guruprasad on 11/17/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var dataManager:DataManager = DataManager(containerName: "Container")
    
    @State var habitName = ""
    
    var body: some View {
        NavigationStack {
            
            Form {
                
                
                Section {
                    TextField("Habit Name", text: $habitName)
                    Button("Add", action: {
                        let habit = dataManager.addHabit(name: habitName, notes: "")
                        self.habitName = ""
                    })
                }
                
                Section {
                    ForEach(dataManager.habits, id: \.id) {habit in
                        
                        HStack {
                            NavigationLink(habit.name ?? "NA", destination: HabitView(habit: habit, dataManager: self.dataManager))
                            
                            Spacer()
                            
                            
                        }
                    }
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}


extension Habit {
    var completionsArray:[Completion] {
        let dateComparer:(Completion, Completion) -> Bool = {completion1, completion2 in completion1.date ?? Date.now < completion2.date ?? Date.now}
        
        let completions = self.completions?.allObjects as! [Completion]
        
        let completionsSorted = completions.sorted(by: dateComparer)
        
        return completionsSorted
    }
}
