//
//  ContentView.swift
//  iSplash
//
//  Created by Yash Uttekar on 13/09/23.
//

import SwiftUI

struct ContentView: View {
    @State private var photos = [Photo]()
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()),
                                    GridItem(.flexible())],
                          spacing: 5
                ) {
                    ForEach(photos, id: \.id) { photo in
                        AsyncImage(url: URL(string: photo.urls.regular)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(width: ((geo.size.width - 20) * 0.5),
                               height: ((geo.size.width - 10) * 0.5)
                        )
                        .clipped()
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        .onAppear {
            APIService.shared.fetchPhotos(pageNumber: 1) { page in
                self.photos = page.photos
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
