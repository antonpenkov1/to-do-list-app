//
//  DateHolder.swift
//  ToDo
//
//  Created by Антон Пеньков on 02.04.2023.
//

import SwiftUI
import CoreData

class DateHolder: ObservableObject
{
    
    init(_ context: NSManagedObjectContext)
    {
        
    }
    
    func saveContext(_ context: NSManagedObjectContext)
    {
        do
        {
            try context.save()
        } catch
        {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
