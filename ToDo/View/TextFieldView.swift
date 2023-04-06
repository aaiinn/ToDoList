//
//  TextFieldView.swift
//  ToDo
//
//  Created by 신아인 on 2023/04/04.
//

import SwiftUI

struct TextFieldView: View {
    
    @State var toDoString = ""
    @EnvironmentObject var todoLists : TodoLists
    
    var body: some View {
        HStack {
            Image(systemName: "square.and.pencil")
            TextField(
                "your task",
                text: $toDoString,
                onCommit: {
                    appendList()
                }
            )
        }
        .textFieldStyle(DefaultTextFieldStyle())
        .frame(width: 300, height: 50, alignment: .center)
    }
    
    func appendList() {
        let inputList = TodoList(content: toDoString, checked: false)
        
        todoLists.list.append(inputList)
        toDoString = ""
     }
}
