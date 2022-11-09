//
//  Manager.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import SwiftUI

public struct Manager {
    @available(iOSApplicationExtension, unavailable)
    public static func present<Content:View>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, options: SOCOptions = SOCOptions(), style: UIUserInterfaceStyle = .unspecified, @ViewBuilder content: @escaping () -> Content) {
        let rootCard = SlideOverCard(isPresented: isPresented, onDismiss: {
            dismiss(isPresented: isPresented)
        }, options: options, content: content)
        
        let controller = UIHostingController(rootView: rootCard)
        controller.view.backgroundColor = .clear
        controller.modalPresentationStyle = .overFullScreen
        controller.overrideUserInterfaceStyle = style
        
        UIApplication.shared.windows.first?.rootViewController?.present(controller, animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            withAnimation {
                isPresented.wrappedValue = true
            }
        }
    }
    
    @available(iOSApplicationExtension, unavailable)
    public static func dismiss(isPresented: Binding<Bool>) {
        withAnimation {
            isPresented.wrappedValue = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: false)
        }
    }
}
