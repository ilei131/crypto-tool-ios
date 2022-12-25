//
//  BigPicView.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI

import SwiftUI
import CoreData

struct BigPicView: View {
    
    @EnvironmentObject var vm: PicViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var context
    var fetchRequest: FetchRequest<BigPic>
    @State private var showShareSheet = false
    @State private var imageSize = CGSize.zero

    init(filter: UUID) {
        fetchRequest = FetchRequest<BigPic>(entity: BigPic.entity(), sortDescriptors: [], predicate:NSPredicate(format: "id = %@", filter as CVarArg))
    }
    
    var body: some View {
        GeometryReader { proxy in
            if fetchRequest.wrappedValue.count > 0 {
                if let image = UIImage(data: fetchRequest.wrappedValue.first!.data!) {
                    ZStack() {
                        ZoomableView(size: CGSize(width: proxy.size.width, height: proxy.size.width*image.size.height/image.size.width), min: 1.0, max: 3.0, showsIndicators: true) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                        }
                        .gesture(TapGesture.init(count: 1).onEnded {
                            onCancelAction()
                        })
                        VStack {
                            Spacer()
                            HStack {
                                Button(action: {
                                    onCancelAction()
                                }, label: {
                                    Image(systemName: "arrow.left.circle")
                                        .imageScale(.large)
                                })
                                .padding()
                                Spacer()
                                Button(action: shareAction) {
                                    Image(systemName: "square.and.arrow.up")
                                        .imageScale(.large)
                                }
                                .padding()
                            }
                            .padding(.bottom, 30)
                        }
                    }
                    .shareSheet(items: [UIImage(data: fetchRequest.wrappedValue.first!.data!)!],
                                isPresented: $showShareSheet,
                                excludedActivityTypes:nil)
                }
            } else {
                EmptyView()
            }
        }
    }
    
    func shareAction() {
        showShareSheet = true
    }
    
    func onCancelAction() {
        //withAnimation(.easeOut)  {
            vm.showImageViewer.toggle()
        //}
    }
}
