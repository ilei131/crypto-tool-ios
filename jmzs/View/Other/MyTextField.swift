//
//  MyTextField.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI
import SwiftUIX

struct MyTextField: View {
    var isEdit: Bool = false
    @Binding var text: String
    var label: String
    var placeholder: String?
    var content: UITextContentType?
    var onEditingChanged: ((Bool) -> Void)?
    var isPwd: Bool = false
    @State private var isSecured: Bool = true
    @Binding var isPresentingToast: Bool

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.caption)
                .foregroundColor(Self.labelColor)
            if isPwd {
                HStack() {
                    if isSecured || isEdit {
                        SecureField(placeholder ?? label, text: $text)
                            .multilineTextAlignment(.leading)
                            .padding(.top, Self.topPadding)
                            .textContentType(content)
                            .font(.body)
                            .disabled(!isEdit)
                    } else {
                        CocoaTextField(placeholder ?? label, text: $text, onEditingChanged: onEditingChanged ?? { _ in })
                            .multilineTextAlignment(.leading)
                            .padding(.top, Self.topPadding)
                            .textContentType(content)
                            .font(.body)
                            .disabled(!isEdit)
                    }
                    if !isEdit {
                        HStack {
                            Button(action: {}) {
                                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                                    .foregroundColor(.black)
                            }
                            .highPriorityGesture(TapGesture().onEnded {
                                isSecured.toggle()
                            })
                            Button(action: {}) {
                                Image(systemName: "doc.on.doc")
                                    .foregroundColor(.black)
                            }
                            .highPriorityGesture(TapGesture().onEnded {
                                UIPasteboard.general.string = text
                                isPresentingToast = true
                            })
                        }
                    }
                }
            } else {
                HStack {
                    CocoaTextField(placeholder ?? label, text: $text, onEditingChanged: onEditingChanged ?? { _ in })
                        .multilineTextAlignment(.leading)
                        .padding(.top, Self.topPadding)
                        .textContentType(content)
                        .font(.body)
                        .disabled(!isEdit)
                    if !isEdit {
                        Button(action: {}) {
                            Image(systemName: "doc.on.doc")
                                .foregroundColor(.black)
                        }
                        .highPriorityGesture(TapGesture().onEnded {
                            UIPasteboard.general.string = text
                            isPresentingToast = true
                        })
                    }
                }
            }
        }
    }
}

extension MyTextField {
    static let topPadding: CGFloat = 4
    static let labelColor: Color = .secondary
}

struct MyTextField_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
