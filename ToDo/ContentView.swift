//
//  ContentView.swift
//  ToDo
//
//  Created by 신아인 on 2023/04/03.
//

import SwiftUI

struct ContentView: View {
    
    
    
    struct TodoList: Identifiable, Codable {
        var id = UUID()
        var content: String
        var checked: Bool
    }
    
    @State var toDoString = ""
    @State private var todoLists = [TodoList]()
    
    
    var body: some View {
        
        VStack{
            
            Text("What to do Today?").font(.title.bold())
            
            HStack{
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
            
            List {
                ForEach(0..<todoLists.count, id: \.self) { i in
                    HStack {
                        Button(
                            action: {
                                toggleCheckedState(i)
                            },
                            label: {
                                Image(systemName:
                                        todoLists[i].checked == true
                                      ? "checkmark.square.fill"
                                      : "square"
                                )
                            }
                        )
                        Text(todoLists[i].content)
                        Spacer()
                        Button(
                            action: {
                                deleteList(i)
                            },
                            label: {
                                Image(systemName: "trash")
                            }
                        )
                    }.buttonStyle(BorderlessButtonStyle())
                }
            }
            
            HStack(spacing: 50){
                Button("Save", action: saveTodoList).padding(.all, 10)
                Button("Load", action: loadTodoList).padding(.all, 10)
            }.buttonStyle(BorderedButtonStyle())
            
        }
        
    }
    
    func appendList() {
        let inputList = TodoList(content: toDoString, checked: false)
        todoLists.append(inputList)
        toDoString = ""
    }
    
    func toggleCheckedState(_ i: Int) {
        todoLists[i].checked.toggle()
    }
    
    func deleteList(_ i: Int) {
        todoLists.remove(at: i)
    }
    
    func getDocumentPath() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func dataToJsonString() -> String? {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(todoLists)
            return String(data: data, encoding: .utf8)
        }
        catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func saveTodoList() {
        
        let path = getDocumentPath().appendingPathComponent("todolist.json")
        let jsonString = dataToJsonString()
        
        // dataToJsonString() 함수의 반환형이 String? 이므로, nil인 경우에 대한 처리
        if jsonString == nil {
            print("Error: No JSON String found")
            return
        }
        
        do {
            try jsonString?.write(to: path, atomically: true, encoding: .utf8)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func jsonStringToData(_ jsonString: String) -> [TodoList]? {
        
        let decoder = JSONDecoder()
        let jsonData = jsonString.data(using: .utf8)
        
        if jsonData == nil {
            print("Error: Cannot convert json String to Data")
            return nil
        }
        
        do {
            let returnList = try decoder.decode([TodoList].self, from: jsonData!)
            return returnList
        }
        catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func loadTodoList() {
        
        let path = getDocumentPath().appendingPathComponent("todolist.json")
        
        do {
            let jsonString = try String(contentsOf: path)
            let jsonData = jsonStringToData(jsonString)
            
            if jsonData == nil {
                print("Error: No Array found")
                return
            }
            
            todoLists = jsonData!
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

