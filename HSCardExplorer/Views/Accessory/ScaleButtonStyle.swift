//
//  ScaleButtonStyle.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 06/11/2022.
//

import Foundation
import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}
