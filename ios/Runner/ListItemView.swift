//
//  ListItemView.swift
//  Mazloum
//
//  Created by Genesis Creations on 10/14/20.
//  Copyright © 2020 Genesis Creations. All rights reserved.
//

import SwiftUI

struct ListItemView: View {
   
    let product: Product

    var body: some View {
        HStack{
            ZStack(alignment: Alignment.init(horizontal: .trailing, vertical: .top)){
                ImageView(url:product.product_images?[0] ?? "")
              
        }
            Spacer()
            VStack{
            Text(product.product_name_en ?? "").font(.footnote).bold().lineLimit(1).foregroundColor(.black)
       //     Text(product.product_brand).font(.caption).foregroundColor(.black)
            
                Text(String(product.product_price ?? 0) + " L.E").font(.caption).padding(5).foregroundColor(Color.red)//.background(Color.init(hexadecimal: "#DCDCDE").cornerRadius(10))
            }
            
        }.padding()
        }
    }
