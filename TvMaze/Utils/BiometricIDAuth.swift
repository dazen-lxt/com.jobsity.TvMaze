//
//  BiometricIDAuth.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import LocalAuthentication

class BiometricIDAuth {
    let context = LAContext()

    func canEvaluatePolicy() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    func evaluatePolicy(completion: @escaping () -> Void) {
        Task {
            do {
                try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Log in with biometrics")
                completion()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
