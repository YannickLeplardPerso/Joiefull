//
//  JFClothingItemCardView.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 08/10/2024.
//

import SwiftUI

struct JFClothingItemCardView: View {
    @ObservedObject var viewModel: JFCatalogViewModel
    let item: JFClothingItem
    
    var body: some View {
        VStack {
            ZStack {
                AsyncImage(url: item.picture.url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill) //.fit
                        .frame(width: 198, height: 198)
                        .cornerRadius(20)
                        .padding()
                } placeholder: {
                    ProgressView()
                }
                                    
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        JFLike(isLiked: item.isLiked) {
                            viewModel.toggleLike(for: item)
                        }
                    }
                }
                .padding([.bottom, .trailing], 20)
            }
            .frame(width: 198, height: 198)
            
            HStack {
                Text(item.name)
                    .bold()
                    .padding(.leading, 5)
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundColor(.colorJFOrange)
                JFRandomNote()
            }
            .frame(width: 198)
            
            HStack {
                Text("\(item.price, specifier: "%.2f") €")
                    .font(.subheadline)
                    .padding(.leading, 5)
                Spacer()
                Text("\(item.original_price, specifier: "%.2f") €")
                    .font(.subheadline)
                    .strikethrough()
                    .padding(.trailing, 5)
            }
            .frame(width: 198)
            .padding(.horizontal, 50)
        }
    }
}

//struct JFClothingItemCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClothingItemCardView(viewModel: CatalogViewModel(), item: ClothingItem.mock())
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
