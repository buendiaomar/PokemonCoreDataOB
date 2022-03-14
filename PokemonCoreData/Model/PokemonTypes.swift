
//  PokemonType.swift
//  OB
//
//  Created by Consultant on 3/6/22.
//

import Foundation

struct PokemonTypeResponse : Codable {
    var types: [PokemonTypeMyResult1]
}

struct PokemonTypeMyResult1 : Codable {
    var type:pokemonTypeMyResult2
}

struct pokemonTypeMyResult2: Codable {
    var name:String
}

