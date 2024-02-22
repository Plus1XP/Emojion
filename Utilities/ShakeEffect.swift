//
//  ShakeEffect.swift
//  Emojion
//
//  Created by nabbit on 21/02/2024.
//

import SwiftUI

struct Shake<Content: View>: View {
    /// Set to true in order to animate
    @Binding var shake: Bool
    /// How many times the content will animate back and forth
    var repeatCount = 2
    /// Duration in seconds
    var duration = 0.25
    /// Range in pixels to go back and forth
    var offsetRange = 0.5
    /// Range in pixels to rotate axis
    var degreesRange = 2.0
    /// Range in pixels to increase and decrease
    var scaleRange = 1.025

    @ViewBuilder let content: Content
    var onCompletion: (() -> Void)?

    @State private var xOffset = 0.0
    @State private var xDegrees = 0.0
    @State private var xScale = 1.0


    var body: some View {
        content
            .offset(x: xOffset)
            .rotationEffect(.degrees(xDegrees))
            .scaleEffect(xScale)
            .onChange(of: shake) {
                guard shake else { return }
                Task {
                    let start = Date()
                    await animate()
                    let end = Date()
//                    debugPrint(end.timeIntervalSince1970 - start.timeIntervalSince1970)
                    shake = false
                    onCompletion?()
                }
            }
    }

    // Obs: sum of factors must be 1.0.
    private func animate() async {
        let factor1 = 0.9
        let eachDuration = duration * factor1 / CGFloat(repeatCount)
        for _ in 0..<repeatCount {
            await backAndForthAnimation(duration: eachDuration, offset: offsetRange, degrees: degreesRange, scale: scaleRange)
        }

        let factor2 = 0.1
        await animate(duration: duration * factor2) {
            xOffset = 0.0
            xDegrees = 0.0
            xScale = 1.0
        }
    }

    private func backAndForthAnimation(duration: CGFloat, offset: CGFloat, degrees: Double, scale: CGFloat) async {
        let halfDuration = duration / 2
        await animate(duration: halfDuration) {
            self.xOffset = offset
            self.xDegrees = degrees
            self.xScale = scale
        }

        await animate(duration: halfDuration) {
            self.xOffset = -offset
            self.xDegrees = -degrees
            self.xScale = 1.0
        }
    }
}

extension View {
    func shake(_ shake: Binding<Bool>,
               repeatCount: Int = 2,
               duration: CGFloat = 0.25,
               offsetRange: CGFloat = 0.5,
               degreesRange: Double = 2.0,
               scaleRange: CGFloat = 1.025,
               onCompletion: (() -> Void)? = nil) -> some View {
        Shake(shake: shake,
              repeatCount: repeatCount,
              duration: duration,
              offsetRange: offsetRange,
              degreesRange: degreesRange,
              scaleRange: scaleRange) {
            self
        } onCompletion: {
            onCompletion?()
        }
    }

    func animate(duration: CGFloat, _ execute: @escaping () -> Void) async {
        await withCheckedContinuation { continuation in
            withAnimation(.bouncy(duration: duration)) {
                execute()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                continuation.resume()
            }
        }
    }
}
