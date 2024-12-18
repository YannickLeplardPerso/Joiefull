//
//  JFSplashScreenView.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 07/10/2024.
//

import SwiftUI

struct JFSplashScreenView: View {
    private let splashScreenDuration: TimeInterval = 2
    @State private var isActive = false

    var body: some View {
        VStack {
            if isActive {
                JFCatalogView()
            } else {
                ZStack {
                    Color(.colorJFOrange)
                        .edgesIgnoringSafeArea(.all)
                    
                    if UIDevice.current.userInterfaceIdiom == .pad {
                                            Image("SplashScreenLogoForTablet")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 359, height: 90)
                                        } else {
                                            Image("SplashScreenLogoForPhone")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 199, height: 50)
                                        }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + splashScreenDuration) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    JFSplashScreenView()
}
