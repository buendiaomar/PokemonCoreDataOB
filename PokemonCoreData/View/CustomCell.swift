//
//  CustomCell.swift
//  ExampleTableViewCell
//
//  Created by Omar Buendia on 2/28/22.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var imagePok: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var NroLabel: UILabel!
    
    
    func configureCell(nombre: String, type:StringLiteralType, pokemonUrl:String) {
        titleLabel.text = nombre
        typeLabel.text  = type
        let baseURL = pokemonUrl
        getData(url: baseURL)
        //NroLabel.text = row
    }
    
    func getData(url:String) {
        
        
        
        let task = URLSession.shared.dataTask (with: URL(string: url)!, completionHandler: {data, response, error in
            
            var result:PokemonResponse?
            do {
                result = try JSONDecoder().decode(PokemonResponse.self, from: data!)
            }
            catch{
                print("\(error.localizedDescription)")
            }
            
            guard let json = result else {return}
            print("\(json.sprites.front_default ?? "")")
            let baseURL = "\(json.sprites.front_default ?? "")"
            let urlString = URL(string: baseURL)
            self.imagePok.getImage(from: urlString!)
        })
        task.resume()
    }
    
    
}
