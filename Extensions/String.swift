//
//  String.swift
//  Emojion
//
//  Created by Plus1XP on 18/04/2022.
//

import UIKit

extension String {
    var isSingleEmoji: Bool { count == 1 && containsEmoji }
    
    var containsEmoji: Bool { contains { $0.isEmoji } }
    
    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }
    
    var emojiString: String { emojis.map { String($0) }.reduce("", +) }
    
    var emojis: [Character] { filter { $0.isEmoji } }
    
    var emojiScalars: [UnicodeScalar] { filter { $0.isEmoji }.flatMap { $0.unicodeScalars } }
    
    func onlyEmoji() -> String {
        return self.filter({$0.isEmoji})
    }
    
//    Usage examples:-
//    let image      = "🤣".image()
//    let imageLarge = "🤣".image(fontSize:100)
//    let imageBlack = "🤣".image(fontSize:100, bgColor:.black)
//    let imageLong  = "🤣".image(fontSize:100, imageSize:CGSize(width:500,height:100))
    func ToImage(fontSize:CGFloat = 40, bgColor:UIColor = UIColor.clear, imageSize:CGSize? = nil) -> UIImage?
        {
            let font = UIFont.systemFont(ofSize: fontSize) // you can change your font size here
            let attributes = [NSAttributedString.Key.font: font]
            let imageSize = imageSize ?? self.size(withAttributes: attributes)

            UIGraphicsBeginImageContextWithOptions(imageSize, false, 0) //  begin image context
            bgColor.set()
            let rect = CGRect(origin: CGPoint(), size: imageSize) // set rect size
            UIRectFill(rect)
            self.draw(at: CGPoint.zero, withAttributes: [.font: font]) // draw text within rect
            let image = UIGraphicsGetImageFromCurrentImageContext() // create image from context
            UIGraphicsEndImageContext() //  end image context
            return image
        }
}
