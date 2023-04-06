//
//  ToDoApp.swift
//  ToDo
//
//  Created by 신아인 on 2023/04/03.
//

import SwiftUI

@main
struct todoApp: App {
    
    @StateObject var todoLists = TodoLists()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(todoLists)
        }
    }
}
