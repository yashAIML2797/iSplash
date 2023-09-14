//
//  Photo.swift
//  iSplash
//
//  Created by Yash Uttekar on 13/09/23.
//

import Foundation

struct Photo: Decodable {
    let id: String
    let urls: ImageURL
    let width: CGFloat
    let height: CGFloat
    
    var size: CGSize {
        CGSize(width: width, height: height)
    }
}

struct ImageURL: Decodable {
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
