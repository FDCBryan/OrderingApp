//
//  SafariView.swift
//  OrderApp
//
//  Created by FDCI on 11/21/23.
//

import SwiftUI
import SafariServices


struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariViewController = SFSafariViewController(url: url)
        return safariViewController
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // Update the view controller
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SafariView(url: URL(string: "https://www.google.com")!)
    }
}
