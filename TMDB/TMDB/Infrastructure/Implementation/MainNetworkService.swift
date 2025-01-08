// 
//  MainNetworkService.swift
//  TMDB
//
//  Created by Mohamed Fawzi on 08/01/2025.
//


import Foundation
import PromiseKit

class MainNetworkService: NetworkService {
    
    // MARK: - Methods
    func fetchRequest<T: Decodable>(forRoute route: EndpointRouter) -> Promise<T> {
        return Promise<T> { seal in
            do {
                let urlRequest = try route.asURLRequest()
                
                URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                    // Log response body if possible
                    if let data = data, let decodedResponseBody = String(data: data, encoding: .utf8) {
                        print("LOG:: \n 🔗 \(urlRequest.url!) \n ✅ \(decodedResponseBody)")
                    }
                    
                    // Check for errors
                    if let httpResponse = response as? HTTPURLResponse,
                       !(200 ... 299).contains(httpResponse.statusCode) {
                        print("LOG:: \n 🔗 \(urlRequest.url!) \n ⚠️ \(response.debugDescription)")
                                                
                        // handle default errors
                        switch httpResponse.statusCode {
                        case 400: seal.reject(TMDBError.badAPIRequest)
                        case 404: seal.reject(TMDBError.notFound)
                        default: seal.reject(TMDBError.unknown)
                        }
                        return
                    }
                    
                    // Try to decode response
                    do {
                        guard let data = data else {
                            print("LOG:: \n 🔗 \(urlRequest.url!) \n ⚠️ Doesn't have any data")
                            seal.reject(TMDBError.decodingIssue)
                            return
                        }
                        let decodedObject = try JSONDecoder().decode(T.self, from: data)
                        seal.fulfill(decodedObject)
                    } catch {
                        print("LOG:: \n 🔗 \(urlRequest.url!) \n ⚠️ Decoding error: \(error)")
                        seal.reject(TMDBError.decodingIssue)
                    }
                }.resume()
            } catch {
                seal.reject(TMDBError.unknown)
            }
        }
    }
}
