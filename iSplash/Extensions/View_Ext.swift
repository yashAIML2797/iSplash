//
//  View_Ext.swift
//  iSplash
//
//  Created by Yash Uttekar on 15/09/23.
//

import SwiftUI

struct ShouldHide: ViewModifier {
    var shouldHide: Bool
    func body(content: Content) -> some View {
        content
            .opacity(shouldHide ? 0 : 1)
    }
}

extension View {
    func shouldHide(_ hide: Bool) -> some View {
        modifier(ShouldHide(shouldHide: hide))
    }
}
