//
//  DisplayConfettiModifier.swift
//  Emojion
//
//  Created by nabbit on 20/08/2024.
//

import SwiftUI

struct DisplayConfettiModifier: ViewModifier {
    @Binding var isActive: Bool {
        didSet {
            if !isActive {
                opacity = 1
            }
        }
    }
    @State private var opacity = 1.0 {
        didSet {
            if opacity == 0 {
                isActive = false
            }
        }
    }
    
    private let animationTime = 3.0
    private let fadeTime = 2.0

    func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content
                .overlay(isActive ? ConfettiContainerView().opacity(opacity) : nil)
                .sensoryFeedback(.success, trigger: isActive)
                .task {
                    await handleAnimationSequence()
                }
        } else {
            content
                .overlay(isActive ? ConfettiContainerView().opacity(opacity) : nil)
                .task {
                    await handleAnimationSequence()
                }
        }
    }

    private func handleAnimationSequence() async {
        do {
            try await Task.sleep(nanoseconds: UInt64(animationTime * 1_000_000_000))
            withAnimation(.easeOut(duration: fadeTime)) {
                opacity = 0
            }
        } catch {}
    }
}

extension View {
    func displayConfetti(isActive: Binding<Bool>) -> some View {
        self.modifier(DisplayConfettiModifier(isActive: isActive))
    }
}
