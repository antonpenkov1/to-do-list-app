//
//  CheckBoxView.swift
//  ToDo
//
//  Created by Антон Пеньков on 02.04.2023.
//

import SwiftUI

struct CheckBoxView: View
{
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem: TaskItem
    
    var body: some View
    {
        Image(systemName: passedTaskItem.isCompleted() ? "checkmark.circle.fill" : "circle")
            .foregroundColor(passedTaskItem.isCompleted() ? .green : .secondary)
            .onTapGesture {
                withAnimation
                {
                    if !passedTaskItem.isCompleted()
                    {
                        passedTaskItem.completedDate = Date()
                        dateHolder.saveContext(viewContext)
                    }
                }
            }
    }
}

struct CheckBoxView_Previews: PreviewProvider
{
    static var previews: some View
    {
        CheckBoxView(passedTaskItem: TaskItem())
    }
}
