//
//  MasterPwdView.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import SwiftUI
import SwiftUIX

struct MasterPwdView: View {
    @State private var pwd: String = ""
    @State private var vlidatePwd: String = ""
    @State private var showAlert = false
    @State private var isPresented = !DataManager.shared.reminder

    var body: some View {
        let title = "set_pwd".localized()
        Form {
            Section(header: Text("remember_pwd".localized())) {
                PwdTextField(text: $pwd,
                                label: "master_pwd".localized(),
                                isSecured: true)
                    .multilineTextAlignment(.leading)
                    .font(.title)
                PwdTextField(text: $vlidatePwd,
                                label: "confirm_pwd".localized(),
                                isSecured: true)
                    .multilineTextAlignment(.leading)
                    .font(.title)
            }
        }
        .navigationBarTitle(Text(title), displayMode:.inline)
        .navigationBarItems(trailing: doneNavItem)
        .alert(isPresented: $showAlert) {
            var content = Text("passwords_do_not_match".localized())
            if pwd.isEmpty {
                content = Text("master_pwd_tip".localized())
            }
            return Alert(title: Text("tip".localized()),
                         message: content,
                         dismissButton: .default(Text("ok".localized())))
        }
        .slideOverCard(isPresented: $isPresented, options: [.disableDrag, .disableDragToDismiss, .hideExitButton]) {
            TipView(show: $isPresented)
        }
    }
    
    var doneNavItem: some View {
        Button("done".localized(), action: {
            onDoneAction()
        })
        .font(Font.body.bold())
    }
    
    func onDoneAction() {
        if pwd.isEmpty || vlidatePwd.isEmpty || pwd != vlidatePwd {
            showAlert = true
        } else {
            DataManager.shared.update(password: pwd)
        }
    }
}

struct MasterPwdView_Previews: PreviewProvider {
    static var previews: some View {
        MasterPwdView()
    }
}

struct PwdTextField: View {
    /// The binding text for the text field.
    @Binding var text: String
    /// The label describing the text field.
    var label: String
    /// The placeholder for the text field.
    /// If `nil`, the label is used.
    var placeholder: String?
            
    var isPwd: Bool = false

    var isSecured: Bool = false
    
    var isFocused: Bool = false

    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
            CocoaTextField(placeholder ?? label, text: $text)
                .secureTextEntry(isSecured)
                .multilineTextAlignment(.leading)
                .font(.title)
                .padding(.top, 2)
        }
    }
}
