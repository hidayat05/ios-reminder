//
//  Reminder.swift
//  Reminder
//
//  Created by User on 05/07/21.
//

import Foundation


struct Reminder: Identifiable, Codable, Equatable {
    var id = UUID().uuidString
    var name: String
    var completed: Bool
    
    static func new() -> Reminder {
        return Reminder(name: "", completed: false)
    }
}

#if DEBUG
    let mockReminder = [
        Reminder(name: "Set appoinment with tim", completed: false),
        Reminder(name: "Pick up groceries", completed: false),
        Reminder(name: "Dinner with bob", completed: false),
        Reminder(name: "Search holiday gift", completed: false),
        Reminder(name: "Order new macbook", completed: false)
    ]
#endif
