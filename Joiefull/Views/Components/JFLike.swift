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
                .frame(minWidth: 44, minHeight: 44)
                .contentShape(Rectangle())  
        }
        .disabled(!isLikeEnabled)     
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
