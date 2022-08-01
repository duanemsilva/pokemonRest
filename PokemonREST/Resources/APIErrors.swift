//
//  APIErrors.swift
//  PokemonREST
//
//  Created by Duane de Moura Silva on 25/07/22.
//

import Foundation

public enum APIErrors: Error {
    case invalidURL
    case requestFailed
    case invalidCredentials
    case internalServerError
    case unknownError
    case none
    
    /// Friendly description of the error
    public var description: String {
        switch self {
        case .invalidURL:
            return "URL inválida"
        case .requestFailed:
            return "A requisição falhou!"
        case .invalidCredentials:
            return "Credenciais inválidas"
        case .internalServerError:
            return "Erro no servidor"
        case .unknownError:
            return "Ocorreu algum erro! Tente novamente"
        case .none:
            return ""
        }
    }
}
