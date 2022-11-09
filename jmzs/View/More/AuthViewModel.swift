//
//  AuthViewModel.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import Foundation
import Combine

class AuthViewModel: ObservableObject {
    
    var cancellableBiometricTask: AnyCancellable? = nil
    
    @Published var didAuthenticate = false
    var showAlert = false
    var alertMessage = String()
        
    func authenticate(){
        didAuthenticate = false
        showAlert = false
        alertMessage = ""
        cancellableBiometricTask = AuthUtlity.shared.authenticate()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.showAlert = true
                    self.alertMessage = error.description
                default: return
                }
            }) { _ in
                self.didAuthenticate = true
            }
    }
    
    deinit {
        cancellableBiometricTask = nil
    }
}
