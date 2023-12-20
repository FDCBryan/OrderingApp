//
//  RemoteImage.swift
//  OrderApp
//
//  Created by FDCI on 11/10/23.
//

import SwiftUI

final class ImageLoader: ObservableObject{
    
    @Published var image: Image? = nil
    func load(fromURLString : String){ 
        NetworkManager.share.downloadImage(fromURLString: fromURLString) { uiImage in
            guard let uiImage = uiImage else {return}
            DispatchQueue.main.async {
                self.image = Image(uiImage: uiImage )
            }
        
        }
    }
}
 

struct RemoteImage : View{
    var image: Image?
    var body: some View{
        image?.resizable() ?? Image("food-placeholder").resizable()
    }
    
}

 
struct AppetizerRemoteImage: View {
    @StateObject var imageLoader = ImageLoader()
    let urlString : String
    var body: some View {
        RemoteImage(image: imageLoader.image)
            .onAppear{
                imageLoader.load(fromURLString: urlString)
            }
    }
}
