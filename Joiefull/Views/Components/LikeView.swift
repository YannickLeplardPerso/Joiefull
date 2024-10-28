//
//  LikeView.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 09/10/2024.
//

import SwiftUI

struct LikeView: View {
    // temp
    @State private var isLiked = false // Track whether the item is liked
    
    let likes: Int
    
    var body: some View {
        HStack {
            // temp
            Button(action: {
                isLiked.toggle() // Toggle liked state
            }) {
                Image(systemName: "heart.fill")
                    .foregroundColor(isLiked ? .yellow : .gray) // Change color when liked
                    .bold()
            }
            Text("\(likes)")
                .bold()
//            Image(systemName: "heart")
//                .bold()
//            Text("\(likes)")
//                .bold()
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(20)
        
        
    }
}

#Preview {
    ZStack {
        Color.gray
            .ignoresSafeArea()
        LikeView(likes: 10)
    }
}
