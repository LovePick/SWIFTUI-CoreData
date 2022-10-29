//
//  ContentView.swift
//  BudgetsApp
//
//  Created by Supapon Pucknavin on 29/10/2565 BE.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTY
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var budgetCategoryResults: FetchedResults<BudgetCategory>
    @State private var isPresented: Bool = false
    
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
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack {
                
                Text(total as NSNumber, formatter: NumberFormatter.currency)
                    .fontWeight(.bold)
                
                BudgetListView(budgetCategoryResults: budgetCategoryResults, onDeleteBudgetCategory: deleteBudgetCategory)
   
            }//: VSTACK
            .sheet(isPresented: $isPresented, content: {
                AddBudgetCategoryView()
            })//: SHEET
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Category") {
                        isPresented = true
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
