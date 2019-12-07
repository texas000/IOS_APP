//
//  UploadImage.swift
//  test
//
//  Created by JIN KIM on 12/2/19.
//  Copyright © 2019 JINNY. All rights reserved.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct UploadImage: View {
    @State var shown=false
    @State var imageUrl=""

    var body: some View {
        
        //code here

        Button(action: {
            self.shown.toggle()
                
        }) {
            Text("Upload Image")
        }.sheet(isPresented: $shown) {
            imagePicker(shown: self.$shown)
        }
    }
}


//Download Image


//Upload image
struct UploadImage_Previews: PreviewProvider {
    static var previews: some View {
        UploadImage()
    }
}

struct imagePicker : UIViewControllerRepresentable {
    
    func makeCoordinator() -> imagePicker.Coordinator {
        return imagePicker.Coordinator(parent1: self)
    }
    
    @Binding var shown : Bool
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<imagePicker>) -> imagePicker.UIViewControllerType {
        let imagepic = UIImagePickerController()
        imagepic.sourceType = .photoLibrary
        imagepic.delegate = context.coordinator
        return imagepic
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<imagePicker>) {
    }
    
    class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        
        var parent: imagePicker!
        init(parent1: imagePicker) {
            parent = parent1
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            parent.shown.toggle()
            
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let image = info[.originalImage] as! UIImage
            
            let storage = Storage.storage()
            storage.reference().child("temp").putData(image.jpegData(compressionQuality: 0.25)!, metadata:
            nil) { (_, err) in
                
                if err != nil{
                    print((err?.localizedDescription)!)
                    return
                }
                print("Upload Image Success")
            }
            parent.shown.toggle()
        }
    }
}
