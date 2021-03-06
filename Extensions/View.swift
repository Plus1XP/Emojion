//
//  View.swift
//  Emojion
//
//  Created by Plus1XP on 18/04/2022.
//

import SwiftUI

extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
    
    func fillBackground(cornerRadius: CGFloat = 10) -> some View {
        return modifier(BackgroundColorModifier(cornerRadius: cornerRadius))
    }
    
    func popover<Content>(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        content: @escaping () -> Content
    ) -> some View where Content: View {
        ModifiedContent(
            content: self,
            modifier: PopoverViewModifier(
                isPresented: isPresented,
                onDismiss: onDismiss,
                content: content
            )
        )
    }
}

private struct BackgroundColorModifier: ViewModifier {
    
    @Environment (\.colorScheme) var colorScheme: ColorScheme
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        let backgroundColor: Color = {
            switch colorScheme {
            case .light:
                return Color(UIColor.systemBackground)
            case .dark:
                return Color(UIColor.secondarySystemBackground)
            @unknown default:
                return Color(UIColor.systemBackground)
            }
        }()
        return content.background(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous).fill(backgroundColor))
    }
}
