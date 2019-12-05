//
//  TEST.swift
//  test
//
//  Created by JIN KIM on 12/2/19.
//  Copyright © 2019 JINNY. All rights reserved.
//

import SwiftUI

struct TEST: View {
    var body: some View {
        VStack(alignment: .center){
            HStack(spacing: 10){
                Spacer()
                VStack{
                    Image("turtlerock")
                    .resizable()
                    .frame(width: 90, height: 90)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                        .overlay(Circle().stroke(Color.pink, lineWidth: 1))
                    
                    Text("Your Name")
                        .foregroundColor(Color.blue)
                        .fontWeight(.semibold)
                }.padding(.leading, 10)
                Spacer()
                VStack{
                    Text("10")
                    .font(.system(size: 20))
                    .foregroundColor(Color.blue)
                    .fontWeight(.bold)
                    
                    Text("Posts")
                    .font(.system(size: 13))
                    .foregroundColor(Color.blue)
                }.padding(.leading, 30)
                Spacer()
                VStack{
                    Text("100")
                    .font(.system(size: 20))
                    .foregroundColor(Color.blue)
                    .fontWeight(.bold)
                    
                    Text("Likes")
                    .font(.system(size: 13))
                    .foregroundColor(Color.blue)
                }.padding()
                Spacer()
                VStack{
                    Text("100")
                    .font(.system(size: 20))
                    .foregroundColor(Color.blue)
                    .fontWeight(.bold)
                    
                    Text("Following")
                    .font(.system(size: 13))
                    .foregroundColor(Color.blue)
                }
                Spacer()
            }.frame(height: 100)
            .padding(.leading, 10)
            
            Button(action: {}){
                Text("Edit Profile")
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
            }.frame(width: 400)
            .padding()
        }
    }
}

struct TEST_Previews: PreviewProvider {
    static var previews: some View {
        TEST()
    }
}
