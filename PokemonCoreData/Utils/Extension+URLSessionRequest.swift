//  OB
//
//  Created by Omar Buendía on 3/3/22.
//

import Foundation


extension URLSession {
    
    func getRequest<T:Codable>(url:URL?,decoding: T.Type, completion: @escaping (Result<T, Error>)->()) {
        
        guard let url = url else {
            completion(.failure(RequestErrors.badURL))
            return
        }
        
        let task = self.dataTask(with: url) {data, _, error in
            guard data != nil else {
                completion(.failure(RequestErrors.badData))
                return
            }
            
            do{
                let jsonResult = try JSONDecoder().decode(decoding, from: data!)
                completion(.success(jsonResult))
                
                
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
