//
//  ViewController.swift
//  PokemonCoreData
//
//  Created by Omar Buendia on 3/12/22.
//

import UIKit
import CoreData

class FViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    var namePokemon = ""
    var fPokemon:Pokemon?
    var typeP=""
    
    
    
    //reference for data object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Data for the table
    var items:[Person]?
    
    override func viewDidLoad() {
        //Load the View
        super.viewDidLoad()
        
        //Setup delegates
        tableView.dataSource = self
        tableView.delegate = self
        
        // Get items from Core Data
        fetchPeople()
        
    }
    
    func fetchPeople(){
        
        // Fetch the data from core data and display in tableView
        do {
            self.items = try context.fetch(Person.fetchRequest())
        
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            
        }
        
    }
    
    
    func addCorePokemon(_ sender: UILabel) {
        
        // Create a person object
        let newPerson = Person(context: self.context)
        newPerson.name = fPokemon?.name
        newPerson.url = fPokemon?.url
     
        // Save the data
        do {
            try self.context.save()
        }
        catch {
            
        }
        
        // Re-fetch the data
        self.fetchPeople()
        
    }
    
    
    
}
//MARK: - Extensions

extension FViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! CustomCell2
        
        let name = self.items?[indexPath.row].name
        let url = self.items?[indexPath.row].url
        cell.configureCell2(nombre: name ?? "", url: url ?? "" )
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Create swipe action
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            // Which pokemon to remove
            let pokemonToRemove = self.items![indexPath.row]
            
            // Remove the pokemon
            self.context.delete(pokemonToRemove)
            
            // Save the data
            do {
                try self.context.save()
            }
            catch {
                
            }
            
            // Re-fetch the data
            self.fetchPeople()
        }
            
        // Return swipe actions
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}
