//
//  ToDoItem.swift
//  SwiftUI_ToDoList
//
//  Created by Stanly Shiyanovskiy on 30.11.2020.
//

import CoreData
import SwiftUI

enum Priority: Int {
    case low = 0
    case normal = 1
    case high = 2
}

@objc(ToDoItem)
public class ToDoItem: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var priorityNum: Int32
    @NSManaged public var isComplete: Bool
}

extension ToDoItem: Identifiable {
    
    var priority: Priority {
        get {
            return Priority(rawValue: Int(priorityNum)) ?? .normal
        }
        
        set {
            priorityNum = Int32(newValue.rawValue)
        }
    }
}
