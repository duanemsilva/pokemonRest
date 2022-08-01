//
//  Request.swift
//  PokemonREST
//
//  Created by Duane de Moura Silva on 25/07/22.
//

import Foundation

enum HttpMethod: String {
    case  GET
    case  POST
    case  DELETE
    case  PUT
}

enum pokemonURL: String {
    case pokemon = "https://pokeapi.co/api/v2/pokemon/"
    case pokemonList = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=1154"
    case pokemonImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/"
    
    func getValue(_ id: String?)->String{
        switch self {
        case .pokemon:
            guard id != nil else { return self.rawValue}
            return self.rawValue + id!
        case .pokemonList:
            return self.rawValue
        case .pokemonImage:
            guard id != nil else { return self.rawValue}
            return self.rawValue + id! + ".png"
        }
    }
}


class Request {
    
    var request : URLRequest?
    var session : URLSession?
    
    static let shared = Request()
    
    public func request<T: Decodable>(_ : T.Type, path: String, method: HttpMethod = .GET, parameters: [String: Any]? = nil, completion: @escaping ( Result<T, Error>) -> Void) {
        
        guard let url = URL(string: path) else {
            completion(.failure(APIErrors.invalidURL))
            return
        }
        request = URLRequest(url: url)
        
        
        if let params = parameters {
            
            let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            
            request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request?.httpBody = jsonData
        }
        request?.httpMethod = method.rawValue
        
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 99
        configuration.timeoutIntervalForResource = 99
        session = URLSession(configuration: configuration)
        
        
        session?.dataTask(with: request! as URLRequest) { (data, response, error) -> Void in
            if let data = data {
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    do {
                        let decoded: T = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decoded))
                        return
                    } catch {
                        completion(.failure(APIErrors.unknownError))
                        return
                    }
                } else {
                    completion(.failure(APIErrors.internalServerError))
                    return
                }
            } else {
                completion(.failure(APIErrors.requestFailed))
                return
            }
        }.resume()
    }
}
