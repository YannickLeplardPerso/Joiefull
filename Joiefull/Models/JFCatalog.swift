//
//  JFCatalog.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 07/10/2024.
//

import Foundation



enum ClothingCategory: String, CaseIterable, Codable {
    case accessories = "ACCESSORIES"
    case bottoms = "BOTTOMS"
    case shoes = "SHOES"
    case tops = "TOPS"
    
    var localized: String {
        switch self {
        case .accessories: return "Accessoires"
        case .bottoms: return "Bas"
        case .shoes: return "Chaussures"
        case .tops: return "Hauts"
        }
    }
}

struct Picture: Decodable {
    let url: String
    let description: String
}

struct ClothingItem: Decodable, Identifiable {
    let id: Int
    let picture: Picture
    let name: String
    let category: ClothingCategory
    let likes: Int
    let price: Double
    let original_price: Double
    
    var categoryFr: String {
        return category.localized
    }
}
