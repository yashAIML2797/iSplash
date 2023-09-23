//
//  ContentView.swift
//  iSplash
//
//  Created by Yash Uttekar on 13/09/23.
//

import SwiftUI

struct ContentView: View {
    @State private var numberOfColumns = 2
    @State private var currentTab = 0
    @State private var searchText = ""
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                TabView(selection: $currentTab) {
                    HomeView(numberOfRows: $numberOfColumns)
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    
                    
                    SearchView(numberOfRows: $numberOfColumns)
                        .tabItem {
                            Label("Search", systemImage: "magnifyingglass")
                        }
                }
                .tint(.black)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
