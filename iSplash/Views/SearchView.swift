//
//  SearchView.swift
//  iSplash
//
//  Created by Yash Uttekar on 15/09/23.
//

import SwiftUI

struct SearchView: View {
    @Binding var numberOfRows: Int
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                
            }
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
        .searchable(text: $searchText)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(numberOfRows: .constant(2))
    }
}
