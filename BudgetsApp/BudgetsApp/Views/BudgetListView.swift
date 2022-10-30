//
//  BudgetListView.swift
//  BudgetsApp
//
//  Created by Supapon Pucknavin on 29/10/2565 BE.
//

import SwiftUI

struct BudgetListView: View {
    // MARK: - PROPERTY
    let budgetCategoryResults: FetchedResults<BudgetCategory>
    let onDeleteBudgetCategory: (BudgetCategory) -> Void
    let onEditBudgetCategory: (BudgetCategory) -> Void
    
    // MARK: - FUNCTION
    
    
    
    // MARK: - BODY
    var body: some View {
        List {
            
            if !budgetCategoryResults.isEmpty {
                
                ForEach(budgetCategoryResults) { budgetCategory in
                    NavigationLink(value: budgetCategory) {
                        HStack {
                            Text(budgetCategory.title ?? "" )
                            
                            Spacer()
                            
                            VStack(alignment: .trailing , spacing: 10) {
                                Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                                
                                HStack{
                                    Text("\(budgetCategory.overSpent ? "Overspent" : "Remaining")")
                                    
                                    Text(budgetCategory.remainingBudgetTotal as NSNumber, formatter: NumberFormatter.currency)
                                }//: HSTACK
                                .fontWeight(.bold)
                                .foregroundColor(budgetCategory.overSpent ? .red : .green)
                                
                            }//: VSTACK
                            
                        }//: HSTACK
                        .contentShape(Rectangle())
                        .onLongPressGesture {
                            onEditBudgetCategory(budgetCategory)
                        }
                        
                    }//: NAVIGATION LINK
                    
                }//: LOOP
                .onDelete { indexSet in
                    indexSet.map { budgetCategoryResults[$0] }.forEach(onDeleteBudgetCategory)
                }
                
                
            } else {
                Text("No budget categories exists.")
            }//: CONDITIONS
            
        }//: LIST
        .listStyle(.plain)
        .navigationDestination(for: BudgetCategory.self) { budgetCategory in
            BudgetDetailView(budgetCategory: budgetCategory)
        }
    }
}

// MARK: - PREVIEW
/*
struct BudgetListView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetListView()
    }
}
 */
