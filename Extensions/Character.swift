//
//  Character.swift
//  Emojion
//
//  Created by Plus1XP on 22/04/2022.
//

import Foundation

extension Character {
    var isEmoji: Bool {
        guard let scalar = unicodeScalars.first else { return false }
        return scalar.properties.isEmoji && (scalar.value > 0x238C || unicodeScalars.count > 1)
    }
}
