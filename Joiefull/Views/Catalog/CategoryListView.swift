//
//  CategoryListView.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 08/10/2024.
//

import SwiftUI



struct CategoryListView: View {
    @ObservedObject var viewModel: CatalogViewModel
    @Binding var selectedItem: ClothingItem?

    var body: some View {
        List {
            let listFr = Set(viewModel.clothes.map { $0.categoryFr })
            
            ForEach(listFr.sorted(), id: \.self) { translatedCategory in
                Section(header: Text(translatedCategory)
                    .font(.title2)
                    .foregroundStyle(.black)
                    .bold()
                ) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            let filteredItems = viewModel.clothes.filter { $0.categoryFr == translatedCategory }
                            
                            ForEach(filteredItems) { item in
                                if UIDevice.current.userInterfaceIdiom == .pad {
                                    ClothingItemCardView(item: item)
                                        .foregroundColor(.primary)
                                        .frame(width: 198, height: 242)
                                        .onTapGesture {
                                            selectedItem = item
                                        }
                                } else {
                                    NavigationLink(destination: ClothingItemView(item: item)) {
                                        ClothingItemCardView(item: item)
                                            .foregroundColor(.primary)
                                            .frame(width: 198, height: 242)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView(
            viewModel: CatalogViewModel.mock(),
            selectedItem: .constant(nil)
        )
    }
}
