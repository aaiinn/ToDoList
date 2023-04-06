//
//  TodoListView.swift
//  ToDo
//
//  Created by 신아인 on 2023/04/04.
//

import SwiftUI

struct TodoListView: View {
    
    @EnvironmentObject var todoLists: TodoLists
    
    var body: some View {
        List {
            ForEach(0..<todoLists.list.count, id: \.self) { i in
                HStack {
                    Button(action: {
                            toggleCheckedState(i)
                        },
                        label: {
                        Image(systemName:
                                todoLists.list[i].checked == true ?
                            "checkmark.square" :
                            "square")
                        }
                    )
                    Text(todoLists.list[i].content)
                    Spacer()
                    Button(
                        action: {
                            deleteList(i)
                        },
                        label: {
                            Image(systemName: "trash")
                        }
                    )
                    
                }
                .buttonStyle(BorderlessButtonStyle())
                
            }
        }
    }
    
    func toggleCheckedState(_ i: Int) {
        todoLists.list[i].checked.toggle()
    }
    
    func deleteList(_ i: Int) {
        todoLists.list.remove(at: i)
    }
}

