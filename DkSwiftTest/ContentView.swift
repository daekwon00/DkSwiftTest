//
//  ContentView.swift
//  DkSwiftTest
//
//  Created by daekwon on 3/8/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("뉴스피드", systemImage: "newspaper") {
                PostListView()
            }

            Tab("할 일", systemImage: "checklist") {
                TodoListView()
            }

            Tab("설정", systemImage: "gearshape") {
                SettingsView()
            }

            Tab("쇼케이스", systemImage: "sparkles") {
                ShowcaseListView()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: TodoItem.self, inMemory: true)
}
