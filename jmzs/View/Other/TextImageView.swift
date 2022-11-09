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
                    .font(.system(size: 16, weight: .regular))
                    .padding(14)
                    .foregroundColor(.white)
            } else if type == 2 {
                Image(systemName: "photo")
                    .resizable(true)
                    .scaledToFit()
                    .frame(width: 30, height: 30, alignment: .center)
                    .foregroundColor(.white)
            } else {
                Image(systemName: "ellipsis.bubble")
                    .font(.system(size: 16, weight: .regular))
                    .padding(14)
                    .foregroundColor(.white)
            }
        }
//        .frame(width: 54, height: 54, alignment: .center)
        .background(Color(hexadecimal: "5366df"))
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
