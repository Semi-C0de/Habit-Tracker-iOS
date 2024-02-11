//
//  DataController.swift
//  Habit-Tracker-V2
//
//  Created by Lalith Shravan Guruprasad on 11/17/23.
//

import Foundation
import CoreData

class DataManager:ObservableObject {
    
    @Published var habits:[Habit]
    @Published var completions:[Completion]
    
    static let shared = DataManager(containerName: "Container")
    let container:NSPersistentContainer
    
    init(containerName: String) {
        
        let container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        self.container = container
        
        self.habits = Self.fetchHabits(container: self.container)
        self.completions = Self.fetchCompletions(container: self.container)
    }
    
    static func fetchHabits(container:NSPersistentContainer) -> [Habit] {
        // Fetch singers
        let habitsRequest: NSFetchRequest<Habit> = Habit.fetchRequest()
        var fetchedHabits: [Habit] = []
        
        do {
            fetchedHabits = try container.viewContext.fetch(habitsRequest)
        } catch let error {
            print("Error fetching singers \(error)")
        }
        
        return fetchedHabits
    }
    
    static func fetchCompletions(container:NSPersistentContainer) -> [Completion] {
        // Fetch singers
        let completionsRequest: NSFetchRequest<Completion> = Completion.fetchRequest()
        var fetchedCompletions: [Completion] = []
        
        do {
            fetchedCompletions = try container.viewContext.fetch(completionsRequest)
        } catch let error {
            print("Error fetching singers \(error)")
        }
        
        return fetchedCompletions
    }

    
    func save () {
        let context = self.container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("❗️Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
        self.habits = Self.fetchHabits(container: self.container)
        self.completions = Self.fetchCompletions(container: self.container)
    }
    
    func addHabit(name:String, notes:String?) -> Habit {
        let habit = Habit(context: self.container.viewContext)
        
        habit.name = name
        habit.notes = notes
        habit.id = UUID()
        
        save()
        
        return habit
    }
    
    func addCompletion(date:Date, habit:Habit) -> Completion{
        let completion = Completion(context: self.container.viewContext)
        
        completion.date = date
        completion.habit = habit
        completion.id = UUID()
        
        save()
        
        return completion
    }
    
    func delete(object:NSManagedObject) { self.container.viewContext.delete(object); save();}
}
