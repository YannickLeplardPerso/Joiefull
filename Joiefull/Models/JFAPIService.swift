//
//  APIService.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 07/10/2024.
//

import Foundation



class JFAPIService {
    static let BASE_URL = "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/api/clothes.json"
    
    func createClothesRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: JFAPIService.BASE_URL)!)
        request.httpMethod = "GET"
        return request
    }

    func askForClothes() async throws -> [ClothingItem] {
        let (data, response) = try await URLSession.shared.data(for: createClothesRequest())
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw JFError.requestResponse
        }
        
        switch httpResponse.statusCode {
        case 200:
            do {
                let clothes = try JSONDecoder().decode([ClothingItem].self, from: data)
                return clothes
            } catch {
                throw JFError.decodingJSON
            }
        default:
            throw JFError.requestDefault
        }
    }    
}


