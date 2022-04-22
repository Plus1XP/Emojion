//
//  Binding.swift
//  Emojion
//
//  Created by Plus1XP on 18/04/2022.
//

import Foundation

extension Optional where Wrapped == String {
    private var _bound: String? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: String {
        get {
            return _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}
