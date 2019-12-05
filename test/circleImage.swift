//
//  circleImage.swift
//  test
//
//  Created by JIN KIM on 11/30/19.
//  Copyright © 2019 JINNY. All rights reserved.
//

import SwiftUI

struct circleImage: View {
    var body: some View {
        //그림은 항상 Assets 폴더안에 들어가있어야함
        Image("turtlerock")
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 10))
            .shadow(radius: 10)
            .frame(width: 300.0)
    }
}

struct circleImage_Previews: PreviewProvider {
    static var previews: some View {
        circleImage()
    }
}
