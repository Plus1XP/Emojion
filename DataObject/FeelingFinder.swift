//
//  FeelingFinder.swift
//  Emojion
//
//  Created by Plus1XP on 23/04/2022.
//

import Foundation
import SwiftUI

struct FeelingWheel: Hashable, Identifiable {
    let id = UUID()
    var name: String
    var color: Color
    var secondaryFeelings: [FeelingWheel] = []
    var tertiaryFeelings: [FeelingWheel] = []
}
