//
//  ActivityIndicatorView.swift
//  iSplash
//
//  Created by Yash Uttekar on 24/09/23.
//

import SwiftUI

struct ActivityIndicatorView: View {
    @Binding var isLoading: Bool
    
    var body: some View {
        if isLoading {
            ProgressView()
                .controlSize(.large)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.thinMaterial)
                        .frame(width: 60, height: 60)
                )
        }
    }
}
