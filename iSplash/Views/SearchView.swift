//
//  SearchView.swift
//  iSplash
//
//  Created by Yash Uttekar on 15/09/23.
//

import SwiftUI

struct SearchView: View {
    @State private var photos = [Photo]()
    @State private var currentPage = 1
    @State private var searchText = ""
    @State private var numberOfColumns = 2
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                if !photos.isEmpty {
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
                        
                        Button {
                            currentPage += 1
                            APIService.shared.fetchSearchResults(for: searchText, pageNumber: currentPage) { searcResult in
                                for photo in searcResult.results {
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
                    .animation(.spring(response: 0.5, dampingFraction: 1), value: numberOfColumns)
                } else {
                    if !searchText.isEmpty {
                        ProgressView()
                            .position(x: geo.size.width * 0.5, y: geo.size.height * 0.5)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Button {
                            numberOfColumns = 1
                        } label: {
                            Image(systemName: numberOfColumns == 1 ? "rectangle.grid.1x2.fill" : "rectangle.grid.1x2")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                        Button {
                            numberOfColumns = 2
                        } label: {
                            Image(systemName: numberOfColumns == 2 ? "rectangle.grid.2x2.fill" : "rectangle.grid.2x2")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                        Button {
                            numberOfColumns = 3
                        } label: {
                            Image(systemName: numberOfColumns == 3 ? "rectangle.grid.3x2.fill" : "rectangle.grid.3x2")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { _ in
            timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        }
        .onReceive(timer) { _ in
            if !searchText.isEmpty {
                APIService.shared.fetchSearchResults(for: searchText, pageNumber: currentPage) { searcResult in
                    self.photos = []
                    for photo in searcResult.results {
                        if !self.photos.contains(where: {$0.id == photo.id}) {
                            self.photos.append(photo)
                        }
                    }
                }
            }
            timer.upstream.connect().cancel()
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
