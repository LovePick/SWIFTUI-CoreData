//
//  CoreDataManager.swift
//  BudgetsApp
//
//  Created by Supapon Pucknavin on 29/10/2565 BE.
//

import Foundation
import CoreData

class CoreDataManager {
    static let share = CoreDataManager()
    private var persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "BudgetModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Unnable to initialize Core Data stack \(error)")
            }
        }
        
    }
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    
}
