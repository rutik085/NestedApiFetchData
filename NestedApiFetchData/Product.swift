//
//  Product.swift
//  NestedApiFetchData
//
//  Created by Mac on 29/12/23.
//

import Foundation
struct Product{
    var id : Int
    var title : String
    var price : Double
    var desciption : String
    var category : String
    var image : String
    var rating : Rating
}

struct Rating {
    var rate : Double
    var count : Int
}
