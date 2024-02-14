//
//  FeelingStats.swift
//  Emojion
//
//  Created by nabbit on 28/12/2022.
//

import SwiftUI

struct FeelingStats: Identifiable, Comparable {
    var color: String
    var type: String
    var date: Date
    var count: Int
    var id = UUID()
    
    static func <(lhs: FeelingStats, rhs: FeelingStats) -> Bool {
            lhs.type < rhs.type
        }
}

struct FeelingData: Identifiable, Comparable {
    var id = UUID()
    var type: String
    var count: Int
    var color: Color
    var date: [Date]
    
    static func <(lhs: FeelingData, rhs: FeelingData) -> Bool {
            lhs.type < rhs.type
        }
}
