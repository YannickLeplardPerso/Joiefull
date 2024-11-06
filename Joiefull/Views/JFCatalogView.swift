//
//  JFCatalogView.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 07/10/2024.
//

import SwiftUI



struct JFCatalogView: View {
    @StateObject private var viewModel = JFCatalogViewModel()
    @State private var selectedItem: JFClothingItem?

    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            NavigationSplitView {
                JFCategoryListView(viewModel: viewModel, selectedItem: $selectedItem)
                    .navigationSplitViewColumnWidth(min: 600, ideal: 800, max: 1000)
            } detail: {
                if let selectedIndex = selectedItem.flatMap({ item in
                    viewModel.clothes.firstIndex(where: { $0.id == item.id })
                }) {
                    JFClothingItemView(viewModel: viewModel, item: viewModel.clothes[selectedIndex])
                        .navigationSplitViewColumnWidth(min: 200, ideal: 300, max: 400)
                } else {
                    Text("Choisissez un article")
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .accessibilityElement(children: .contain)
            .onAppear {
                Task {
                    await viewModel.fetchClothes()
                }
            }
        } else {
            NavigationView {
                JFCategoryListView(viewModel: viewModel, selectedItem: $selectedItem)
            }
            .onAppear {
                Task {
                    await viewModel.fetchClothes()
                }
            }
        }
    }
}


struct JFCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        JFCatalogView()
    }
}
