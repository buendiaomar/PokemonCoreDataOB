//
//  Person+CoreDataProperties.swift
//  PokemonCoreData
//
//  Created by Consultant on 3/12/22.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var url: String?

}

extension Person : Identifiable {

}
