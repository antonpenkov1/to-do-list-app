//
//  ContentView.swift
//  ToDo
//
//  Created by Антон Пеньков on 01.04.2023.
//

import SwiftUI
import CoreData

struct TaskListView: View
{
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.dueDate, ascending: true)],
        animation: .default)
    private var items: FetchedResults<TaskItem>

    var body: some View
    {
        NavigationView
        {
            VStack
            {
                ZStack
                {
                    List
                    {
                        ForEach(items)
                        { taskItem in
                            NavigationLink(destination: TaskEditView(passedTaskItem: taskItem, initialDate: Date())
                                .environmentObject(dateHolder))
                            {
                                TaskCell(passedTaskItem: taskItem)
                                    .environmentObject(dateHolder)
                                Text(taskItem.dueDate!, formatter: itemFormatter)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .toolbar
                    {
                        ToolbarItem(placement: .navigationBarTrailing)
                        {
                            EditButton()
                        }

                    }
                    
                    FloatingButton().environmentObject(dateHolder).offset(x: 150, y: 300)
                }
            }.navigationTitle("To Do List")
        }
    }
    
    private func deleteItems(offsets: IndexSet)
    {
        withAnimation
        {
            offsets.map{ items[$0] }.forEach(viewContext.delete)

            dateHolder.saveContext(viewContext)
        }
    }
}

private let itemFormatter: DateFormatter =
{
    let formatter = DateFormatter()
    formatter.dateStyle = .long
//    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        TaskListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}





//private func addItem() {
//        withAnimation {
//            let newItem = TaskItem(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
