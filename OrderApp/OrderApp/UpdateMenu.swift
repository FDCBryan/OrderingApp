//
//  UpdateMenu.swift
//  OrderApp
//
//  Created by FDCI on 11/24/23.
//

import SwiftUI

struct UpdateMenu: View {
//    @State var isPickerShowing = false
    @State var appetizer :Appetizer
    @ObservedObject private var viewModel = AddMenuViewModel()
    @Binding  var isShowingDetail : Bool
    @State var isPickerShowing = false
    @State var hasPicked = false
    var body: some View {
        VStack{
            
            Form{
                Section(header: Text("Add Menu")){
                    Text("ID")
                    TextField("Calories", text: Binding(
                        get: { String(self.viewModel.id ?? 0) },
                                    set: {
                                        if let newValue = Int($0) {
                                            self.viewModel.id = newValue
                                        }
                                    }
                                ))
                    .disabled(true)
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
                        if hasPicked{
                            viewModel.uploadImageToServer(imageData: image) { result in
                                switch result {
                                case .success(let responseString):
                                    viewModel.imageString = responseString
                                    viewModel.updateDataToServer { result in
                                        switch result {
                                        case .success:
                                            isShowingDetail = false
                                        case .failure(let error):
                                            print("Update failed with error: \(error)")
                                        }
                                    }
                                case .failure(let error):
                                    print("Error uploading image: \(error.localizedDescription)")
                                }
                            }
                        }
                        else{
                            print(viewModel.imageString)
                        
                            let charactersToRemove = CharacterSet(charactersIn: "http://localhost:8080")
                            viewModel.imageString = viewModel.imageString?.trimmingCharacters(in: charactersToRemove)
                            viewModel.updateDataToServer { result in
                                switch result {
                                case .success:
                                    isShowingDetail = false
                                case .failure(let error):
                                    print("Update failed with error: \(error)")
                                }
                            }
                        }
                        
                        
                    }label: {
                        Text("Update")
                    }.padding(.top)
                }
            }
            
            
        }
        .onDisappear{
            isShowingDetail = false
        }
        .onAppear{
            viewModel.getData(for: appetizer)
        }
        .sheet(isPresented: $isPickerShowing, onDismiss: nil){
            ImagePicker(SelectedImage: $viewModel.selectedImage, isPickerShowing: $isPickerShowing, hasPicked: $hasPicked)
        }
    }
}

#Preview {
    UpdateMenu(appetizer: Mockata.sampleAppetizer, isShowingDetail: .constant(true))
}
