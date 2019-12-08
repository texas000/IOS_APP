//
//  explore_list.swift
//  test
//
//  Created by JIN KIM on 12/6/19.
//  Copyright © 2019 JINNY. All rights reserved.
//

import SwiftUI

struct SingleItem : Identifiable {
    var id: UUID
    var name: String
    var image: String
    var color: Color
}

struct explore_list: View {
    let SingleItemList : [SingleItem] = [
           SingleItem(id: UUID(), name: "FIRST", image: "example-room", color: .red),
           SingleItem(id: UUID(), name: "SECOND", image: "example-room", color: .red),
           SingleItem(id: UUID(), name: "THIRD", image: "example-room", color: .red),
           SingleItem(id: UUID(), name: "FORTH", image: "example-room", color: .red)
       ]
    var body: some View {
        List(SingleItemList) { items in
            VStack(alignment: .leading){
                Image(items.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                Text(items.name)
            }
        }
    }
}

struct explore_list_Previews: PreviewProvider {
    static var previews: some View {
        explore_list()
    }
}
