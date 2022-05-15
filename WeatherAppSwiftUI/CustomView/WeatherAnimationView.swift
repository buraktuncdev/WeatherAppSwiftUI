//
//  LottieView.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 16.05.22.
//

import SwiftUI
import Lottie

struct WeatherAnimationView: UIViewRepresentable {

    var fileName: String
    var loopMode: LottieLoopMode = .loop

    func makeUIView(context: UIViewRepresentableContext<WeatherAnimationView>) -> some UIView {
        let view = UIView()
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<WeatherAnimationView>) {
        uiView.subviews.forEach({ $0.removeFromSuperview() })

        let animationView = AnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        uiView.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: uiView.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: uiView.heightAnchor)
        ])

        animationView.animation = Animation.named(fileName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
    }
}
