//
//  Products.swift
//  Mazloum
//
//  Created by Genesis Creations on 10/13/20.
//  Copyright © 2020 Genesis Creations. All rights reserved.
//

import Foundation
import SwiftUI
struct Product: Decodable,Encodable,Identifiable,Hashable{
 var id = UUID()
    var product_id: String
    var product_name_en: String?
   // var product_name_ar: String
    var product_category_id: Int
    var product_category_name_en: String
    var product_category_name_ar: String
    var product_price: Int?
    var product_images: [String]?
    var product_details: String?
    //var product_model: String
    var is_wishlisted: String
    var is_available: String
    var product_brand_name_en: String?
    //var specifications: [Specification]?
 //   var product_discount: Int?
    var tiles_in_unit:Int?
    var offset: CGFloat = 0
    private enum CodingKeys: String, CodingKey {
        case product_id,product_name_en,product_category_id,product_category_name_en,product_category_name_ar,product_price,product_images,product_details,is_wishlisted,is_available,tiles_in_unit,product_brand_name_en
    }

}
struct Products: Decodable,Encodable,Identifiable,Hashable {
   
    var id = UUID()
    var status : String
    var products : [Product]?
    var total_pages: Int
    var total_products: Int
    var lowest_price: Int
    var highest_price: Int
    var colors: [MInfo]?
    var materials:[MInfo]?
    var brands: [MInfo]?
    var dimensions: [MInfo]?
    private enum CodingKeys: String, CodingKey {
        case status,products,total_pages,total_products,lowest_price,highest_price,colors,materials,brands,dimensions
        }
}

struct MInfo: Decodable,Encodable,Identifiable,Hashable {
    var id: Int
    var name_en: String
    var name_ar: String
   
    private enum CodingKeys: String, CodingKey {
        case id,name_en,name_ar
        }
}


