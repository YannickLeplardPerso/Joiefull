//
//  ContentView.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 07/10/2024.
//

import SwiftUI

struct CatalogView: View {
    @StateObject private var viewModel = ClothesViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(viewModel.clothes) { item in
                    HStack {
                        AsyncImage(url: URL(string: item.picture.url)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                        } placeholder: {
                            ProgressView()
                        }
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.category)
                                .font(.subheadline)
                            Text("Price: \(item.price, specifier: "%.2f") €")
                                .font(.body)
                        }
                    }
                }
                .navigationTitle("Clothes")
            }
        }
        .onAppear {
            viewModel.fetchClothes()
        }
    }
}

//#Preview {
//    CatalogView()
//}
