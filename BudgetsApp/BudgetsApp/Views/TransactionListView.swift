//
//  TransactionListView.swift
//  BudgetsApp
//
//  Created by Supapon Pucknavin on 30/10/2565 BE.
//

import SwiftUI
import CoreData

struct TransactionListView: View {
    // MARK: - PROPERTY
    @FetchRequest var transactions: FetchedResults<Transaction>
    let onDeleteTransaction: (Transaction) -> Void
    
    // MARK: - FUNCTION
    init(request: NSFetchRequest<Transaction>, onDeleteTransaction: @escaping (Transaction) -> Void) {
        _transactions = FetchRequest(fetchRequest: request)
        self.onDeleteTransaction = onDeleteTransaction
    }
    
    
    // MARK: - BODY
    var body: some View {
        if transactions.isEmpty {
            Spacer()
                .frame(height: 50)
            VStack {
                HStack {
                    Spacer()
                    Text("No transactions.")
                    Spacer()
                }
        
                Spacer()
            }//: VSTACk
            
        } else {
            List {
                ForEach(transactions) { transaction in
                    HStack {
                        Text(transaction.title ?? "")
                        Spacer()
                        Text(transaction.total as NSNumber, formatter: NumberFormatter.currency)
                    }//: HSTACK
                    
                }//: LOOP
                .onDelete { offets in
                    offets.map { transactions[$0] }.forEach(onDeleteTransaction)
                }
                
            }//: LIST
            
        }//: CONDITIONS
    }
}

// MARK: - PREVIEW
/*
 struct TransactionListView_Previews: PreviewProvider {
 static var previews: some View {
 TransactionListView()
 }
 }*/
