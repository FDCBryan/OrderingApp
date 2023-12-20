//
//  AddMenu.swift
//  OrderApp
//
//  Created by FDCI on 11/22/23.
//

import SwiftUI

struct AddMenu: View {
    @State var isPickerShowing = false
    @State var hasPicked = false
    @ObservedObject private var viewModel = AddMenuViewModel()
    var body: some View {
        VStack{
            
            Form{
                Section(header: Text("Add Menu")){
                    Text("Name")
                    TextField("Name", text: $viewModel.name)
                    Text("Description")
                    TextEditor(text: $viewModel.description)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                        .border(Color.gray, width: 1)
                        .padding()
                    Text("Price")
                    TextField("Price", text: Binding(
                        get: { String(format: "%.2f", self.viewModel.price) },
                        set: {
                            if let newValue = NumberFormatter().number(from: $0)?.doubleValue {
                                self.viewModel.price = newValue
                            }
                        }
                    ))
                    .keyboardType(.decimalPad)
                    Text("Calories")
                    TextField("Calories", text: Binding(
                        get: { String(self.viewModel.calories) },
                                    set: {
                                        if let newValue = Int($0) {
                                            self.viewModel.calories = newValue
                                        }
                                    }
                                ))
                        .keyboardType(.decimalPad)
                    Text("Protein")
                    TextField("protein", text: Binding(
                        get: { String(self.viewModel.protein) },
                                    set: {
                                        if let newValue = Int($0) {
                                            self.viewModel.protein = newValue
                                        }
                                    }
                                ))
                        .keyboardType(.decimalPad)
                    Text("Carbs")
                    TextField("carbs", text: Binding(
                        get: { String(self.viewModel.carbs) },
                                    set: {
                                        if let newValue = Int($0) {
                                            self.viewModel.carbs = newValue
                                        }
                                    }
                                ))
                        .keyboardType(.decimalPad)
                    Text("Image")
                    if viewModel.selectedImage != nil{
                        Image(uiImage: viewModel.selectedImage!)
                            .resizable()
                            .frame(width: 100, height: 100)
                    }else{
                        Image("food-placeholder")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    
                    Button{
                        isPickerShowing = true
                    }label:{
                        Text("Select Image")
                    }
                    Button{
                        guard let image = viewModel.selectedImage?.jpegData(compressionQuality: 1.0) else {
                            print("Selected image is nil or cannot be converted to data.")
                            return
                        }
                        viewModel.uploadImageToServer(imageData: image) { result in
                            switch result {
                            case .success(let responseString):
                                viewModel.imageString = responseString
                                viewModel.saveDataToServer()
                            case .failure(let error):
                                print("Error uploading image: \(error.localizedDescription)")
                            }
                        }
                    }label: {
                        Text("Update")
                    }.padding(.top)
                }
            }
            
            
        }
        .sheet(isPresented: $isPickerShowing, onDismiss: nil){
            ImagePicker(SelectedImage: $viewModel.selectedImage, isPickerShowing: $isPickerShowing, hasPicked: $hasPicked)
        }
    }
    
    

}

#Preview {
    AddMenu()
}
