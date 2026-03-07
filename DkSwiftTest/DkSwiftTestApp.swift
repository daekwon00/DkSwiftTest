//
//  DkSwiftTestApp.swift
//  DkSwiftTest
//
//  Created by daekwon on 3/8/26.
//

import SwiftUI
import SwiftData

@main
struct DkSwiftTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [TodoItem.self])
    }
}
