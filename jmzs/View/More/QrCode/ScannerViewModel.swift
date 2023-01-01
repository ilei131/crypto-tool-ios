//
//  ScannerViewModel.swift
//  jmzs
//
//  Created by ilei on 2023/1/1.
//

import Foundation
import SwiftUI
import AVFoundation

class ScannerViewModel: ObservableObject {
    
    @Published var recentList: [ScannedObject] = []
    @Published var flashOn: Bool = false

    
    /**
     Appends recent item to UserDefaults
     
     - Returns: void
     */
    func addToRecentList(scannedObject: ScannedObject, removeDuplicate: Bool){
            
//        if let historyList = Defaults.historyList {
//
//            if removeDuplicate && (historyList.filter{$0.data == scannedObject.data}.count > 0){
//                return
//            }
//
//            self.recentList = historyList
//            self.recentList.append(scannedObject)
//            Defaults.historyList?.append(scannedObject)
//
//        }else{
//            self.recentList = [scannedObject]
//            Defaults.historyList = [scannedObject]
//        }
    }
    
    
    func checkIfVibrate() -> Bool{
        return true//Defaults.vibrate
    }
    
    func checkIfBeepSound() -> Bool{
        return false//Defaults.beepSound
    }
    
    func checkIfCopyByDefault() -> Bool{
        return true//Defaults.copyResultToClipboard
    }
    
    func checkIfBrowseByDefault() -> Bool{
        return false//Defaults.scanAndBrowser
    }
    
    func checkIfSaveToRecentList() -> Bool{
        return false//Defaults.saveToHistory
    }
    
    func checkIfRemoveDuplicate() -> Bool{
        return false//Defaults.disableDuplicates
    }
    
    
    /**
    Toggles torch
     
    - Returns: void
    */
    func toggleTorch(on: Bool) {
        guard
            let device = AVCaptureDevice.default(for: AVMediaType.video),
            device.hasTorch
        else { return }

        do {
            try device.lockForConfiguration()
            device.torchMode = on ? .on : .off
            device.unlockForConfiguration()
            self.flashOn = on
        } catch {
            print("Torch could not be used")
        }
    }

}
