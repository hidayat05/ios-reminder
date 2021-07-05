//
//  ReminderCell.swift
//  Reminder
//
//  Created by User on 05/07/21.
//

import SwiftUI

struct ReminderCell: View {
    
    @ObservedObject private var _reminderVM : ReminderCellViewModel
    
    init(vm: ReminderCellViewModel) {
        self._reminderVM = vm
    }
    
    var body: some View {
        HStack {
            Image(systemName: _reminderVM.reminder.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor( _reminderVM.reminder.completed ? .red : Color(UIColor.lightGray))
                .onTapGesture {
                    _reminderVM.reminder.completed.toggle()
                    _reminderVM.setReminder()
                }
            
            TextField("Enter new reminder",
                      text: $_reminderVM.reminder.name,
                      onEditingChanged: { _ in},
                      onCommit: {
                        let reminder = _reminderVM.reminder
                        if reminder.name.isEmpty {
                            _reminderVM.deleteReminder()
                        } else {
                            _reminderVM.setReminder()
                        }
                        
                      })
        }
    }
}

struct ReminderCell_Previews: PreviewProvider {
    static var previews: some View {
        let reminder = mockReminder[0]
        ReminderCell(vm: ReminderCellViewModel(reminder: reminder))
    }
}
