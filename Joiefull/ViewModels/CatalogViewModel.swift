//
//  JFCatalogViewModel.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 07/10/2024.
//

import SwiftUI
import Combine



class CatalogViewModel: ObservableObject {
    @Published var clothes: [ClothingItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    var categories: [String] {
        Array(Set(clothes.map { $0.categoryFr })).sorted()
    }
        
    func fetchClothes() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let clothes = try await JFAPIService().askForClothes()
                DispatchQueue.main.async {
                    self.clothes = clothes
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to fetch clothes"
                    self.isLoading = false
                }
            }
        }
    }
}

extension CatalogViewModel {
    static func mock() -> CatalogViewModel {
        let viewModel = CatalogViewModel()
        viewModel.clothes = [
            ClothingItem(id: 1, picture: Picture(url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/1.jpg", description: "Shoes"),
                         name: "Sneakers", category: .shoes, likes: 30, price: 59.99, original_price: 89.99),
            ClothingItem(id: 2, picture: Picture(url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/bottoms/2.jpg", description: "Pendentif rond bleu dans la main d'une femme"),
                         name: "T-Shirt", category: .accessories, likes: 35, price: 19.99, original_price: 29.99)
        ]
        return viewModel
    }
}

extension ClothingItem {
    static func mock() -> ClothingItem {
        return ClothingItem(id: 1, picture: Picture(url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/bottoms/2.jpg", description: "Shoes from space of the opera... black and white"),
                            name: "Sneakers", category: .bottoms, likes: 12, price: 59.99, original_price: 89.99)
    }
}
