//
//  OrderButton.swift
//  OrderApp
//
//  Created by FDCI on 11/11/23.
//

import SwiftUI

struct OrderButton: View {
    var text : LocalizedStringKey
    var body: some View {
        Text(text)
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 260, height: 50)
            .background(.brandPrimary)
            .cornerRadius(10)
            .foregroundColor(.white)
    }
}

#Preview {
    OrderButton(text: "sample Text")
}
