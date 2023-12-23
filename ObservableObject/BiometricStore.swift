//
//  BiometricStore.swift
//  Emojion
//
//  Created by nabbit on 21/12/2023.
//

import SwiftUI

class BiometricStore: ObservableObject {
    @Published var authenticationState: AuthenticationState = AuthenticationState.waiting
    @Published var isFaceidEnabled: Bool = false {
        didSet {
            isFaceidEnabledSavedState = isFaceidEnabled
            debugPrint("Get FaceID Saved State from AppStorage")
        }
    }
    @Published var isAutoLockEnabled: Bool = false {
        didSet {
            isAutoLockEnabledSavedState = isAutoLockEnabled
            debugPrint("Get AutoLock Saved State from AppStorage")
        }
    }
    @Published var isAppLocked: Bool = true {
        didSet {
            debugPrint("isAppLocked State is: \(isAppLocked.description)")
        }
    }
    @AppStorage("isFaceidEnabled") var isFaceidEnabledSavedState: Bool = false
    @AppStorage("isAutoLockEnabled") var isAutoLockEnabledSavedState: Bool = false
    
    func ValidateBiometrics() -> Void {
        authenticationState = .waiting
        let biometric = BiometricService()
        biometric.canEvaluate { (canEvaluate, _, canEvaluateError) in
            guard canEvaluate else {
                debugPrint(canEvaluateError?.localizedDescription ?? "Authentication Failure, No Biometrics or Password Set")
                authenticationState = .failure
                return
            }
            biometric.evaluate { (success, error) in
                guard success else {
                    debugPrint(error?.localizedDescription ?? "Authentication Error, Incorrect Biometrics or Password, User Cancelled")
                    self.authenticationState = .error
                    return
                }
                debugPrint("Authentication Successful")
                self.authenticationState = .successful
                self.isAppLocked = false
            }
        }
    }
    
    func GetCurrentBiometricsSavedState() -> Void {
        isFaceidEnabled = isFaceidEnabledSavedState
        isAutoLockEnabled = isAutoLockEnabledSavedState
    }
    
    func SetBlur(isLocked: Bool) -> CGFloat {
        switch isLocked {
        case false:
            return 0.0
        case true:
            return 20.0
        }
    }
}
