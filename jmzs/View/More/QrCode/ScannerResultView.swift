//
//  ScannerResultView.swift
//  jmzs
//
//  Created by ilei on 2022/12/31.
//

import Foundation
import SwiftUI

struct ScannerResultView: View {
    
    var scannedObject: ScannedObject
    var parentView: ScannerView
    var copyDataByDefault: Bool
    var browseByDefault: Bool
    
    @State private var showingAlert = false
    @State private var alertMsg = ""
    @State private var showBrowseButton = false
    @State private var showShareSheet = false

    var body: some View{
        VStack{
            Text("scanner.scanning.result.info".localized())
                .frame(maxWidth: .infinity, alignment: .top)
                .foregroundColor(Colors.Blackish)
                .font(Font.custom(Fonts.Regular, size: 15))
                .padding(EdgeInsets(top: 4, leading: 30, bottom: 4, trailing: 30))
                .multilineTextAlignment(.center)
            VStack{
                HStack{
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 34, height: 34)
                        .foregroundColor(.white)
                        .onTapGesture {
                            self.parentView.scannedObject = nil
                    }
                    Spacer()
                    Text(scannedObject.scanDate!)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color.white)
                        .font(Font.custom(Fonts.ExtraBold, size: 15))
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    
                }.padding(20)

                Image((scannedObject.type == .url) ? "url" : "text")
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                
                Text(scannedObject.data)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.white)
                    .font(Font.custom(Fonts.Regular, size: 20))
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                    .minimumScaleFactor(0.5)
                
                HStack(spacing:24){
                    if self.showBrowseButton{
                        Image(systemName: "safari")
                            .imageScale(.large)
                            .foregroundColor(.white)
                            .onTapGesture {
                                print("Browse button was tapped")
                                if let url = URL(string: self.scannedObject.data){
                                    UIApplication.shared.open(url)
                                }
                        }
                    }
                    
                    Image(systemName: "square.and.arrow.up")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .onTapGesture {
                            print("Share button was tapped")
                            showShareSheet = true
                            //self.scannedObject.data.actionSheet()
                    }
                    
                    Image(systemName: "doc.on.doc")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .onTapGesture {
                            let pasteboard = UIPasteboard.general
                            pasteboard.string = self.scannedObject.data
                            self.alertMsg = "alert.msg.copy.success".localized()
                            self.showingAlert = true
                    }
                    
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }.background(Colors.Main)
                .cornerRadius(20)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .alert(isPresented: $showingAlert){
                    Alert(title: Text("alert.title.success".localized()), message: Text(self.alertMsg), dismissButton: .default(Text("ok".localized())))
            }
            .onAppear(){
                if self.scannedObject.data.isValidURL(){
                    self.showBrowseButton = true
                }
                if self.copyDataByDefault{
                    let pasteboard = UIPasteboard.general
                    pasteboard.string = self.scannedObject.data
                }
                if self.browseByDefault{
                    if let url = URL(string: self.scannedObject.data){
                        UIApplication.shared.open(url)
                    }
                }
            }
            .sheet(isPresented: $showShareSheet) {
                TextShareSheet(text: self.scannedObject.data)
            }
        }
    }
}
