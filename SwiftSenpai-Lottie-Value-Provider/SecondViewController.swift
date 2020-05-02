//
//  SecondViewController.swift
//  SwiftSenpai-Lottie-Value-Provider
//
//  Created by Lee Kah Seng on 01/05/2020.
//  Copyright © 2020 Lee Kah Seng. All rights reserved.
//

import UIKit
import Lottie

class SecondViewController: UIViewController {
    
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var progressSlider: UISlider!
    
    var displayLink: CADisplayLink?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup animation view
        let animation = Animation.named("19633-voice-video-switch")
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        
        // Apply changes using value provider
        applyAnimationChange()
        
        // Log keypaths
        animationView.logHierarchyKeypaths()
        
        // Create a display link to make slider track with animation progress.
        displayLink = CADisplayLink(target: self, selector: #selector(animationCallback))
        displayLink?.add(to: .current, forMode: RunLoop.Mode.default)
    }

    @IBAction func playButtonTapped(_ sender: Any) {
        animationView.play(fromProgress: 0, toProgress: 1, loopMode: .playOnce, completion: nil)
    }
    
    @IBAction func progressSliderValueChanged(_ sender: UISlider) {
        animationView.currentProgress = CGFloat(sender.value)
    }
    
    @objc func animationCallback() {
      if animationView.isAnimationPlaying {
        progressSlider.value = Float(animationView.realtimeAnimationProgress)
      }
    }
    
    private func applyAnimationChange() {
        
        // Slightly move up center circle
        let pointValueDeveloper = PointValueProvider(CGPoint(x: -18, y: 80))
        let centrePositionKeyPath = AnimationKeypath(keypath: "Centre.Rectangle 1.Position")
        animationView.setValueProvider(pointValueDeveloper, keypath: centrePositionKeyPath)

        
        // Create gradient colors
        let color1 = Color(r: (0/255), g: (80/255), b: (115/255), a: 1)
        let color2 = Color(r: (113/255), g: (199/255), b: (236/255), a: 1)
        let gradientValueProvider = GradientValueProvider([color1, color2])

        // Set gradient provider
        // Touch.Rectangle 1.Gradient Stroke 1.Colors
        // Left.Rectangle 1.Gradient Stroke 1.Colors
        // Right.Rectangle 1.Gradient Stroke 1.Colors
        // Centre.Rectangle 1.Gradient Stroke 1.Colors
        let gradientKeyPath = AnimationKeypath(keypath: "**.**.**.Colors")
        animationView.setValueProvider(gradientValueProvider, keypath: gradientKeyPath)
        
        
        // Set color of foot rectangle
        let colorValueProvider = ColorValueProvider(color1)
        let footKeyPath = AnimationKeypath(keypath: "Foot.Rectangle 1.Stroke 1.Color")
        animationView.setValueProvider(colorValueProvider, keypath: footKeyPath)
    }
}

