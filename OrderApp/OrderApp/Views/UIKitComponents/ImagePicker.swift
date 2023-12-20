//
//  ImagePicker.swift
//  OrderApp
//
//  Created by FDCI on 11/23/23.
//

import Foundation
import UIKit
import SwiftUI

struct ImagePicker : UIViewControllerRepresentable {
    @Binding var SelectedImage: UIImage?
    @Binding var isPickerShowing:Bool
    @Binding var hasPicked:Bool
    
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
    
        return imagePicker
    }
    
    func makeCoordinator() -> Coordinator {
        return  Coordinator(self)
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}


class Coordinator: NSObject, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    var parent: ImagePicker
    init(_ picker: ImagePicker)
    {
        self.parent = picker
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Image Selected")
        if  let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.parent.SelectedImage = image
            }
        }
        parent.hasPicked = true
        parent.isPickerShowing = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Image canceled")
        parent.isPickerShowing = false
        parent.hasPicked = false
    }
    
    
}
