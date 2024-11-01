//
//  JFExtensionClothingItem.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 31/10/2024.
//

import Foundation



extension JFClothingItem {
    static func mock() -> JFClothingItem {
        return JFClothingItem(id: 1, picture: JFPicture(url: URL(string: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/bottoms/2.jpg")!, description: "Shoes from space of the opera... black and white"),
                            name: "Sneakers", category: .bottoms, likes: 12, price: 59.99, original_price: 89.99)
    }
}
