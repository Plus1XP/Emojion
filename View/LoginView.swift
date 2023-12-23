//
//  LoginView.swift
//  Emojion
//
//  Created by nabbit on 21/12/2023.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var biometricStore: BiometricStore

    var body: some View {
        Button(action: {
            debugPrint("authenticate button Pushed")
            self.biometricStore.ValidateBiometrics()
        }, label: {
            let biometric = BiometricService()
            VStack {
                Spacer()
                Text("\(Text(biometric.setBiometricIcon()))")
                    .foregroundColor(Color.primary)
                    .font(.system(size: 60))
                Spacer()
                Text("Tap to unlock")
                    .font(.headline)
                    .padding(.bottom)
            }
            .frame(width: 150, height: 150)
        })
        .buttonStyle(.bordered)
    }
}

#Preview {
    let biometricStore = BiometricStore()
    return LoginView(biometricStore: biometricStore)
}
