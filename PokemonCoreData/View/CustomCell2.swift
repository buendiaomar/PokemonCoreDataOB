//
//  CustomCell.swift
//  PokemonCoreData
//
//  Created by Consultant on 3/12/22.
//

import UIKit

class CustomCell2: UITableViewCell {
    
    @IBOutlet weak var imagePok: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    

    func configureCell2(nombre: String, url:String) {
        titleLabel.text = nombre
       // typeLabel.text  = type
        let baseURL = url
        //print("esooooooooo   \(baseURL)")
        getData(url: baseURL)

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
