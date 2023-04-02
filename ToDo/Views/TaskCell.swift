//
//  TaskCell.swift
//  ToDo
//
//  Created by Антон Пеньков on 02.04.2023.
//

import SwiftUI

struct TaskCell: View
{
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem: TaskItem
    
    var body: some View
    {
        CheckBoxView(passedTaskItem: passedTaskItem)
            .environmentObject(dateHolder)
        
        Text(passedTaskItem.name ?? "Task")
        Text("  due: ")
//        Text(passedTaskItem.dueDate!, formatter: itemFormatter)
    }
}

struct TaskCell_Previews: PreviewProvider
{
    static var previews: some View
    {
        TaskCell(passedTaskItem: TaskItem())
    }
}
