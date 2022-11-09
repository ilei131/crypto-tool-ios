//
//  AuthView.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI
import LocalAuthentication

struct AuthView: View {
    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        ZStack {
            Color("primary").edgesIgnoringSafeArea(.all)
            VStack {
                if viewModel.didAuthenticate {
                    HomeView()
                } else {
                    Spacer()
                    Image("icon_no_bg")
                        .resizable()
                        .scaledToFit()
                        .frame(CGSize(width: 150, height: 150))
                    VStack(spacing: 16) {
                        Text("app is locked".localized())
                            .foregroundColor(Color("titleColor"))
                            .padding(.top, 20)
                        Button(action: { viewModel.authenticate() }, label: {
                            HStack {
                                Spacer()
                                Text("unlock".localized())
                                    .tracking(1.25)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        })
                        .frame(height: 25)
                        .padding().background(Color(hexadecimal: "5366df"))
                        .cornerRadius(4)
                        .foregroundColor(Color("titleColor"))
                        .accentColor(Color("titleColor"))
                    }.padding(.horizontal)
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .onAppear(perform: {
            viewModel.authenticate()
        })
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
