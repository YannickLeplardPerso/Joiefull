//
//  JFCatalogViewModel.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 07/10/2024.
//

import SwiftUI
import Combine



class ClothesViewModel: ObservableObject {
    @Published var clothes: [ClothingItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
        
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
