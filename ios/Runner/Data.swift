//
//  Data.swift
//  Mazloum
//
//  Created by Genesis Creations on 8/17/20.
//  Copyright © 2020 Genesis Creations. All rights reserved.
//

import SwiftUI
import Foundation

// MARK: - Welcome

let  IP_ADDRESS: String = "https://mazloum.genesiscreations.co/core/core.php?"



class 	Api: ObservableObject{
    
    func getProducts(query: (String),completion: @escaping (Products) -> ()){
        guard let url = URL(string:"\(IP_ADDRESS)q=products\(query)")
            else {
                return
        }
      
        URLSession.shared.dataTask(with: url) { (data
            , response, error) in
            if let data = data {
                if let products1 = try? JSONDecoder().decode(Products.self, from: data){
                   // print(products1)
                DispatchQueue.main.async {
                   return completion(products1)
                }
                    return 
                }
                print(data.base64EncodedData())
            }
          
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
         
            return completion(Products(status: "faied",products:[], total_pages: 1, total_products: 0, lowest_price: 1, highest_price: 1))
        }
        .resume()
    }
  
}

struct Data_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
