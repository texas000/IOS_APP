//
//  LoadImageFirebase.swift
//  test
//
//  Created by JIN KIM on 12/2/19.
//  Copyright © 2019 JINNY. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseStorage

struct LoadImageFirebase: View {
    @State var url=""
    var body: some View {
        VStack{
            if url != ""{
                AnimatedImage(url: URL(string: url)!).frame(height: 250).padding().cornerRadius(25)
            }
            else {
                Loader()
            }
        }
        .onAppear() {
            let storage = Storage.storage().reference()
            storage.child("temp").downloadURL{ (url, err) in
                if err != nil{
                    print((err?.localizedDescription)!)
                    return
                }
                self.url = "\(url!)"
            }
        }
        
    }
}

struct Loader: UIViewRepresentable{
    func makeUIView(context: UIViewRepresentableContext<Loader>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
    func updateUIView(_ uiView: Loader.UIViewType, context: UIViewRepresentableContext<Loader>) {
        
    }
}

struct LoadImageFirebase_Previews: PreviewProvider {
    static var previews: some View {
        LoadImageFirebase()
    }
}
