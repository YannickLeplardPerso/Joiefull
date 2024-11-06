//
//  JFCategoryListView.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 08/10/2024.
//

import SwiftUI



struct JFCategoryListView: View {
    @ObservedObject var viewModel: JFCatalogViewModel
    @Binding var selectedItem: JFClothingItem?

    var body: some View {
        List {
            let listFr = Set(viewModel.clothes.map { $0.categoryFr })
            
            ForEach(listFr.sorted(), id: \.self) { translatedCategory in
                Section(header: Text(translatedCategory)
                    .font(.title2)
                    .foregroundStyle(.black)
                    .bold()
                    .accessibilityAddTraits(.isHeader)
                ) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            let filteredItems = viewModel.clothes.filter { $0.categoryFr == translatedCategory }
                            
                            ForEach(filteredItems) { item in
                                if UIDevice.current.userInterfaceIdiom == .pad {
                                    JFClothingItemCardView(viewModel: viewModel, item: item)
                                        .foregroundColor(.primary)
                                        .frame(width: 198, height: 242)
                                        .onTapGesture {
                                            selectedItem = item
                                        }
                                        .accessibilityLabel("\(item.name) \(item.price), dans la catégorie \(translatedCategory)")
                                        .accessibilityAddTraits(.isButton)
                                        .accessibilityHint("Double tap pour voir les détails")
                                } else {
                                    NavigationLink(destination: JFClothingItemView(viewModel: viewModel, item: item)) {
                                        JFClothingItemCardView(viewModel: viewModel, item: item)
                                            .foregroundColor(.primary)
                                            .frame(width: 198, height: 242)
                                    }
                                    .accessibilityLabel("\(item.name) \(String(format: "%.2f", item.price)) euros, dans la catégorie \(translatedCategory)")
                                    .accessibilityAddTraits(.isButton)
                                    .accessibilityHint("Double tap pour voir les détails")
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

struct JFCategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        JFCategoryListView(
            viewModel: JFCatalogViewModel.mock(),
            selectedItem: .constant(nil)
        )
    }
}
