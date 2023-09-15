//
//  ContentView.swift
//  iSplash
//
//  Created by Yash Uttekar on 13/09/23.
//

import SwiftUI

struct ContentView: View {
    @State private var numberOfRows = 2
    @State private var currentTab = 0
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                HomeView(numberOfRows: $numberOfRows)
                    .shouldHide(currentTab != 0)
                
                
                SearchView(numberOfRows: $numberOfRows)
                    .shouldHide(currentTab != 1)
                
                
                FloatingTabView(currentTab: $currentTab)
                    .frame(width: geo.size.width * 0.8, height: 60)
                    .position(x: geo.size.width * 0.5, y: geo.size.height - geo.safeAreaInsets.bottom)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
