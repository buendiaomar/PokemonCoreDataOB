//
//  Pokemonability.swift
//  ExampleTableViewCell
//
//  Created by Consultant on 3/7/22.
//

import Foundation
struct PokemonAbilityResponse : Codable {
    var abilities: [PokemonAbilityMyResult1]
}

struct PokemonAbilityMyResult1 : Codable {
    var ability:pokemonAbilityMyResult2
}

struct pokemonAbilityMyResult2: Codable {
    var name:String
}
