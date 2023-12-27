//
//  APIService.swift
//  iSplash
//
//  Created by Yash Uttekar on 13/09/23.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    let accessKey = ""
    
    private init () {
        
    }
    
    func fetchPhotos(pageNumber: Int, completion: @escaping (Page) -> Void) {
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
                    let page = Page(number: pageNumber, photos: photos)
                    completion(page)
                } catch {
                    print("Error - \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    func fetchImage(from imageURL: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: imageURL) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                completion(data)
            }
        }
        task.resume()
    }
    
    func fetchSearchResults(for query: String, pageNumber: Int, completion: @escaping (SearchResult) -> Void) {
        let urlString = "https://api.unsplash.com/search/photos?page=\(pageNumber)&query=\(query)"
        
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
                    print(String(data: data, encoding: .utf8)!)
                    let result = try JSONDecoder().decode(SearchResult.self, from: data)
                    completion(result)
                } catch {
                    print("Error - \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
