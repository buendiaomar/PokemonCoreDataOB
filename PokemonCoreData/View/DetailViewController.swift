//
//  DetailViewController.swift
//  OB
//
//  Created by Omar Buendia on 3/4/22.
//

import UIKit

class DetailViewController: UIViewController {
    var pokemon:Pokemon?
    var ability = ""
    var moves:String = "No movies"
    var properties=GetProperties()
    var movesArray:[String]=[]
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var moves1Label: UILabel!
    @IBOutlet weak var moves2Lable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
 
    
    @IBAction func addFavorite(_ sender: AnyObject) {
        
        // Link to the Favorite VC
        let vc = storyboard?.instantiateViewController(withIdentifier: "FViewController") as? FViewController
        
        //assigm the name of the pokemon on source vc
        vc?.namePokemon = self.titleLabel.text ?? "No Name"
        
        //take of the pokemon data with me
        vc?.fPokemon = pokemon
        
        // call the funcion to add pokemons
        vc?.addCorePokemon(titleLabel)
        
        //call to the source vc
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    func setupView() {
        //Asign the name to the pokemon
        titleLabel.text = pokemon?.name

        // Get the base url
        let baseURL = "\(pokemon!.url)"
       
        // get the image
        getPokeImage(url: baseURL)
 
        //get ability
        getAbility(url: baseURL)
 
        // get moves
        getMoves(url: baseURL)
   }
    
    func getPokeImage(url:String) {
        let task = URLSession.shared.dataTask (with: URL(string: url)!, completionHandler: {data, response, error in
            
            var result:PokemonResponse?
            do {
                result = try JSONDecoder().decode(PokemonResponse.self, from: data!)
            }
            catch{
                print("\(error.localizedDescription)")
            }
            guard let json = result else {return}
        
            let baseURL = "\(json.sprites.front_default ?? "")"
            let urlString = URL(string: baseURL)
   
 
            DispatchQueue.main.async {
                self.image.getImage(from: urlString!)
               // self.image = image
            }

            
        })
        task.resume()
    }
   
    
  // MARK: - prueba con ability
    
    
    func getAbility(url:String) {
        let task = URLSession.shared.dataTask (with: URL(string: url)!, completionHandler: { [self]data, response, error in
                var result:PokemonAbilityResponse?
                do {
                    result = try JSONDecoder().decode(PokemonAbilityResponse.self, from: data!)
                }
                catch{
                    print("\(error.localizedDescription)")
                }
                guard let json = result else {return}
            ability = "\(json.abilities[0].ability.name)"
            DispatchQueue.main.async {
                abilityLabel.text=ability
            }

                
            })
            task.resume()
        }
   
 // fin prueba
    
    
    func getMoves(url:String) {
        let task = URLSession.shared.dataTask (with: URL(string: url)!, completionHandler: { [self]data, response, error in
                var result:PokemonMovesResponse?
                do {
                    result = try JSONDecoder().decode(PokemonMovesResponse.self, from: data!)
                }
                catch{
                    print("\(error.localizedDescription)")
                }
                guard let json = result else {return}
            
            if moves.count > 0 {
                
//              working on put an array here and
//                for mov in moves  {
//                    movesArray.append("\(json.moves[mov].name)")
//                }
//
//
                DispatchQueue.main.async {
                    movesLabel.text = ("\(json.moves[0].move.name)")
                    moves1Label.text = ("\(json.moves[1].move.name)")
                   // moves2Lable.text = ("\(json.moves[2].move.name)")
                }
                
            }
            })
            task.resume()
        }

    
}
    
    
    
    
 

 

