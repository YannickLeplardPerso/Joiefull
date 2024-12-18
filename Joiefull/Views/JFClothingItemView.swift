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
                        .accessibilityHidden(true)
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
                                                .frame(width: 44, height: 44)
                                            
                                            Image("Partager")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 18, height: 18)
                                        }
                                        .padding([.top, .trailing], 16)
                                    }
                                    .accessibilityLabel("Partager \(item.name)")
                                    .accessibilityAddTraits(.isButton)
                                    .accessibilityHint("Double tap pour partager")
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
                                    .accessibilityLabel(item.isLiked ? "J'aime déjà \(item.name)" : "Ajouter \(item.name) aux favoris")
                                    .accessibilityAddTraits(.isButton)
                                    .accessibilityHint("Double tap pour \(item.isLiked ? "retirer des" : "ajouter aux") favoris")
                                }
                            }
                        )
                } placeholder: {
                    ProgressView()
                        .accessibilityLabel("Chargement de l'image")
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
                    Text(item.note)
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("\(item.name), Note : \(item.note)")
                .padding(.bottom, 5)
                
                HStack {
                    Text("\(item.price, specifier: "%.2f") €")
                        .font(.subheadline)
                    Spacer()
                    Text("\(item.original_price, specifier: "%.2f") €")
                        .font(.subheadline)
                        .strikethrough()
                }
                .accessibilityLabel("Prix: \(String(format: "%.2f", item.price)) euros, au lieu de \(String(format: "%.2f", item.original_price)) euros")
                .padding(.bottom, 5)
                
                // description
                Text(item.picture.description)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                    .accessibilityLabel("Description: \(item.picture.description)")
                
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
                        .accessibilityHidden(true)
                    
                    HStack {
                        ForEach(1..<6) { star in
                            Image(systemName: star <= rating ? "star.fill" : "star")
                                .resizable()
                                .frame(width: 44, height: 44)
                                .contentShape(Rectangle())
                                .foregroundColor(star <= rating ? .yellow : .gray)
                                .onTapGesture {
                                    rating = star
                                }
                                .accessibilityHidden(true)  // Cache les étoiles individuelles pour VoiceOver
                        }
                    }
                    .accessibilityElement(children: .combine)  // Combine tout en un seul élément
                    .accessibilityLabel("Notation")
                    .accessibilityValue("\(rating) étoiles sur 5")
                    .accessibilityAddTraits(.allowsDirectInteraction)
                    .accessibilityAdjustableAction { direction in
                        switch direction {
                        case .increment:
                            if rating < 5 {
                                rating += 1
                            } else {
                                UIAccessibility.post(notification: .announcement, argument: "Maximum atteint : 5 étoiles")
                            }
                        case .decrement:
                            if rating > 0 {
                                rating -= 1
                            } else {
                                UIAccessibility.post(notification: .announcement, argument: "Minimum atteint : 0 étoiles")
                            }
                        @unknown default:
                            break
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
                    .accessibilityLabel("Votre avis sur \(item.name)")
                    .accessibilityHint("Écrivez votre impression sur ce vêtement")
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
