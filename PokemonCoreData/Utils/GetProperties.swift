//
//  GetProperties.swift
//  ExampleTableViewCell
//
//  Created by Consultant on 3/11/22.
//

import Foundation
class GetProperties {
    
    func getAbility(url:String)-> String {
        var abi=""
        let task = URLSession.shared.dataTask (with: URL(string: url)!, completionHandler: {[]data, response, error in
                    var result:PokemonAbilityResponse?
                    do {
                        result = try JSONDecoder().decode(PokemonAbilityResponse.self, from: data!)
                    }
                    catch{
                        print("\(error.localizedDescription)")
                    }
                    guard let json = result else {return}
                 let response = "\(json.abilities[0].ability.name)"
                
            DispatchQueue.main.async {
                    abi = response
                }
    
    
                })
                task.resume()
        print("ojoooooooooo    " + abi)
        return abi
        
            }

}

