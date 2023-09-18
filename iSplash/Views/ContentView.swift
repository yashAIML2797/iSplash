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
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                HomeView(numberOfRows: $numberOfColumns)
                    .shouldHide(currentTab != 0)
                
                
                SearchView(numberOfRows: $numberOfColumns)
                    .shouldHide(currentTab != 1)
                
                
                FloatingTabView(numberOfColumns: $numberOfColumns)
                    .frame(width: geo.size.width * 0.8, height: 60)
                    .position(x: geo.size.width * 0.5, y: geo.size.height - geo.safeAreaInsets.bottom)
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
