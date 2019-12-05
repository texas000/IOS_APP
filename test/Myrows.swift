//
//  Myrows.swift
//  test
//
//  Created by JIN KIM on 11/30/19.
//  Copyright © 2019 JINNY. All rights reserved.
//

import SwiftUI

struct Myrows: View {
    var items: [Landmark]
    
    var body: some View {
        VStack(alignment: .leading){
            Text("HEADING HORIZONTAL SCROL")
            .font(.headline)
            .padding(.leading, 15)
            .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing:0){
                    ForEach(self.items) { aa in
                        CategoryItem(landmark: aa)
                    }
                }
            }
        }
        .frame(height:200)
    }
}

struct CategoryItem: View {
    var landmark: Landmark
    var body: some View {
        VStack(alignment: .leading) {
            landmark.image
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(landmark.name)
                //이름을 보여주라
                .font(.caption)
        }
        .padding(.leading, 20)
    }
}

struct Myrows_Previews: PreviewProvider {
    static var previews: some View {
        Myrows(
            items: Array(landmarkData.prefix(10))
            //3개의 아이템만 보여줌
        )
    }
}
