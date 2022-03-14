import Foundation
import UIKit

extension UIImageView {
    func getImage(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        
        DispatchQueue.main.async {
            self.contentMode = mode
        }
        
        //Check cache before loading data
        // lazy function
        let unwrappedURL = "\(URL.self).self"
        if let cacheData = CacheManager.getPokeCache(unwrappedURL) {
            
            DispatchQueue.main.async {
                self.image = UIImage(data:cacheData)
            }

            return
        }
        
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response,
            error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else { return }
            guard let mimeType = response?.mimeType, mimeType.hasPrefix("image") else { return }
            guard let data = data, error == nil else { return }
            
            // Save the cache
            CacheManager.setPokeCache(url.absoluteString, data: data)
            
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}


