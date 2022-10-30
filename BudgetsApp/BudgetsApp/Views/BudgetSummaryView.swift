//
//  BudgetSummaryView.swift
//  BudgetsApp
//
//  Created by Supapon Pucknavin on 30/10/2565 BE.
//

import SwiftUI

struct BudgetSummaryView: View {
    // MARK: - PROPERTY
    @ObservedObject var budgetCategory: BudgetCategory
    
    // MARK: - FUNCTION
    
    // MARK: - BODY
    var body: some View {
        VStack {
            HStack{
                Text("\(budgetCategory.overSpent ? "Overspent" : "Remaining")")
                
                Text(budgetCategory.remainingBudgetTotal as NSNumber, formatter: NumberFormatter.currency)
            }//: HSTACK
            .frame(maxWidth: .infinity)
            .fontWeight(.bold)
            .foregroundColor(budgetCategory.overSpent ? .red : .green)
            
        }//: VSTACK
        
    }
}

// MARK: - PREVIEW
/*
struct BudgetSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetSummaryView()
    }
}
*/
