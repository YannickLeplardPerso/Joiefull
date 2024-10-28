//
//  ContentView.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 07/10/2024.
//

import SwiftUI

struct CatalogView: View {
    @StateObject private var viewModel = CatalogViewModel()
    @State private var selectedItem: ClothingItem?
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            NavigationSplitView {
                CategoryListView(viewModel: viewModel, selectedItem: $selectedItem)
            } detail: {
                //ClothingItemCardView(item: item)
            }
            .onAppear {
                viewModel.fetchClothes()
            }
        } else {
            NavigationView {
                CategoryListView(viewModel: viewModel, selectedItem: $selectedItem)
            }
            .onAppear {
                viewModel.fetchClothes()
            }
        }
    }
}


struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Preview for iPad
            CatalogView()
                .previewDevice("iPad Pro (12.9-inch)")
                .previewDisplayName("iPad Pro (12.9-inch)")
            
            // Preview for iPhone
            CatalogView()
                .previewDevice("iPhone 14 Pro")
                .previewDisplayName("iPhone 14 Pro")
        }
    }
}
