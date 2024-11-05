//
//  JFClothingItemView.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 08/10/2024.
//

import SwiftUI



struct JFClothingItemView: View {
    @ObservedObject var viewModel: JFCatalogViewModel
    let item: JFClothingItem
    @State private var rating: Int = 0
    @State private var feedback: String = ""
    @State private var isSharing = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: item.picture.url) { image in
                    image.resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .overlay(
                            VStack {
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        isSharing.toggle()
                                    }) {
                                        ZStack {
                                            Circle()
                                                .fill(Color.white.opacity(0.4))
                                                .frame(width: 36, height: 36)
                                            
                                            Image("Partager")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 18, height: 18)
                                        }
                                        .padding([.top, .trailing], 16)
//                                        Image("Partager")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: 18, height: 18)
//                                            .padding([.top, .trailing], 16)
//                                            .background(
//                                                Circle()
//                                                    .fill(Color.white.opacity(0.5))
//                                                    .frame(width: 30, height: 30)
//                                            )
                                    }
                                    .sheet(isPresented: $isSharing) {
                                        JFActivityViewController(activityItems: ["\(item.name) - Price: \(item.price)€", item.picture.url])
                                    }
                                }
                                
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    JFLike(isLiked: item.isLiked) {
                                        viewModel.toggleLike(for: item)
                                    }
                                    .padding(16)
                                }
                            }
                        )
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 5)
                .padding(.bottom, 10)
                
                HStack {
                    Text(item.name)
                        .bold()
                    Spacer()
                    Image(systemName: "star.fill")
                        .foregroundColor(.colorJFOrange)
                    JFRandomNote()
                }
                .padding(.bottom, 5)
                
                HStack {
                    Text("\(item.price, specifier: "%.2f") €")
                        .font(.subheadline)
                    Spacer()
                    Text("\(item.original_price, specifier: "%.2f") €")
                        .font(.subheadline)
                        .strikethrough()
                }
                .padding(.bottom, 5)
                
                // description
                Text(item.picture.description)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                
                // stars
                HStack {
                    // à remplacer par avatar
                    Image(systemName: "figure.climbing")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        .padding(.trailing, 10)
                    
                    HStack {
                        ForEach(1..<6) { star in
                            Image(systemName: star <= rating ? "star.fill" : "star")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(star <= rating ? .yellow : .gray)
                                .onTapGesture {
                                    rating = star
                                }
                        }
                    }
                }
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // impressions
                TextField("Partagez ici votre impression sur cette pièce", text: $feedback, axis: .vertical)
                    .lineLimit(3...10)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: 392)
        }
    }
}



struct JFClothingItemView_Previews: PreviewProvider {
    static var previews: some View {
        JFClothingItemView(viewModel: JFCatalogViewModel(), item: JFClothingItem.mock())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
