//
//  AuthenticationView.swift
//  Emojion
//
//  Created by nabbit on 21/12/2023.
//

import SwiftUI
import CoreData

struct AuthenticationView: View {
    @EnvironmentObject var biometricStore: BiometricStore

    var body: some View {
        ZStack {
            if self.biometricStore.isFaceidEnabled && self.biometricStore.isAppLocked {
                LoginView()
            } else {
                ContentView()
            }
        }
        .onAppear {
            debugPrint("1st Launch")
            self.biometricStore.GetCurrentBiometricsSavedState()
            if self.biometricStore.isFaceidEnabled {
                self.biometricStore.ValidateBiometrics()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            debugPrint("Moving to the background!")
            if self.biometricStore.isFaceidEnabled && self.biometricStore.isAutoLockEnabled {
                self.biometricStore.isAppLocked = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            debugPrint("Moving to the foreground!")
            if self.biometricStore.isFaceidEnabled && self.biometricStore.isAutoLockEnabled {
                self.biometricStore.ValidateBiometrics()
            }
        }
    }
}

#Preview {
    AuthenticationView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(BiometricStore())
}

