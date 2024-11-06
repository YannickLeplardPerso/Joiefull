//
//  JFCatalog.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 07/10/2024.
//

import Foundation



enum JFClothingCategory: String, CaseIterable, Codable {
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

struct JFPicture: Decodable {
    let url: URL
    let description: String
}

struct JFClothingItem: Decodable, Identifiable {
    let id: Int
    let picture: JFPicture
    let name: String
    let category: JFClothingCategory
    let likes: Int
    let price: Double
    let original_price: Double
    
    let note = String(format: "%.2f", Double.random(in: 3.0...5.0))
    var isLiked: Bool = false
    
    var categoryFr: String {
        return category.localized
    }
    
    // pour décoder uniquement les éléments du JSON
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        picture = try container.decode(JFPicture.self, forKey: .picture)
        name = try container.decode(String.self, forKey: .name)
        category = try container.decode(JFClothingCategory.self, forKey: .category)
        likes = try container.decode(Int.self, forKey: .likes)
        price = try container.decode(Double.self, forKey: .price)
        original_price = try container.decode(Double.self, forKey: .original_price)
    }
    
    // initialisation pour previews
    init(id: Int, picture: JFPicture, name: String, category: JFClothingCategory, likes: Int, price: Double, original_price: Double, isLiked: Bool = false) {
        self.id = id
        self.picture = picture
        self.name = name
        self.category = category
        self.likes = likes
        self.price = price
        self.original_price = original_price
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case picture
        case name
        case category
        case likes
        case price
        case original_price
    }
}
