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
    @State private var isLoading = false
    @State private var isSearching = false
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                if photos.isEmpty {
                    Image("Explore")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5)
                        .position(x: geo.size.width * 0.5, y: (geo.size.height * 0.5) - 50)
                }
                
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
                                ShimmerEffect()
                            }
                            .frame(width: cellSize.width, height: cellSize.height)
                            .cornerRadius(10)
                            .clipped()
                        }
                    }
                    .padding(.horizontal, 10)
                    
                    if !photos.isEmpty {
                        LoadMoreButtonView(isLoading: $isLoading) {
                            currentPage += 1
                            isLoading = true
                            APIService.shared.fetchSearchResults(for: self.searchText, pageNumber: currentPage) { searcResult in
                                for photo in searcResult.results {
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
                .animation(.spring(response: 0.5, dampingFraction: 1), value: numberOfColumns)
                
                ActivityIndicatorView(isLoading: $isSearching)
                    .position(x: geo.size.width * 0.5, y: geo.size.height * 0.5)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    SwitchColumnView(numberOfColumns: $numberOfColumns)
                }
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { newValue in
            isSearching = !newValue.isEmpty
            timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        }
        .onReceive(timer) { _ in
            if !searchText.isEmpty {
                APIService.shared.fetchSearchResults(for: searchText, pageNumber: currentPage) { searcResult in
                    self.photos = []
                    self.isSearching = false
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
