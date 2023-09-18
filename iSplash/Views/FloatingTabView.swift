//
//  FloatingTabView.swift
//  iSplash
//
//  Created by Yash Uttekar on 15/09/23.
//

import SwiftUI

struct FloatingTabView: View {
    @Binding var numberOfColumns: Int
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                
                LinearGradient(colors: [.green, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.75)
                    .cornerRadius(10)
                    .offset(x: getHighlightOffset(for: geo.size.width))
                
                HStack(spacing: geo.size.width * 0.1) {
                    
                    Image(systemName: numberOfColumns == 1 ? "rectangle.grid.1x2.fill" : "rectangle.grid.1x2")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(numberOfColumns == 1 ? .white: .black)
                        .frame(width: geo.size.width * 0.2, height: geo.size.height * 0.75)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            numberOfColumns = 1
                        }
                    
                    Image(systemName: numberOfColumns == 2 ? "rectangle.grid.2x2.fill" : "rectangle.grid.2x2")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(numberOfColumns == 2 ? .white: .black)
                        .frame(width: geo.size.width * 0.2, height: geo.size.height * 0.75)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            numberOfColumns = 2
                        }
                    
                    Image(systemName: numberOfColumns == 3 ? "rectangle.grid.3x2.fill" : "rectangle.grid.3x2")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(numberOfColumns == 3 ? .white: .black)
                        .frame(width: geo.size.width * 0.2, height: geo.size.height * 0.75)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            numberOfColumns = 3
                        }
                }
                .padding(.horizontal, geo.size.width * 0.1)
            }
            .animation(.easeOut, value: numberOfColumns)
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
    
    private func getHighlightOffset(for availableWidth: CGFloat) -> CGFloat {
        switch numberOfColumns {
        case 1:
            return -availableWidth * 0.3
        case 2:
            return 0
        case 3:
            return availableWidth * 0.3
        default:
            return 0
        }
    }
}

struct FloatingTabView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingTabView(numberOfColumns: .constant(1))
    }
}
