//
//  StarRatingView.swift
//  Emojion
//
//  Created by Plus1XP on 19/04/2022.
//

import SwiftUI

struct StarRatingView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State var animate: Bool = false
    @Binding var starRating: Int64
    @Binding var canEditStarRating: Bool
    var starFontSize: CGFloat
    var starSpacing: CGFloat?
        
    init(_ starRating: Binding<Int64>, _ starFontSize: CGFloat) {
        self._starRating = starRating
        self.starFontSize = starFontSize
        self.starSpacing = nil
        self._canEditStarRating = Binding.constant(false)
    }
    
    init(_ starRating: Binding<Int64>, _ starFontSize: CGFloat, _ starSpacing: CGFloat) {
        self._starRating = starRating
        self.starFontSize = starFontSize
        self.starSpacing = starSpacing
        self._canEditStarRating = Binding.constant(false)
    }
    
    init(_ starRating: Binding<Int64>, _ starFontSize: CGFloat, _ canEditStarRating: Binding<Bool>) {
        self._starRating = starRating
        self.starFontSize = starFontSize
        self.starSpacing = nil
        self._canEditStarRating = canEditStarRating
    }

    var body: some View {
        HStack(spacing: starSpacing) {
            ForEach(0..<5) { star in
                let starEmoji = "⭐️".ToImage(fontSize: starFontSize)
                Image(uiImage: starEmoji!)
                    .opacity(getItemQuantityWithOffset(quantity: self.starRating) >= Int64(star) ? 1.0 : 0.15)
                    .onTapGesture {
                        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                        impactFeedback.impactOccurred()
                        self.animate.toggle()
                        if !(star == 0 && self.starRating == 1) {
                            self.starRating = setItemQuantityWithOffset(quantity: Int64(star))
                        } else {
                            self.starRating = 0
                        }
                        debugPrint("Rating has changed: \(starRating)")
                    }
                    .shake($animate) {
                        debugPrint("Execute Shake Animation")
                    }
//                    .background(self.starRating == 0 ? Circle()
//                        .fill(Color.setFieldBackgroundColor(colorScheme: colorScheme).opacity(1))
//                        .frame(width: 30, height: 30) : nil
//                    )
            }
            
        }
        .disabled(!canEditStarRating)
    }
}

private func getItemQuantityWithOffset(quantity: Int64) -> Int64 {
    return quantity - 1
}

private func setItemQuantityWithOffset(quantity: Int64) -> Int64 {
    return quantity + 1
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingView(.constant(Entry.MockEntry.rating), 25)
    }
}

