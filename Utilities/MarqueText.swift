//
//  MarqueText.swift
//  Emojion
//
//  Created by nabbit on 09/01/2024.
//

import SwiftUI

struct MarqueeText : View {
    @State var text = ""
    @State private var animate = false
    private let animationOne = Animation.linear(duration: 10).delay(0).repeatForever(autoreverses: false)
    
    var body : some View {
        let stringWidth = text.widthOfString(usingFont: UIFont.systemFont(ofSize: 15))
        return ZStack {
            GeometryReader { geometry in
                Text(self.text).lineLimit(7)
                    .font(.subheadline)
//                    .offset(x: self.animate ? -stringWidth * 2 : 0)
                    .offset(y: self.animate ? -stringWidth * 0.5 : 0)
                    .animation(self.animationOne)
                    .onAppear() {
                        if geometry.size.width < stringWidth {
                            self.animate = true
                        }
                    }
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                
                Text(self.text).lineLimit(7)
                    .font(.subheadline)
//                    .offset(x: self.animate ? 0 : stringWidth * 2)
                    .offset(y: self.animate ? 0 : stringWidth * 0.5)
                    .animation(self.animationOne)
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
}
