//
//  CacheManager.swift
//  PokemonCoreData
//
//  Created by Consultant on 3/13/22.
//

import Foundation
class CacheManager {
    
    
    static var cache = [String:Data]()
    
   
    
    static func setPokeCache (_ url:String, data:Data? ){
        
        //Store the image data and the url is the key
        cache[url] = data
    }
    
    static func getPokeCache (_ url:String)-> Data? {
        
        
        //Try to get the data for the specified url
        return cache[url]
        
        
    }
    
}
