//
//  PokemonSprites.swift
//  OB
//
//  Created by Consultant on 3/5/22.
//

import UIKit


struct PokemonResponse : Codable {
    var sprites: PokemonMyResult
    var weight: Int
    //var types: PokemonType
}

struct PokemonMyResult : Codable {
    var front_default: String?
}


