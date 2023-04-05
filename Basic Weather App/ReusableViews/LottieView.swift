//
//  LottieView.swift
//  Basic Weather App
//
//  Created by Ayan Chakraborty on 05/04/23.
//

import SwiftUI
import Lottie

enum LottieFiles: String {
    case clearSky = "clear-sky-clouds-loop"
    case rainy = "rain"
}

struct LottieView: UIViewRepresentable {
    
    var lottieFile: LottieFiles
    var loopMode: LottieLoopMode = .playOnce
    var animationView = LottieAnimationView()
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()
        
        animationView.animation = LottieAnimation.named(lottieFile.rawValue)
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = loopMode
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        animationView.play()
    }
}
