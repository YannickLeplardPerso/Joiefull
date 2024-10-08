//
//  JFCatalog.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 07/10/2024.
//

import Foundation



struct Picture: Decodable {
    let url: String
    let description: String
}

struct ClothingItem: Decodable, Identifiable {
    let id: Int
    let picture: Picture
    let name: String
    let category: String
    let likes: Int
    let price: Double
    let original_price: Double
}
