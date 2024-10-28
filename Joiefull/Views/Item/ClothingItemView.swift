//
//  ClothingItemView.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 08/10/2024.
//

import SwiftUI

struct ClothingItemView: View {
    let item: ClothingItem
    @State private var rating: Int = 0
    @State private var feedback: String = ""
    // temp
    @State private var isSharing = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: item.picture.url)) { image in
                    image.resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .overlay(
                            VStack {
                                HStack {
                                    Spacer()
                                    // Share button functionality
                                    Button(action: {
                                        isSharing.toggle()
                                    }) {
                                        Image("Partager")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 18, height: 18)
                                            .padding([.top, .trailing], 16)
                                    }
                                    .sheet(isPresented: $isSharing) {
                                        ActivityViewController(activityItems: [item.picture.url])
                                                            }
//                                    Image("Partager")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 18, height: 18)
//                                        .padding(16)
                                }
                                
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    LikeView(likes: item.likes)
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
                    Text("4.3")
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
                    // remplacer par avatar ?
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
                    //.frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: 392)
        }
    }
}

// temp
// UIActivityViewController wrapper for SwiftUI
struct ActivityViewController: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}



struct ClothingItemView_Previews: PreviewProvider {
    static var previews: some View {
        ClothingItemView(item: ClothingItem.mock())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
