//
//  ContentView.swift
//  Reminder
//
//  Created by User on 05/07/21.
//

import SwiftUI

struct ReminderList: View {
    
    @ObservedObject var reminderManager = ReminderManager.shared
    
    @State private var hideCompleted = false
    @State private var addReminder = false
    @State private var sortByName = false
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                List{
                    Toggle("Hide completed", isOn: $hideCompleted)
                    ForEach(reminderManager.reminders, id: \.id) { reminder in
                        if !hideCompleted || !reminder.completed {
                            ReminderCell(vm: ReminderCellViewModel(reminder: reminder))
                        }
                    }
                    .onDelete(perform: self.removeRow )
                    .onMove(perform: self.move )
                    
                    if addReminder {
                        ReminderCell(vm: ReminderCellViewModel(reminder: Reminder.new()))
                    }
                }.padding(.horizontal, -20)
                
                HStack {
                    Button(action:{ toggleAddForm() }) {
                        HStack{
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Text("New Reminder")
                        }.padding()
                    }
                    
                    Spacer()
                    
                    if addReminder {
                        Button(action: { self.toggleAddForm() }) {
                            Text("Done")
                        }.padding()
                    }
                }
            }
            .navigationBarTitle("Reminder")
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    private func toggleAddForm(){
        addReminder.toggle()
    }
    
    private func removeRow(at offsets: IndexSet){
        for offset in offsets {
            let reminder = reminderManager.reminders[offset]
            reminderManager.delete(reminder)
        }
    }
    
    private func move(from source: IndexSet, to destination: Int){
        reminderManager.move(from: source, to: destination)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderList()
    }
}
