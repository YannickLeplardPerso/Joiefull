//
//  JFCatalogViewModel.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 07/10/2024.
//

import SwiftUI
import Combine



class JFCatalogViewModel: ObservableObject {
    @Published var clothes: [JFClothingItem] = []
    @Published var isLoading: Bool = false
    @Published var error: JFError = .no
    
    private let apiService: JFAPIService
    
    init(apiService: JFAPIService = JFAPIService()) {
        self.apiService = apiService
    }
    
    var categories: [String] {
        Array(Set(clothes.map { $0.categoryFr })).sorted()
    }
    
    func fetchClothes() async {
        await MainActor.run {
            isLoading = true
            error = .no
        }
        
        do {
            let clothes = try await apiService.askForClothes()
            await MainActor.run {
                self.clothes = clothes
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.error = .fetchClothes
                self.isLoading = false
            }
        }
    }
    
//    func fetchClothes() {
//        Task {
//            await fetchClothesAsync()
//        }
//    }
//    
//    @MainActor
//    private func fetchClothesAsync() async {
//        isLoading = true
//        error = .no
//        
//        do {
//            let clothes = try await apiService.askForClothes()
//            self.clothes = clothes
//            self.isLoading = false
//        } catch {
//            self.error = .fetchClothes
//            self.isLoading = false
//        }
//    }
    
    func toggleLike(for item: JFClothingItem) {
        if let index = clothes.firstIndex(where: { $0.id == item.id }) {
            clothes[index].isLiked.toggle()
        }
    }
}
