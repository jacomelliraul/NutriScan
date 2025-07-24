//
//  ContentView.swift
//  NutriScan
//
//  Created by Turma02-25 on 23/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            TabView{
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    
                AddView()
                    .tabItem {
                        Label("Add", systemImage: "plus")
                    }
                
                CalendarView()
                    .tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }
                
                ChatView()
                    .tabItem {
                        Label("Chat", systemImage: "message")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
