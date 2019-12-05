//
//  Home.swift
//  test
//
//  Created by JIN KIM on 11/30/19.
//  Copyright © 2019 JINNY. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct Home: View {
    
    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarkData,
            by: { $0.category.rawValue }
        )
    }
    
    var body: some View {
        VStack{
            ScrollView() {
                NavigationLink(destination: TEST()
                    //.navigationBarTitle(Text("Upload Image"))
                    .navigationBarItems(trailing: Image(systemName: "heart"))
                    //.navigationBarItems(trailing: Button("HH"){ print("HELP!") })
                ){
                    circleImage()
                    .offset(y: 40)
                    .padding(.bottom, 50)
                    .frame(width: 200, height: 200)
                }
                .buttonStyle(PlainButtonStyle())
                
                Divider()
                
                VStack(alignment: .leading) {
                    ScrollView() {
                    Text("WELCOME")
                        .font(.title)
                        /*
                    HStack(alignment: .top) {
                        Text("Joshua Tree National Park")
                            .font(.subheadline)
                        Spacer()
                        Text("California")
                            .font(.subheadline)
                    }
                        */
                    NavigationLink(destination: nanana()) {
                        Image(systemName: "plus")
                        .imageScale(.large)
                        .padding()
                    }
                        
                    AnimatedImage(url: URL(string: "https://media2.giphy.com/media/3ohjUSWuZ4V1tg7eEM/giphy.gif?cid=790b761114921474086feaf3f1ed1b530242f2d46fc8c02e&rid=giphy.gif"))
                        .frame(width: 300, height: 200, alignment: .center)
                    AnimatedImage(url: URL(string: "https://media2.giphy.com/media/xUNda1aXN8zSrNartK/giphy.gif?cid=790b7611c1033db9c94203bb7a8cfa35ffa1eff512d2c089&rid=giphy.gif"))
                        .frame(width: 300, height: 200, alignment: .center)
                    AnimatedImage(url: URL(string: "https://media1.giphy.com/media/3ohjUTu04LsLAEo9Zm/giphy.gif?cid=790b76118955ba7e79b13ca9a4882c333e35a3daf176e124&rid=giphy.gif"))
                        .frame(width: 300, height: 200, alignment: .center)
                    AnimatedImage(url: URL(string: "https://media0.giphy.com/media/xUNd9UuxgIHq5yWDvO/giphy.gif?cid=790b7611994e8bafaf8570e62684992c2a1debf7cd3818b6&rid=giphy.gif"))
                        .frame(width: 300, height: 200, alignment: .center)
                    AnimatedImage(url: URL(string: "https://media0.giphy.com/media/xUNd9UuxgIHq5yWDvO/giphy.gif?cid=790b7611994e8bafaf8570e62684992c2a1debf7cd3818b6&rid=giphy.gif"))
                        .frame(width: 300, height: 200, alignment: .center)
                    AnimatedImage(url: URL(string: "https://media0.giphy.com/media/xUNd9UuxgIHq5yWDvO/giphy.gif?cid=790b7611994e8bafaf8570e62684992c2a1debf7cd3818b6&rid=giphy.gif"))
                        .frame(width: 300, height: 200, alignment: .center)
                    AnimatedImage(url: URL(string: "https://media0.giphy.com/media/xUNd9UuxgIHq5yWDvO/giphy.gif?cid=790b7611994e8bafaf8570e62684992c2a1debf7cd3818b6&rid=giphy.gif"))
                        .frame(width: 300, height: 200, alignment: .center)
                    //NavigationLink("Detail", destination: Text("Detail"))
                    }
                }
                Spacer()
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
