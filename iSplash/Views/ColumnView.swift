//
//  ColumnView.swift
//  iSplash
//
//  Created by Yash Uttekar on 24/09/23.
//

import SwiftUI

struct ColumnView: View {
    @Binding var numberOfColumns: Int
    
    var body: some View {
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
