//
//  LikeView.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 09/10/2024.
//

import SwiftUI



struct JFLike: View {
    var isLiked: Bool
    var isLikeEnabled: Bool = true
    var toggleLike: () -> Void
    
    var body: some View {
        Button(action: toggleLike) {
            Image(systemName: "heart.fill")
                .foregroundColor(isLiked ? .red : .gray)
                .bold()
                .padding(8)
                .background(Color.white)
                .cornerRadius(20)
        }
        .disabled(!isLikeEnabled)
//        .accessibilityLabel(isLiked ? "J'aime déjà \(item.name)" : "Ajouter \(item.name) aux favoris")
//        .accessibilityAddTraits(.isButton)
//        .accessibilityHint("Double tap pour \(isLiked ? "retirer" : "ajouter") des favoris")      
    }
}



#Preview {
    @Previewable @State var isLiked = false
    
    ZStack {
        Color.gray
            .ignoresSafeArea()
        JFLike(isLiked: isLiked) {
            isLiked.toggle()
        }
    }
}
