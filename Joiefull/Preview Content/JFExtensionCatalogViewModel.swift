//
//  JFExtensionCatalogViewModel.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 31/10/2024.
//

import Foundation



extension JFCatalogViewModel {
    static func mock() -> JFCatalogViewModel {
        let viewModel = JFCatalogViewModel()
        viewModel.clothes = [
            JFClothingItem(id: 1, picture: JFPicture(url: URL(string: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/1.jpg")!, description: "Shoes"),
                         name: "Sneakers", category: .shoes, likes: 30, price: 59.99, original_price: 89.99),
            JFClothingItem(id: 2, picture: JFPicture(url: URL(string: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/bottoms/2.jpg")!, description: "Pendentif rond bleu dans la main d'une femme"),
                         name: "T-Shirt", category: .accessories, likes: 35, price: 19.99, original_price: 29.99)
        ]
        return viewModel
    }
}
