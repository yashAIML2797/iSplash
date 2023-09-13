//
//  ContentView.swift
//  iSplash
//
//  Created by Yash Uttekar on 13/09/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                APIService.shared.fetchPhotos(pageNumber: 1)
            } label: {
                HStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.white)
                    Text("Hello, world!")
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            }
            .tint(.white)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
