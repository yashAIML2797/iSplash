//
//  HomeView.swift
//  iSplash
//
//  Created by Yash Uttekar on 15/09/23.
//

import SwiftUI

struct HomeView: View {
    @State private var photos = [Photo]()
    @State private var currentPage = 1
    @State private var numberOfColumns = 2
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: numberOfColumns),
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
                    
                    if !photos.isEmpty {
                        LoadMoreButtonView(isLoading: $isLoading) {
                            isLoading = true
                            currentPage += 1
                            APIService.shared.fetchPhotos(pageNumber: currentPage) { page in
                                for photo in page.photos {
                                    if !self.photos.contains(where: {$0.id == photo.id}) {
                                        self.photos.append(photo)
                                    }
                                }
                                self.isLoading = false
                            }
                        }
                    }
                    
                    Rectangle()
                        .fill(.clear)
                        .frame(height: geo.size.height * 0.25)
                }
            }
            .animation(.spring(response: 0.5, dampingFraction: 1), value: numberOfColumns)
            .navigationTitle("iSplit")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ColumnView(numberOfColumns: $numberOfColumns)
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
        let cellWidth:  CGFloat = (scrollWidth - 20) / CGFloat(numberOfColumns)
        var cellHeight: CGFloat = .zero
        
        switch numberOfColumns {
        case 1:
            cellHeight = (photo.height * cellWidth) / photo.width
        default:
            cellHeight = (scrollWidth - 10) / CGFloat(numberOfColumns)
        }
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
