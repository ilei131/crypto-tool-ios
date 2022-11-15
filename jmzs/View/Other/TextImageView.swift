//
//  TextImageView.swift
//  jmzs
//
//  Created by ilei on 2022/11/8.
//

import SwiftUI

struct TextImageView: View {
    var type = 1 //1 password 2 photo
    var body: some View {
        ZStack(alignment: .center) {
            if type == 1 {
                Image(systemName: "lock.shield")
                    .font(.system(size: 20, weight: .regular))
                    .padding(12)
                    .foregroundColor(Color(hexadecimal: "5366df"))
            } else {
                Image(systemName: "ellipsis.bubble")
                    .font(.system(size: 20, weight: .regular))
                    .padding(12)
                    .foregroundColor(Color(hexadecimal: "5366df"))
            }
        }
        .background(Color(hexadecimal: "F1F1F1"))
        .cornerRadius(6)
    }
    
    func titleFirstLetter(_ title: String) -> String {
        if title.isEmpty {
            return ""
        }
        let letter = (title as NSString).substring(with: NSMakeRange(0, 1))
        return letter as String
    }
}

struct TextImageView_Previews: PreviewProvider {
    static var previews: some View {
        TextImageView()
    }
}
