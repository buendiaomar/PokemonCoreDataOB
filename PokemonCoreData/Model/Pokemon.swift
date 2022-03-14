//
//  Pokemon.swift
//  OB
//
//  Created by Consultant on 3/5/22.
//

import Foundation

struct Pokemon: Codable {
   
    var name: String
    var url: String
}

struct Raw2: Codable {
    let count:Int
    let next:String
    var results: [Pokemon]
}


