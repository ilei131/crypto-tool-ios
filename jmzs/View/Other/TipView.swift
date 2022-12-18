//
//  TipView.swift
//  jmzs
//
//  Created by ilei on 2022/11/7.
//

import SwiftUI

struct TipView: View {
    @Binding var show: Bool
    @State private var showSheet = false

    var body: some View {
        VStack(alignment: .leading) {
            Text("reminder".localized())
                .font(.system(size: 20, weight: .bold))
                .padding(.bottom, 20)
            HStack() {
                
                Text("reminder_b".localized())
                    .font(.system(size: 16))
                    .foregroundColor(Color(hexadecimal: "434343"))
                + Text("reminder_m".localized())
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color("titleColor"))
                + Text("reminder_e".localized())
                    .font(.system(size: 16))
                    .foregroundColor(Color(hexadecimal: "434343"))
            }
            .onTapGesture {
                showSheet = true
            }
            HStack{
                Text("agree".localized())
                    .myButtonStyle()
                    .onTapGesture {
                        DataManager.shared.update(reminder: true)
                        show = false
                    }
                    .cornerRadius(8)
                Spacer()
                Text("disagree".localized())
                    .myButtonStyle()
                    .onTapGesture {
                        DataManager.shared.update(reminder: true)
                        show = false
                    }
                    .cornerRadius(8)
            }
            .padding(.top, 10)
        }
        .sheet(isPresented: $showSheet) {
            createForm
        }
    }
    
    var createForm: some View {
        return NavigationView {
            PolicyView()
        }
    }
}

struct TipView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
