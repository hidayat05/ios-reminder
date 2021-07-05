//
//  ReminderManager.swift
//  Reminder
//
//  Created by User on 05/07/21.
//

import SwiftUI
import Foundation


class ReminderManager: ObservableObject {
    
    static let shared = ReminderManager()
    
    @Published var reminders = [Reminder]()
    
    private init(){
        loadReminder()
    }
    
    private func loadReminder(){
        if let data = UserDefaults.standard.data(forKey: "reminders"),
           let reminders = try? JSONDecoder().decode([Reminder].self, from: data){
            self.reminders = self.sort(reminders)
        }
    }
    
    func set(_ reminder: Reminder) {
        var reminders = self.reminders
        if !reminders.filter({ $0.id == reminder.id }).isEmpty {
            update(reminder)
        } else {
            reminders.append(reminder)
            save(reminders)
        }
    }
    
    func update(_ reminder: Reminder){
        var reminders = self.reminders
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[index] = reminder
        }
        save(reminders)
    }
    
    func save(_ reminders: [Reminder]){
        let encodedData = try? JSONEncoder().encode(reminders)
        UserDefaults.standard.set(encodedData, forKey: "reminders")
        self.reminders = self.sort(reminders)
    }
    
    func delete(_ reminder: Reminder) {
        let reminders = self.reminders.filter({ $0.id != reminder.id})
        save(reminders)
    }
    
    func move(from source: IndexSet, to  destination: Int) {
        var reminders = self.reminders
        reminders.move(fromOffsets: source, toOffset: destination)
        save(reminders)
    }
    
    func sort(_ reminders: [Reminder]) -> [Reminder] {
        return reminders.sorted(by: { !$0.completed && $1.completed})
    }
    
}
