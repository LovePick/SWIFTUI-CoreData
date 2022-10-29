//
//  BudgetCategory+CoreDataClass.swift
//  BudgetsApp
//
//  Created by Supapon Pucknavin on 29/10/2565 BE.
//

import Foundation
import CoreData

@objc(BudgetCategory)
public class BudgetCategory: NSManagedObject {
    
    
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
}
