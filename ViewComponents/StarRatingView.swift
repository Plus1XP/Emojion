//
//  StarRatingView.swift
//  Emojion
//
//  Created by Plus1XP on 19/04/2022.
//

import SwiftUI

struct StarRatingView: View {
    @State var refreshView: Bool = false
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
//                    .resizable()
//                    .frame(width: 25, height: 25)
//                    .border(.green)
                    .opacity(self.starRating >= Int64(star) ? 1.0 : 0.1)
                    .onTapGesture {
                        self.starRating = Int64(star)
                        NotificationCenter.default.post(name: Notification.Name("RefreshStarRatingView"), object: nil)
                        debugPrint("StarRatingView: StarRatingView Refreshed")
                        refreshView.toggle()
                        debugPrint("Rating has changed: \(starRating + 1)")
                    }
            }
            
        }
        .disabled(!canEditStarRating)
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingView(.constant(Entry.MockEntry.rating), 25)
    }
}

