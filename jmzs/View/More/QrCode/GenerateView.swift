//
//  GenerateView.swift
//  jmzs
//
//  Created by ilei on 2022/12/31.
//
import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins
import LinkPresentation

struct GenerateView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var data = ""
    @State private var showShareSheet = false
    @State private var showingAlert = false
    @State private var alertMsg = ""
    @State private var clipboardValue = ""
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View{
        
        //NavigationView {
            
            VStack {
                
                Text("generator.info".localized())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(Colors.Blackish)
                    .font(Font.custom(Fonts.Light, size: 16))
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 20))
                
                
                Text("generator.info.share".localized())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(Colors.Blackish)
                    .font(Font.custom(Fonts.ExtraBold, size: 16))
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
                
                
                TextField("generator.input.placeholder".localized(), text: $data)
                    .font(Font.custom(Fonts.ExtraBold, size: 12))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                
                
                Image(uiImage: self.generateQRCode(from: self.data))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200 ,height: 200)
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                    .onTapGesture {
                        //Trigger to show share action sheet
                        hideKeyboard()
                        self.showShareSheet = true
                        
                }
                .shareSheet(items: [self.generateQRCode(from: self.data)],
                            isPresented: $showShareSheet,
                            excludedActivityTypes:nil)
                
                Spacer()
                    
                    .onAppear{
                        
                        //Check if any data exists on clipboard
                        if let value = UIPasteboard.general.string {
                            self.clipboardValue = value
                            let part1 = "generator.info.clipboard.part1".localized();
                            let part2 = "generator.info.clipboard.part2".localized()
                            self.alertMsg = part1 + value + part2
                            self.showingAlert = true
                        }
                }
                .alert(isPresented: $showingAlert){
                    
                    Alert(title: Text("tip".localized()), message: Text(self.alertMsg), primaryButton: .destructive(Text("generate".localized())) {
                        self.data = self.clipboardValue
                    }, secondaryButton: .destructive(Text("cancel".localized())))
                }
                
            }
            .onTapGesture {
                hideKeyboard()
            }
            .navigationBarItems(leading: backNavItem)
            //.navigationBarTitle("generator.button.generate".localized())
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
    
    /**
     Generates QR code with given string
     
     - Parameter string: String data to generate QR.
     
     - Returns: UIImage.
     */
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            let scaledQrImage = outputImage.transformed(by: transform)
            
            if let cgimg = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
}
