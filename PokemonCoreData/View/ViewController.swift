//
//  ViewController.swift
//  ExampleTableViewCell
//
//  Created by Omar Buendia on 2/28/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
   // var and declarations area
    @IBOutlet weak var tableView: UITableView!
    var isLoading = false
    var pokemons = [Pokemon]()
    var pipoType = ""
    var imagenTemp: UIImageView!
    var urlStringT = URL(string: "")
    var pokeLeidos: Int = 150
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchPokemons(load: pokeLeidos)
        tableView.dataSource = self
        tableView.delegate = self
  
    }

    // Geting data for table
    func fetchPokemons(load:Int) {
        
        URLSession.shared.getRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon?limit="+"\(load)"), decoding: Raw2.self) { [weak self] result in
            switch result {
            case .success(let raw2):
                self?.pokemons = raw2.results
                DispatchQueue.main.async {
                    self?.pokemons += raw2.results
                    
                    self?.tableView.reloadData()
                }
                
            case  .failure(let error):
                print(error)
            }
        }
    }
    
    public func getType(url:String) {
        var type:String = ""
        let task = URLSession.shared.dataTask (with: URL(string: url)!, completionHandler: { [self]data, response, error in

                var result:PokemonTypeResponse?
                do {
                    result = try JSONDecoder().decode(PokemonTypeResponse.self, from: data!)
                }
                catch{
                    print("\(error.localizedDescription)")
                }
                guard let json = result else {return}
                type = "\(json.types[0].type.name)"
            
            //self.typeLabel.text = (json.types[0].type.name)
                pipoType = type
            })
            task.resume()
        //return type
        }
    
       
}
//MARK: - Extensions

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemons.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        // Assign name to the cell
        let baseURL = "\(pokemons[indexPath.row].url)"
        getType(url: baseURL)
        
        cell.configureCell(nombre: pokemons[indexPath.row].name,type: "\(pipoType)", pokemonUrl: baseURL)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSeque", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.pokemon = pokemons[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
}
