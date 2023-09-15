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
    @State private var numberOfRows = 2
    @State private var currentTab = 0
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: numberOfRows),
                              spacing: 5
                    ) {
                        ForEach(photos, id: \.id) { photo in
                            
                            let cellSize = getCellSize(for: photo.size, scrollWidth: geo.size.width)
                            
                            AsyncImage(url: URL(string: photo.urls.small)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: cellSize.width * 0.5, height: cellSize.height * 0.5)
                            }
                            .frame(width: cellSize.width, height: cellSize.height)
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
                    
                    Rectangle()
                        .fill(.clear)
                        .frame(height: geo.size.height * 0.25)
                }
                
                FloatingTabView(currentTab: $currentTab)
                    .frame(width: geo.size.width * 0.8, height: 60)
                    .position(x: geo.size.width * 0.5, y: geo.size.height - geo.safeAreaInsets.bottom)
            }
            .animation(.spring(response: 0.5, dampingFraction: 1), value: numberOfRows)
            .navigationTitle("iSplit")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        //
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Button {
                            numberOfRows = 1
                        } label: {
                            Image(systemName: numberOfRows == 1 ? "rectangle.grid.1x2.fill" : "rectangle.grid.1x2")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                        Button {
                            numberOfRows = 2
                        } label: {
                            Image(systemName: numberOfRows == 2 ? "rectangle.grid.2x2.fill" : "rectangle.grid.2x2")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                        Button {
                            numberOfRows = 3
                        } label: {
                            Image(systemName: numberOfRows == 3 ? "rectangle.grid.3x2.fill" : "rectangle.grid.3x2")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                    }
                }
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
    
    private func getCellSize(for photo: CGSize, scrollWidth: CGFloat) -> CGSize {
        let cellWidth:  CGFloat = (scrollWidth - 20) / CGFloat(numberOfRows)
        var cellHeight: CGFloat = .zero
        
        switch numberOfRows {
        case 1:
            cellHeight = (photo.height * cellWidth) / photo.width
        default:
            cellHeight = (scrollWidth - 10) / CGFloat(numberOfRows)
        }
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
