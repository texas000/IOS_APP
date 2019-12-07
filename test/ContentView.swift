//
//  ContentView.swift
//  test
//
//  Created by JIN KIM on 11/30/19.
//  Copyright © 2019 JINNY. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State var selectedView = 0
    
    var body: some View {
        TabView(selection: $selectedView) {
            NavigationView{
                LoadImageFirebase()
                .navigationBarTitle(Text("FIRST_LIST"), displayMode: .inline)
                .navigationBarItems(trailing: Image(systemName: "heart"))
            }
                .tabItem {
                    Image(systemName: "list.dash")
            }.tag(0)
            NavigationView{
                Home()
                .navigationBarTitle(Text("SECOND_STORED"), displayMode: .inline)
                .navigationBarItems(trailing: Image(systemName: "heart"))
            }
                .tabItem {
                    Image(systemName: "tray.full")
            }.tag(1)
            NavigationView{
                nanana()
                .navigationBarTitle(Text("DEV NOTE"), displayMode: .inline)
                .navigationBarItems(trailing: Image(systemName: "heart"))
            }
                .tabItem {
                    Image(systemName: "doc.text")
            }.tag(2)
        }.edgesIgnoringSafeArea(.top)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width:375, height: 1000))
    }
}
