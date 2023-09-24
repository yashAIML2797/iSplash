//
//  LoadMoreView.swift
//  iSplash
//
//  Created by Yash Uttekar on 24/09/23.
//

import SwiftUI

struct LoadMoreButtonView: View {
    @Binding var isLoading: Bool
    var action: () -> Void
    
    var body: some View {
        if isLoading {
            ProgressView()
                .padding()
        } else {
            Button {
                action()
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
}
