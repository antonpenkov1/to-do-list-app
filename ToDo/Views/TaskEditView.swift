//
//  TaskEditView.swift
//  ToDo
//
//  Created by Антон Пеньков on 01.04.2023.
//

import SwiftUI
import CoreData

struct TaskEditView: View
{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    
    @State var selectedTaskItem: TaskItem?
    @State var name: String
    @State var desc: String
    @State var dueDate: Date
    @State var scheduledTime: Bool

    init(passedTaskItem: TaskItem?, initialDate: Date)
    {
        if let taskItem = passedTaskItem
        {
            _selectedTaskItem = State(initialValue: taskItem)
            _name = State(initialValue: taskItem.name ?? "")
            _desc = State(initialValue: taskItem.desc ?? "")
            _dueDate = State(initialValue: taskItem.dueDate ?? initialDate)
            _scheduledTime = State(initialValue: taskItem.scheduleTime)
        } else
        {
            _name = State(initialValue: "")
            _desc = State(initialValue: "")
            _dueDate = State(initialValue: initialDate)
            _scheduledTime = State(initialValue: false)
        }
    }
    
    var body: some View
    {
        Form
        {
            Section(header: Text("Task"))
            {
                TextField("Task Name",  text: $name)
                TextField("Desc",  text: $desc)
            }
            
            Section(header: Text("Due Date"))
            {
                Toggle("Scheduled Time", isOn: $scheduledTime )
                DatePicker("Due Date",  selection: $dueDate, displayedComponents: displayComp())
            }
            
            if selectedTaskItem?.isCompleted() ?? false
            {
                Section(header: Text("Completed"))
                {
                    Text(selectedTaskItem?.completedDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
                        .foregroundColor(.green)
                }
            }
            
            Section()
            {
                Button("Save", action: saveAction)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    func saveAction()
    {
        withAnimation
        {
            if selectedTaskItem == nil
            {
                selectedTaskItem = TaskItem(context: viewContext)
            }
            
            selectedTaskItem?.created = Date()
            selectedTaskItem?.name = name
            selectedTaskItem?.dueDate = dueDate
            selectedTaskItem?.scheduleTime = scheduledTime
            
            dateHolder.saveContext(viewContext)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func displayComp() -> DatePickerComponents
    {
        return scheduledTime ? [.hourAndMinute, .date] : [.date]
    }
}

struct TaskEditView_Previews: PreviewProvider
{
    static var previews: some View
    {
        TaskEditView( passedTaskItem: TaskItem(), initialDate: Date())
    }
}
