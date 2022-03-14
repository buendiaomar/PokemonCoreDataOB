//
//  Extension+SessionError.swift
//  OB
//
//  Created by Omar Buendía on 3/3/22.
//

import Foundation
extension URLSession {
    enum RequestErrors:Error {
        case badURL
        case badData
    }
}
