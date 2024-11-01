//
//  LikeView.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 09/10/2024.
//

import SwiftUI



struct JFLike: View {
    var isLiked: Bool
    var toggleLike: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "heart.fill")
                .foregroundColor(isLiked ? .red : .gray)
                .bold()
                .onTapGesture {
                    toggleLike()
                }
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(20)
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
