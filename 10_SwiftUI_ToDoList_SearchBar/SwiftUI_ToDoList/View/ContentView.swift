//
//  ContentView.swift
//  SwiftUI_ToDoList
//
//  Created by Stanly Shiyanovskiy on 30.11.2020.
//

import CoreData
import SwiftUI

struct FilteredList: View {
    
    @Environment(\.managedObjectContext) var context
    
    @Binding var searchText: String
    
    var fetchRequest: FetchRequest<ToDoItem>
    var todoItems: FetchedResults<ToDoItem> {
        fetchRequest.wrappedValue
    }
    
    init(_ searchText: Binding<String>) {
        self._searchText = searchText
        
        let predicate = searchText.wrappedValue.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "name CONTAINS[c] %@", searchText.wrappedValue)
        
        fetchRequest = FetchRequest(entity: ToDoItem.entity(), sortDescriptors: [ NSSortDescriptor(keyPath: \ToDoItem.priorityNum, ascending: false) ], predicate: predicate, animation: .default)
    }
    
    var body: some View {
        
        ZStack {
            List {
                
                ForEach(todoItems) { todoItem in
                    ToDoListRow(todoItem: todoItem)
                }
                .onDelete(perform: deleteTask)
            }
            
            if todoItems.count == 0 {
                NoDataView()
            }
        }
    }
    
    private func deleteTask(indexSet: IndexSet) {
        for index in indexSet {
            let itemToDelete = todoItems[index]
            context.delete(itemToDelete)
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

struct ContentView: View {
    
    @State private var newItemName: String = ""
    @State private var newItemPriority: Priority = .normal
    
    @State private var showNewTask = false
    
    @State private var searchText = ""
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                HStack {
                    Text("ToDo List")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                    
                    Spacer()
                    
                    Button(action: {
                        self.showNewTask = true
                        
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.purple)
                    }
                }
                .padding()
                
                SearchBar(text: $searchText)
                    .padding(.top, -20)
                
                FilteredList($searchText)
                
                // Search by filtering array's data
                //                    ForEach(todoItems.filter { searchText.isEmpty ? true : $0.name.contains(searchText)}) { todoItem in
                //                        ToDoListRow(todoItem: todoItem)
                //                    }
                //                    .onDelete(perform: deleteTask)
            }
        }
        .rotation3DEffect(Angle(degrees: showNewTask ? 5 : 0), axis: (x: 1, y: 0, z: 0))
        .offset(y: showNewTask ? -50 : 0)
        .animation(.easeOut)
        
        // Display the "Add new todo" view
        if showNewTask {
            BlankView(bgColor: .black)
                .opacity(0.5)
                .onTapGesture {
                    self.showNewTask = false
                }
            
            NewToDoView(isShow: $showNewTask, name: "", priority: .normal)
                .transition(.move(edge: .bottom))
                .animation(.interpolatingSpring(stiffness: 200.0, damping: 25.0, initialVelocity: 10.0))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct BlankView : View {

    var bgColor: Color

    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(bgColor)
        .edgesIgnoringSafeArea(.all)
    }
}

struct NoDataView: View {
    var body: some View {
        Image("welcome")
            .resizable()
            .scaledToFit()
    }
}

struct ToDoListRow: View {
    
    @Environment(\.managedObjectContext) var context
    @ObservedObject var todoItem: ToDoItem
    
    var body: some View {
        Toggle(isOn: self.$todoItem.isComplete) {
            HStack {
                Text(self.todoItem.name)
                    .strikethrough(self.todoItem.isComplete, color: .black)
                    .bold()
                    .animation(.default)
                
                Spacer()
                
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(self.color(for: self.todoItem.priority))
            }
        }
        .toggleStyle(CheckboxStyle())
        .onReceive(todoItem.objectWillChange) { _ in
            if context.hasChanges {
                try? context.save()
            }
        }
    }
    
    private func color(for priority: Priority) -> Color {
        switch priority {
        case .high: return .red
        case .normal: return .orange
        case .low: return .green
        }
    }
}
