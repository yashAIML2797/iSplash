//
//  ContentView.swift
//  iSplash
//
//  Created by Yash Uttekar on 13/09/23.
//

import SwiftUI

struct ContentView: View {
    @State private var photos = [Photo]()
    @State private var currentPage = 1
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()),
                                    GridItem(.flexible())],
                          spacing: 5
                ) {
                    ForEach(photos, id: \.id) { photo in
                        
                        let cellWidth =     (geo.size.width - 20) * 0.5
                        let cellHeight =    (geo.size.width - 10) * 0.5
                        
                        AsyncImage(url: URL(string: photo.urls.regular)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: cellWidth * 0.5, height: cellHeight * 0.5)
                        }
                        .frame(width: cellWidth, height: cellHeight)
                        .cornerRadius(10)
                        .clipped()
                    }
                }
                .padding(.horizontal, 10)
                
                Button {
                    currentPage += 1
                    APIService.shared.fetchPhotos(pageNumber: currentPage) { page in
                        for photo in page.photos {
                            if !self.photos.contains(where: {$0.id == photo.id}) {
                                self.photos.append(photo)
                            }
                        }
                    }
                } label: {
                    Text("Load More")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(.black)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .onAppear {
            APIService.shared.fetchPhotos(pageNumber: currentPage) { page in
                for photo in page.photos {
                    if !self.photos.contains(where: {$0.id == photo.id}) {
                        self.photos.append(photo)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
