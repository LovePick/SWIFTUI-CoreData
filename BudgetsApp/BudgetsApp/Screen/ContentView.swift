//
//  ContentView.swift
//  BudgetsApp
//
//  Created by Supapon Pucknavin on 29/10/2565 BE.
//

import SwiftUI

enum SheetAction: Identifiable {
    case add
    case edit(BudgetCategory)
    
    var id: Int {
        switch self {
        case .add:
            return 1
        case .edit(_):
            return 2
        }
    }
}

struct ContentView: View {
    // MARK: - PROPERTY
    @Environment(\.managedObjectContext) private var viewContext
    
//    @FetchRequest(sortDescriptors: []) private var budgetCategoryResults: FetchedResults<BudgetCategory>
    @FetchRequest(fetchRequest: BudgetCategory.all) var budgetCategoryResults
    
    @State private var sheetAction: SheetAction?
    
    // MARK: - FUNCTION
    var total: Double {
        budgetCategoryResults.reduce(0) { result, budgetCategory in
            return result + budgetCategory.total
        }
    }
    
    private func deleteBudgetCategory(_ budgetCategory: BudgetCategory) {
        
        viewContext.delete(budgetCategory)
        do{
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    private func editBudgetCategory(_ budgetCategory:BudgetCategory) {
        sheetAction = .edit(budgetCategory)
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Total Budget -")
                    Text(total as NSNumber, formatter: NumberFormatter.currency)
                        .fontWeight(.bold)
                }//: HSTACK
                
                
                BudgetListView(budgetCategoryResults: budgetCategoryResults,
                               onDeleteBudgetCategory: deleteBudgetCategory,
                               onEditBudgetCategory: editBudgetCategory)
                
            }//: VSTACK
            .sheet(item: $sheetAction, content: { sheetAction in
                
                switch sheetAction {
                case .add:
                    AddBudgetCategoryView()
                case .edit(let budgetCategory):
                    AddBudgetCategoryView(budgetCategory: budgetCategory)
                }
            })//: SHEET
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Category") {
                        sheetAction = .add
                    }
                }
            }//: TOOL BAR
            .padding()
            
            
        }//: NAVIGATION
        
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, CoreDataManager.share.viewContext)
    }
}
