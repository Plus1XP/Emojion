//
//  FeelingStats.swift
//  Emojion
//
//  Created by nabbit on 28/12/2022.
//

import SwiftUI

enum FeelingType: String, CaseIterable, Identifiable {
    case Angry
    case Bad
    case Disgusted
    case Fearful
    case Happy
    case Sad
    case Surprised
    
    var id: FeelingType {self}
}

struct FeelingData: Identifiable, Comparable {
    var id = UUID()
    var type: FeelingType
    var count: Int
    var color: Color
    var date: [Date]
    
    static func <(lhs: FeelingData, rhs: FeelingData) -> Bool {
        lhs.type.rawValue < rhs.type.rawValue
    }
}
