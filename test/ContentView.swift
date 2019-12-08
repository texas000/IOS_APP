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
                Explore_view()
                .navigationBarTitle(Text("EXPLORE"), displayMode: .inline)
                .navigationBarItems(trailing: Image(systemName: "heart"))
            }
                .tabItem {
                    Image(systemName: "list.dash")
            }.tag(0)
            NavigationView{
                Saved_view()
                .navigationBarTitle(Text("SAVED"), displayMode: .inline)
                .navigationBarItems(trailing: Image(systemName: "heart"))
            }
                .tabItem {
                    Image(systemName: "tray.full")
            }.tag(1)
            NavigationView{
                Home()
                .navigationBarTitle(Text("MESSAGES"), displayMode: .inline)
                .navigationBarItems(trailing: Image(systemName: "heart"))
            }
                .tabItem {
                    Image(systemName: "message.circle.fill")
            }.tag(2)
            NavigationView{
                TEST()
                .navigationBarTitle(Text("PAYMENT"), displayMode: .inline)
                .navigationBarItems(trailing: Image(systemName: "heart"))
            }
                .tabItem {
                    Image(systemName: "dollarsign.circle")
            }.tag(3)
            NavigationView{
                nanana()
                .navigationBarTitle(Text("ACCOUNT"), displayMode: .inline)
                .navigationBarItems(trailing: Image(systemName: "heart"))
            }
                .tabItem {
                    Image(systemName: "person")
            }.tag(4)
        }.edgesIgnoringSafeArea(.top)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width:375, height: 1000))
    }
}
