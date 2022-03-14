//
//  PokemonMoves.swift
//  ExampleTableViewCell
//
//  Created by Consultant on 3/8/22.
//

import Foundation
struct PokemonMovesResponse : Codable {
    var moves: [PokemonMoveMyResult1]
}

struct PokemonMoveMyResult1 : Codable {
    var move:pokemonMoveNameMyResult2
}

struct pokemonMoveNameMyResult2: Codable {
    var name:String
}
