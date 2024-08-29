//
//  SaveButtonStyle.swift
//  Emojion
//
//  Created by nabbit on 20/08/2024.
//

import SwiftUI

struct SaveButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) private var colorScheme
    var saveAnimation: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.largeTitle)
            .foregroundStyle(.green)
            .symbolEffect(.bounce, options: .speed(2), value: self.saveAnimation)
            .symbolEffect(.pulse.wholeSymbol, options: .repeating, value: self.saveAnimation)
            .contentTransition(.symbolEffect(.replace))
            .background(
                Circle()
                    .fill(Color.setFieldBackgroundColor(colorScheme: self.colorScheme).opacity(1))
                    .cornerRadius(25.0)
            )
    }
}
