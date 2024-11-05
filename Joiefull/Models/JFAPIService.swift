//
//  APIService.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 07/10/2024.
//

import Foundation



class JFAPIService {
    
    static let BASE_URL = URL(string: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/api/clothes.json")
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
            self.session = session
        }

    
    func createClothesRequest() -> URLRequest {
        guard let url = JFAPIService.BASE_URL else {
            fatalError("URL invalide")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }

    func askForClothes() async throws -> [JFClothingItem] {
        let (data, response) = try await session.data(for: createClothesRequest())
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw JFError.requestResponse
        }
        
        switch httpResponse.statusCode {
        case 200:
            do {
                let clothes = try JSONDecoder().decode([JFClothingItem].self, from: data)
                return clothes
            } catch {
                throw JFError.decodingJSON
            }
        default:
            throw JFError.requestDefault
        }
    }    
}


