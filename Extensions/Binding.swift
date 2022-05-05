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

extension Optional where Wrapped == [Int] {
    private var _bound: [Int]? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: [Int] {
        get {
            return _bound ?? [0,0,0]
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}
