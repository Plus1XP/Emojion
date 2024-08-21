//
//  CancelButtonStyle.swift
//  Emojion
//
//  Created by nabbit on 20/08/2024.
//

import SwiftUI

struct CancelButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) private var colorScheme
    var cancelAnimation: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.largeTitle)
            .foregroundStyle(.red)
            .symbolEffect(.bounce, options: .speed(2), value: self.cancelAnimation)
            .symbolEffect(.pulse.wholeSymbol, options: .repeating, value: self.cancelAnimation)
            .contentTransition(.symbolEffect(.replace))
            .background(
                Circle()
                    .fill(Color.setFieldBackgroundColor(colorScheme: self.colorScheme).opacity(1))
                    .cornerRadius(25.0)
            )
    }
}
