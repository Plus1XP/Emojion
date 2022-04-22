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
    
    
    init(_ starRating: Binding<Int64>, _ starFontSize: CGFloat) {
        self._starRating = starRating
        self.starFontSize = starFontSize
        self._hasUpdatedStarRating = Binding.constant(false)
        self._canEditStarRating = Binding.constant(false)
    }
    
    init(_ starRating: Binding<Int64>, _ starFontSize: CGFloat, _ canEditStarRating: Binding<Bool>) {
        self._starRating = starRating
        self.starFontSize = starFontSize
        self._hasUpdatedStarRating = Binding.constant(false)
        self._canEditStarRating = canEditStarRating
    }
    
    init(_ starRating: Binding<Int64>, _ starFontSize: CGFloat, _ hasUpdatedStarRating: Binding<Bool>, _ canEditStarRating: Binding<Bool>) {
        self._starRating = starRating
        self.starFontSize = starFontSize
        self._hasUpdatedStarRating = hasUpdatedStarRating
        self._canEditStarRating = canEditStarRating
    }


    var body: some View {
        HStack {
            ForEach(0..<5) { star in
                let starEmoji = "⭐️".ToImage(fontSize: starFontSize)
                Image(uiImage: starEmoji!)
//                Image(uiImage: "⭐️".textToImage()!)
//                    .resizable()
//                    .frame(width: 25, height: 25)
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
    
//    let ratingsArray: [Double]
//    let color: Color
//    @Binding var rating: Double
//
//    init(rating: Binding<Double>, maxRating: Int = 5, starColor: Color = .yellow) {
//        _rating = rating
//        ratingsArray = Array(stride(from: 0.0, through: Double(max(1, maxRating)), by: 0.5))
//        color = starColor
//    }
//
//    var body: some View {
//        VStack {
//            HStack(spacing: 0) {
//                ForEach(ratingsArray, id: \.self) { ratingElement in
//                    if ratingElement > 0 {
//                        if Int(exactly: ratingElement) != nil && ratingElement <= rating {
//                            Image(systemName: "star.fill")
//                                .foregroundColor(color)
//                        } else if Int(exactly: ratingElement) == nil && ratingElement == rating {
//                            Image(systemName: "star.leadinghalf.fill")
//                                .foregroundColor(color)
//                        } else if Int(exactly: ratingElement) != nil && rating + 0.5 != ratingElement {
//                            Image(systemName: "star")
//                                .foregroundColor(color)
//                        }
//                    }
//                }
//            }
//            .overlay(
//                Slider(value: $rating, in: 0.0...ratingsArray.last!, step: 0.5)
//                    .tint(.clear)
//                    .opacity(0.1)
//            )
//        }
//        .onAppear {
//            rating = Int(exactly: rating) != nil ? rating : Double(Int(rating)) + 0.5
//        }
//    }
//}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingView(.constant(3), 25)
    }
}

