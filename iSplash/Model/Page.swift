//
//  Page.swift
//  iSplash
//
//  Created by Yash Uttekar on 13/09/23.
//

import Foundation

struct Page: Decodable {
    let number: Int
    let photos: [Photo]
}
