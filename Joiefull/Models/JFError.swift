//
//  JFError.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 07/10/2024.
//

import Foundation



enum JFError: Error, LocalizedError {
    case no
    case requestResponse
    case requestDefault
    case decodingJSON
    case fetchClothes
    
    var errorDescription: String? {
        switch self {
        case .no:
            return "ok"
        case .requestResponse:
            return "erreur réponse requête"
        case .requestDefault:
            return "erreur requête"
        case .decodingJSON:
            return "erreur décodage JSON"
        case .fetchClothes:
            return "erreur récupération articles"
        }
    }
}
