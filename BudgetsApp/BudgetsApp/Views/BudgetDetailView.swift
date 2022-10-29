//
//  BudgetDetailView.swift
//  BudgetsApp
//
//  Created by Supapon Pucknavin on 29/10/2565 BE.
//

import SwiftUI
import CoreData

struct BudgetDetailView: View {
    // MARK: - PROPERTY
    @Environment(\.managedObjectContext) private var viewContext
    let budgetCategory: BudgetCategory
    @State private var title: String = ""
    @State private var total: String = ""

    
    // MARK: - FUNCTION
    var isFormValid: Bool {
        guard let totalAsDouble = Double(total) else { return false}
        return !title.isEmpty && !total.isEmpty && totalAsDouble > 0
    }
    
    private func saveTransaction() {
        
        do {
            let transaction = Transaction(context: viewContext)
            transaction.title = title
            transaction.total = Double(total) ?? 0
            
            budgetCategory.addToTransactions(transaction)
            
            try viewContext.save()
        } catch {
            print(error)
        }
   
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(budgetCategory.title ?? "" )
                        .font(.largeTitle)
                    
                    HStack {
                        Text("Budget:")
                        
                        Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                    }//: HSTACK
                    .fontWeight(.bold)
                    
                }//: VSTACK
                
            }//: HSTACK
            .padding()
            
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Total", text: $total)
                } header: {
                    Text("Add Transaction")
                }
                
                HStack {
                    Spacer()
                    
                    Button("Save Transaction"){
                        // save transaction
                        saveTransaction()
                        
                    }
                    .disabled(!isFormValid)
                    Spacer()
                }//: HSTACK
                
            }//: FORM
            
            Spacer()
            
        }//: VSTACK
    }
}

// MARK: - PREVIEW
/*
struct BudgetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetDetailView(budgetCategory: BudgetCategory())
    }
}
*/
