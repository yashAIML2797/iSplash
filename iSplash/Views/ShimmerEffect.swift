//
//  ShimmerEffect.swift
//  iSplash
//
//  Created by Yash Uttekar on 24/09/23.
//

import SwiftUI

struct ShimmerEffect: View {
    @State private var translationX: CGFloat = 0
    
    var body: some View {
        GeometryReader { geo in
            Rectangle()
                .fill(Color("Shimmer"))
            LinearGradient(colors: [.white.opacity(0), .white, .white.opacity(0)],
                           startPoint: .leading,
                           endPoint: .trailing
            )
            .offset(x: translationX)
            .clipped()
            .onAppear {
                translationX = -geo.size.width
                withAnimation(.easeInOut(duration: 0.75).repeatForever(autoreverses: false)) {
                    translationX = geo.size.width
                }
            }
        }
    }
}
