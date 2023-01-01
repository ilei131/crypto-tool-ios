//
//  ScannerView.swift
//  jmzs
//
//  Created by ilei on 2022/12/31.
//

import Foundation
import SwiftUI

struct ScannerView: View{
    @Environment(\.presentationMode) var presentationMode
    @State var scannedObject: ScannedObject?
    
    @ObservedObject var scannerViewModel = ScannerViewModel()
    
    var body: some View {
        //NavigationView {
            ZStack(alignment: .center) {
                if self.scannedObject != nil {
                    ScannerResultView(scannedObject: self.scannedObject!,
                                      parentView: self,
                                      copyDataByDefault: self.scannerViewModel.checkIfCopyByDefault(),
                                      browseByDefault: self.scannerViewModel.checkIfBrowseByDefault())
                    .offset(x:0, y:-60)
                    
                } else{
                    self.scannerSheet
                }
            }
            .navigationBarTitle((self.scannedObject == nil) ? "scanner.scanning" : "scanner.scanning.result", displayMode: .inline)
            //.navigationBarItems(leading: backNavItem)
        //}
    }
    
    var backNavItem: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "xmark")
                .imageScale(.large)
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 20))
        }
    }
    
    var scannerSheet : some View {
        ZStack(alignment: .center){
            GeometryReader { metrics in
                VStack(){
                    Spacer()
                    HStack(){
                        Spacer()
                        Image("frame")
                            .resizable()
                            .scaledToFit()
                            .width(metrics.size.width * 0.7)
                            .height(metrics.size.width * 0.7)
                        Spacer()
                    }
                    Spacer()
                }
            }
            .zIndex(10)

            ZStack(alignment: .top) {
                Color.clear
                Text("scanner.scanning.info")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(Color.white)
                    .font(Font.custom(Fonts.ExtraBold, size: 16))
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                
            }.zIndex(40)
                .padding(20)
        
            if self.scannerViewModel.flashOn{
                Image("flashOn")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32, alignment: .topLeading)
                    .zIndex(20)
                    .onTapGesture {
                        print("Flash is ON")
                        self.scannerViewModel.toggleTorch(on: false)
                        
                }
            }else{
                Image("flashOff")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32, alignment: .topLeading)
                    .zIndex(20)
                    .onTapGesture {
                        print("Flash is OFF")
                        self.scannerViewModel.toggleTorch(on: true)
                        
                }
            }
            
            CodeScannerView(
                codeTypes: [.qr],
                simulatedData: "Sample read QR CODE",
                vibrate: self.scannerViewModel.checkIfVibrate(),
                playSound: self.scannerViewModel.checkIfBeepSound(),
                completion: { result in
                    if case let .success(code) = result {
                        
                        let scannedObject = ScannedObject(data: code, scanDate: Date().toString(format: DateFormat.yyyy_mm_dd_hh_ss), type: code.verifyUrl() ? .url : .text)
                        
                        if self.scannerViewModel.checkIfSaveToRecentList(){
                            self.scannerViewModel.addToRecentList(scannedObject: scannedObject, removeDuplicate: self.scannerViewModel.checkIfRemoveDuplicate())
                        }
                        
                        self.scannedObject = scannedObject
                    }
                }
            )
        }
    }
}
