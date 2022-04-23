//
//  StarRatingView.swift
//  Emojion
//
//  Created by Plus1XP on 19/04/2022.
//

import SwiftUI

struct StarRatingView: View {
    @Binding var starRating : Int64
    @Binding var hasUpdatedStarRating: Bool
    @Binding var canEditStarRating: Bool
    var starFontSize: CGFloat
    var starSpacing: CGFloat?
        
    init(_ starRating: Binding<Int64>, _ starFontSize: CGFloat) {
        self._starRating = starRating
        self.starFontSize = starFontSize
        self.starSpacing = nil
        self._hasUpdatedStarRating = Binding.constant(false)
        self._canEditStarRating = Binding.constant(false)
    }
    
    init(_ starRating: Binding<Int64>, _ starFontSize: CGFloat, _ starSpacing: CGFloat) {
        self._starRating = starRating
        self.starFontSize = starFontSize
        self.starSpacing = starSpacing
        self._hasUpdatedStarRating = Binding.constant(false)
        self._canEditStarRating = Binding.constant(false)
    }
    
    init(_ starRating: Binding<Int64>, _ starFontSize: CGFloat, _ canEditStarRating: Binding<Bool>) {
        self._starRating = starRating
        self.starFontSize = starFontSize
        self.starSpacing = nil
        self._hasUpdatedStarRating = Binding.constant(false)
        self._canEditStarRating = canEditStarRating
    }
    
    init(_ starRating: Binding<Int64>, _ starFontSize: CGFloat, _ hasUpdatedStarRating: Binding<Bool>, _ canEditStarRating: Binding<Bool>) {
        self._starRating = starRating
        self.starFontSize = starFontSize
        self.starSpacing = nil
        self._hasUpdatedStarRating = hasUpdatedStarRating
        self._canEditStarRating = canEditStarRating
    }


    var body: some View {
        HStack(spacing: starSpacing) {
            ForEach(0..<5) { star in
                let starEmoji = "⭐️".ToImage(fontSize: starFontSize)
                Image(uiImage: starEmoji!)
//                    .resizable()
//                    .frame(width: 25, height: 25)
//                    .border(.green)
                    .opacity(self.starRating >= Int64(star) ? 1.0 : 0.1)
                    .onTapGesture {
                        self.starRating = Int64(star)
                        hasUpdatedStarRating.toggle()
                        debugPrint("Rating has changed: \(starRating + 1)")
                    }
            }
            
        }
        .disabled(!canEditStarRating)
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingView(.constant(3), 25)
    }
}

