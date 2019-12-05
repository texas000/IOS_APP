//
//  nanana.swift
//  test
//
//  Created by JIN KIM on 11/30/19.
//  Copyright © 2019 JINNY. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct nanana: View {
    var body: some View {
        custView()
    }
}

struct nanana_Previews: PreviewProvider {
    static var previews: some View {
        nanana()
    }
}

struct custView: View {
    
    @State var msg = ""
    @ObservedObject var datas = observer()
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 3)
    @State private var name = Array<String>.init(repeating: "", count: 3)
    
    var body: some View{
        VStack{
            List{
                ForEach(datas.data){i in
                    Text(i.msg)
                }
                .onDelete { (index) in
                    
                    //To remove on firebase
                    let id = self.datas.data[index.first!].id
                    let db = Firestore.firestore().collection("msgs")
                    db.document(id).delete{ (err) in
                        if err != nil{
                            print((err!.localizedDescription))
                            return
                        }
                        print("deleted Success!")
                        self.datas.data.remove(atOffsets: index)
                    }
                }
            }
            HStack{
                TextField("WHAT ARE YOU THINKING?",text: $msg, onEditingChanged: { if $0 { self.kGuardian.showField = 0 }})
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.oneTimeCode)
                    .padding(.all)
                    .disableAutocorrection(true)
                    .background(GeometryGetter(rect: $kGuardian.rects[0]))
                Button(action: {
                    print(self.msg)
                    self.addData(msg1: self.msg)
                    
                }) {
                    Text("SAVE")
                        .font(.headline)
                        .foregroundColor(.white)
                }.padding().background(Color.red)
            }.padding()
        }.offset(y: kGuardian.slide).animation(.easeInOut(duration: 0.1))
    }
    
    //to create and write data on firestore
    func addData(msg1:String){
        let now=Date().description
        let db=Firestore.firestore()
        let msg=db.collection("msgs").document(now)
        
        msg.setData(["id":msg.documentID, "msg": msg1]) { (err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            print("sucess")
            self.msg=""
        }
    }
}

class observer: ObservableObject{
    @Published var data = [datatype]()
    
    
    //for reading purpose it will automatically add data when we write data to firestore
    init() {
        let db = Firestore.firestore().collection("msgs")
        db.addSnapshotListener{ (snap, err) in
            if err != nil{
                print((err?.localizedDescription)!)
            }
            for i in snap!.documentChanges{
                if i.type == .added{
                    let msgData = datatype(id: i.document.documentID, msg: i.document.get("msg") as! String)
                    self.data.append(msgData)
                }
            }
        }
    }
}

struct datatype: Identifiable{
    var id: String
    var msg: String
}

struct GeometryGetter: View {
    @Binding var rect: CGRect

    var body: some View {
        GeometryReader { geometry in
            Group { () -> AnyView in
                DispatchQueue.main.async {
                    self.rect = geometry.frame(in: .global)
                }

                return AnyView(Color.clear)
            }
        }
    }
}
