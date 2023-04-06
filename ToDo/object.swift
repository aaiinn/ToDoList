//
//  object.swift
//  ToDo
//
//  Created by 신아인 on 2023/04/04.
//

import Foundation

struct TodoList: Identifiable, Codable {
    var id = UUID()
    var content: String
    var checked: Bool
}

class TodoLists: ObservableObject {
    @Published var list = [TodoList]()
}
