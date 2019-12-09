//
//  Saved_view.swift
//  test
//
//  Created by JIN KIM on 12/7/19.
//  Copyright © 2019 JINNY. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct Saved_view: View {
    
    @ObservedObject var RoomData=letMeSee()
    @State var show = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            ForEach(RoomData.data) {i in
                VStack(alignment: .leading){
                    Button(action: {
                        self.show.toggle()
                    }) {
                        Image(i.pic).resizable().aspectRatio(contentMode: .fit)
                        .overlay(
                            Text(i.price)
                            .foregroundColor(.gray)
                                .font(.largeTitle)
                            ,alignment: .bottomTrailing)
                    }.buttonStyle(PlainButtonStyle())
                    Text("Hello world").fontWeight(.heavy)
                    
                    HStack(spacing: 5){
                        Image(systemName: "heart")
                        Text("Torrance, CA")
                    }
                }
            }
        }
    }
}

struct Saved_view_Previews: PreviewProvider {
    static var previews: some View {
        Saved_view()
    }
}

class letMeSee : ObservableObject{
    @Published var data = [roomDataType]()
    
    //for reading purpose it will automatically add data when we write data to firestore
    init() {
        let db = Firestore.firestore().collection("ROOMINFO")
        db.addSnapshotListener{ (snap, err) in
            if err != nil{
                print((err?.localizedDescription)!)
            }
            for i in snap!.documentChanges{
                if i.type == .added{
                    let roomData = roomDataType(id: i.document.documentID, pic: i.document.get("pic") as! String, price: i.document.get("price") as! String, location: i.document.get("location") as! String, type: i.document.get("type") as! String)
                    self.data.append(roomData)
                }
            }
        }
    }
}

struct roomDataType: Identifiable{
    var id: String
    var pic: String
    var price: String
    var location: String
    var type: String
}
