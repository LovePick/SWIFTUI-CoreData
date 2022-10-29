//
//  BudgetsAppApp.swift
//  BudgetsApp
//
//  Created by Supapon Pucknavin on 29/10/2565 BE.
//

import SwiftUI

@main
struct BudgetsAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.share.viewContext)
        }
    }
}
