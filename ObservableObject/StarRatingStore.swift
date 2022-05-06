//
//  StarRatingStore.swift
//  Emojion
//
//  Created by Plus1XP on 19/04/2022.
//

import Foundation
import SwiftUI

class StarRatingStore: ObservableObject {
    
    @Published var starRating: Int64 = 0
    @Published var starFontSize: CGFloat = 25
    @Published var hasUpdatedStarRating: Bool = false
    @Published var canEditStarRating: Bool = false
    @Published var hasEntrySaved: Bool = false
    @Published var originalStarRating: Int64 = 5
    
//    init() {
//        fetchEntries()
//    }
    
//    func UpdateEntryRating(entry: Entry) {
//        rating = entry.rating
//    }
//    
//    func UpdateEntryRating2(entry: Entry) -> Int64 {
//        rating = entry.rating
//    }
    
//        .onAppear {
//            hasEntrySaved = false
//            originalStarRating = updateRating.wrappedValue
//            debugPrint("Backup star rating to \(originalStarRating + 1) from \(updateRating.wrappedValue + 1)")
//        }
//        .onDisappear {
//            if !hasEntrySaved {
//                updateRating.wrappedValue = originalStarRating
//                debugPrint("Resore star rating to: \(updateRating.wrappedValue + 1) from \(originalStarRating + 1)")
//            }
//        }
    
}
