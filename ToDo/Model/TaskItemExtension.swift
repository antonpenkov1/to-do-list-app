//
//  TaskItemExtension.swift
//  ToDo
//
//  Created by Антон Пеньков on 02.04.2023.
//

import SwiftUI

extension TaskItem
{
    func isCompleted() -> Bool
    {
        return completedDate != nil
    }
}
