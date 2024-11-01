//
//  JFRandomNote.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 30/10/2024.
//

import SwiftUI


// composant temporaire car il n'y a pas possibilité de calculer et mettre à jour la note moyenne : donc on affiche une note aléatoire entre 3 et 5
struct JFRandomNote: View {
    
    var body: some View {
        let note = Double.random(in: 3.0...5.0)
        Text(String(format: "%.1f", note))
            .padding(.trailing, 5)
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
