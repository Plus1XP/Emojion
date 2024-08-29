//
//  GrowingIconButtonStyle.swift
//  Emojion
//
//  Created by nabbit on 20/08/2024.
//

import SwiftUI

struct GrowingIconButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
