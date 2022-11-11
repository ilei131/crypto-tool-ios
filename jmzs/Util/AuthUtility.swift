//
//  AuthUtility.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import Foundation
import Combine
import LocalAuthentication

struct AuthError: LocalizedError {
    
    var description: String
    
    init(description: String){
        self.description = description
    }
    
    init(error: Error){
        self.description = error.localizedDescription
    }
    
    var errorDescription: String?{
        return description
    }
}

class AuthUtlity {
    
    static let shared = AuthUtlity()
    private init(){}
    
    public func authenticate() -> Future<Bool, AuthError> {
        Future { promise in
            
            func handleReply(success: Bool, error: Error?) -> Void {
                if let error = error {
                    return promise(
                        .failure(AuthError(error: error))
                    )
                }
                
                promise(.success(success))
            }
            
            let context = LAContext()
            var error: NSError?
            let reason = "please authenticate yourself".localized()
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply: handleReply)
            } else if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason, reply: handleReply)
            } else{
                let error = AuthError(description: "something went wrong".localized())
                promise(.failure(error))
            }
        }
    }
}
