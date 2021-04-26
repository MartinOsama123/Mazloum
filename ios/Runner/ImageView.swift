//
//  ImageView.swift
//  Mazloum
//
//  Created by Martin Osama on 3/24/21.
//  Copyright © 2021 Genesis Creations. All rights reserved.
//

import SwiftUI
import URLImage
struct ImageView: View {
    @State var url: String
    @State var width: CGFloat = 100
    @State var height: CGFloat = 100
    @State var radius: CGFloat = 15
    @State var isCat: Bool = false
    var body: some View {
        URLImage(URL(string: isCat ? url :appendingStringImage(text: self.url))!, delay:0.25,incremental: true){ proxy in
        proxy.image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipped()
        }.frame(width: self.width, height: self.height).cornerRadius(self.radius)
    }
}

func appendingStringImage(text: String) -> String{
   
    let temp = text.replacingOccurrences(of:" ", with: "%20")

    return "https://mazloum.genesiscreations.co/core/img/\(temp)"
}
func categoryURL(id: Int) -> String {
    return "https://mazloum.genesiscreations.co/core/img/categories/\(id).png"
}
