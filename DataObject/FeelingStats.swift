//
//  FeelingStats.swift
//  Emojion
//
//  Created by nabbit on 28/12/2022.
//

import Foundation

struct FeelingStats: Identifiable {
    var color: String
    var type: String
    var date: Date
    var count: Double
    var id = UUID()
}
