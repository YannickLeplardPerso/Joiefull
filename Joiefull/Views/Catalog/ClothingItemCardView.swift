//
//  ClothingItemCardView.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 08/10/2024.
//

import SwiftUI

struct ClothingItemCardView: View {
    let item: ClothingItem
    
    var body: some View {
        VStack {
            ZStack {
                AsyncImage(url: URL(string: item.picture.url)) { image in
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
                        LikeView(likes: item.likes)
                            .padding([.bottom, .trailing], 8)
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
                // todo
                Text("4.3")
                    .padding(.trailing, 5)
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

struct ClothingItemCardView_Previews: PreviewProvider {
    static var previews: some View {
        ClothingItemCardView(item: ClothingItem.mock())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
