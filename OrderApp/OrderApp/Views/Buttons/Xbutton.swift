//
//  Xbutton.swift
//  OrderApp
//
//  Created by FDCI on 11/11/23.
//

import SwiftUI

struct Xbutton: View {
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 30,height: 30)
                .foregroundColor(.white)
                .opacity(0.6)
            Image(systemName: "xmark")
                .imageScale(.small)
                .frame(width: 50,height: 50)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    Xbutton()
}
