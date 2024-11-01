//
//  JFActivityViewController.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 28/10/2024.
//

import SwiftUI



struct JFActivityViewController: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return activityController
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
