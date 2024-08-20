//
//  Confettiview.swift
//  Emojion
//
//  Created by nabbit on 20/08/2024.
//

import SwiftUI

struct ConfettiView: View {
    @State var animate = false
    @State var xSpeed = Double.random(in: 0.7...2)
    @State var zSpeed = Double.random(in: 1...2)
    @State var anchor = CGFloat.random(in: 0...1).rounded()
    
    var body: some View {
        Rectangle()
            .fill([Color.orange, Color.green, Color.blue, Color.red, Color.yellow].randomElement() ?? Color.green)
            .frame(width: 20, height: 20)
            .onAppear(perform: { animate = true })
            .rotation3DEffect(.degrees(animate ? 360 : 0), axis: (x: 1, y: 0, z: 0))
            .animation(Animation.linear(duration: xSpeed).repeatForever(autoreverses: false), value: animate)
            .rotation3DEffect(.degrees(animate ? 360 : 0), axis: (x: 0, y: 0, z: 1), anchor: UnitPoint(x: anchor, y: anchor))
            .animation(Animation.linear(duration: zSpeed).repeatForever(autoreverses: false), value: animate)
    }
}

#Preview {
    ConfettiView()
}
