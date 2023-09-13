//
//  APIService.swift
//  iSplash
//
//  Created by Yash Uttekar on 13/09/23.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    let accessKey = "8VFoQMa7EAZlxvrQ1hm70gllEfp4giZuG9vAHXJ8170"
    
    private init () {
        
    }
    
    func fetchPhotos(pageNumber: Int) {
        let urlString = "https://api.unsplash.com/photos?page=\(pageNumber)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("Client-ID \(accessKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            if let data = data {
                do {
                    let photos = try JSONDecoder().decode([Photo].self, from: data)
                    let _ = Page(number: pageNumber, photos: photos)
                    print("Success")
                } catch {
                    print("Error - \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
