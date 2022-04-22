//
//  UITextField.swift
//  Emojion
//
//  Created by Plus1XP on 18/04/2022.
//

import SwiftUI

/// Allows a user to pick an emoji character using the Emoji keyboard.
/// - Note: This does not prevent the user from manually switching to other keyboards and inputting a non-Emoji character
struct EmojiPicker: UIViewRepresentable {
    @Binding var emoji: String
    var placeholder: String = ""
    var textAlignment: NSTextAlignment = .left
    var isEmoji: Bool = true
    
    func makeUIView(context: UIViewRepresentableContext<EmojiPicker>) -> EmojiUITextField {
        let textField = EmojiUITextField(frame: .zero)
        textField.text = emoji
        textField.placeholder = placeholder
        textField.delegate = context.coordinator
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.textAlignment = textAlignment
        textField.tintColor = .clear
        return textField
    }
    
    func updateUIView(_ uiView: EmojiUITextField, context: Context) {
        uiView.text = emoji
    }
    
    func makeCoordinator() -> EmojiTextFieldCoordinator {
        return EmojiTextFieldCoordinator(self)
    }
}

internal class EmojiTextFieldCoordinator: NSObject, UITextFieldDelegate {
    var emojiTextField: EmojiPicker
    
    init(_ textField: EmojiPicker) {
        self.emojiTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.emojiTextField.emoji = textField.text!
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text = string
        
        if let text = textField.text, text.count == 1 {
            self.emojiTextField.emoji = textField.text!
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
        return true
    }
}

internal class EmojiUITextField: UITextField {
    override var textInputContextIdentifier: String? {
        return ""
    }
    
    override var textInputMode: UITextInputMode? {
        return .activeInputModes.first(where: { $0.primaryLanguage == "emoji" })
    }
    
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }
}
