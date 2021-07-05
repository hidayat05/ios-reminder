//
//  ReminderCellViewModel.swift
//  Reminder
//
//  Created by User on 05/07/21.
//

import Foundation

class ReminderCellViewModel: ObservableObject {
    @Published var reminder: Reminder
    
    init(reminder: Reminder) {
        self.reminder = reminder
    }
    
    func setReminder() {
        ReminderManager.shared.set(reminder)
    }
    
    func deleteReminder() {
        ReminderManager.shared.delete(reminder)
    }
}
