//
//  KeyboardToolbar.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 04/11/2022.
//

import Foundation
import SwiftUI

struct KeyboardToolbar<ToolbarView: View>: ViewModifier {
    @Environment(\.isSearching) var isSearching
    
    let height: CGFloat
    let toolbarView: ToolbarView
    
    init(height: CGFloat, @ViewBuilder toolbar: () -> ToolbarView) {
        self.height = height
        self.toolbarView = toolbar()
    }
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                VStack {
                    content
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            if isSearching {
                toolbarView
                    .frame(height: self.height)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


extension View {
    func keyboardToolbar<ToolbarView>(height: CGFloat, view: @escaping () -> ToolbarView) -> some View where ToolbarView: View {
        modifier(KeyboardToolbar(height: height, toolbar: view))
    }
}
