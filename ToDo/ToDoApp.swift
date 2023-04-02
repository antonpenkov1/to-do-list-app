//
//  ToDoApp.swift
//  ToDo
//
//  Created by Антон Пеньков on 01.04.2023.
//

import SwiftUI
import CoreData

@main
struct ToDoApp: App
{
    let persistenceController = PersistenceController.shared

    var body: some Scene
    {
        WindowGroup
        {
            let context = persistenceController.container.viewContext
            let dateHolder = DateHolder(context)
            
            TaskListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(dateHolder)
        }
    }
}
