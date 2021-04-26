//
//  AddressScreen.swift
//  Mazloum
//
//  Created by Genesis Creations on 12/15/20.
//  Copyright © 2020 Genesis Creations. All rights reserved.
//

import SwiftUI

class ViewModel {
    var closeAction: () -> Void = {}
}
class ProductsDelegate: ObservableObject {
    @Published var ARProductID: Product = Product(id: UUID(), product_id: "0", product_name_en: "", product_category_id: 0, product_category_name_en: "", product_category_name_ar: "", product_price: 0, product_images: [], product_details: "", is_wishlisted: "", is_available: "",  offset: 0)
}
struct AddressScreen: View {
    @ObservedObject var delegate: ProductsDelegate
    
    @State var productsView: [Product] = []
    @State private var currentPage = 1
    @State private var isLoading = false
    @State private var query = ""
   
    var vm: ViewModel
    var imageWidth:Int = Int(UIScreen.main.bounds.width) / 150
    var body: some View {
     
    
        VStack {
            ScrollView{
                VStack{
            ForEach(productsView.indices, id: \.self){ i in
                  
                Button(action:{
                    self.delegate.ARProductID = productsView[i]
                    self.vm.closeAction()
                }){
     
                    ListItemView(product: productsView[i])
                        if productsView[i].product_id == productsView.last?.product_id {
                            Text("Loading...").onAppear {   Api().getProducts(query:"&page=\(currentPage)"){(productsView) in self.productsView.append(contentsOf: productsView.products ?? [])}
                                currentPage += 1
                            }
                            
                        }
                    
                }.buttonStyle(PlainButtonStyle())
            }
            }
            
            }
        }.background(Color.white).padding().onAppear{
        Api().getProducts(query:"&page=1"){(productsView) in self.productsView = productsView.products ?? []}
    }
}
}



