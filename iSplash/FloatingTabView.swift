//
//  FloatingTabView.swift
//  iSplash
//
//  Created by Yash Uttekar on 15/09/23.
//

import SwiftUI

struct FloatingTabView: View {
    @Binding var currentTab: Int
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                
                LinearGradient(colors: [.green, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: geo.size.width * 0.4, height: geo.size.height * 0.75)
                    .cornerRadius(10)
                    .offset(x: geo.size.width * (currentTab == 0 ? -0.25 : 0.25))
                
                HStack(spacing: geo.size.width * 0.1) {
                    Image(systemName: "house")
                        .fontWeight(.semibold)
                        .foregroundColor(currentTab == 0 ? .white: .black)
                        .frame(width: geo.size.width * 0.4, height: geo.size.height * 0.75)
//                        .background(
//                            background(shouldHighlight: currentTab == 0)
//                        )
                        .contentShape(Rectangle())
                        .onTapGesture {
                            currentTab = 0
                        }
                    
                    Image(systemName: "magnifyingglass")
                        .fontWeight(.semibold)
                        .foregroundColor(currentTab == 1 ? .white: .black)
                        .frame(width: geo.size.width * 0.4, height: geo.size.height * 0.75)
//                        .background(
//                            background(shouldHighlight: currentTab == 1)
//                        )
                        .contentShape(Rectangle())
                        .onTapGesture {
                            currentTab = 1
                        }
                }
            }
            .animation(.easeOut, value: currentTab)
        }
    }
    
    @ViewBuilder func background(shouldHighlight: Bool) -> some View {
        if shouldHighlight {
            LinearGradient(colors: [.green, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
                .cornerRadius(10)
        } else {
            Color.clear
        }
    }
}

struct FloatingTabView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingTabView(currentTab: .constant(0))
    }
}
