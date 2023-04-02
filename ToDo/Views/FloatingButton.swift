//
//  FloatingButton.swift
//  ToDo
//
//  Created by Антон Пеньков on 01.04.2023.
//

import SwiftUI

struct FloatingButton: View {
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View
    {
        Spacer()
        HStack
        {
            NavigationLink(destination: TaskEditView(passedTaskItem: nil, initialDate: Date())
                .environmentObject(dateHolder))
            {
                Text("+")
                    .font(.headline)
            }
            .padding(15)
            .frame(width: 50, height: 50)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(50)
            .padding(30)
            .shadow(color: .black.opacity(0.3), radius: 5, x: 4, y: 4)
        }
    }
}

struct FloatingButton_Previews:PreviewProvider {
    static var previews: some View {
        FloatingButton()
    }
}
