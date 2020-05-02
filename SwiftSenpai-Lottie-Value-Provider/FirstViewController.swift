//
//  FirstViewController.swift
//  SwiftSenpai-Lottie-Value-Provider
//
//  Created by Lee Kah Seng on 01/05/2020.
//  Copyright © 2020 Lee Kah Seng. All rights reserved.
//

import UIKit
import Lottie

class FirstViewController: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var progressSlider: UISlider!
    
    var displayLink: CADisplayLink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup animation view
        let animation = Animation.named("TwitterHeart")
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
        
        // Create ColorValueProvider using Lottie's Color class
        let orange = Color(r: (251/255), g: (140/255), b: (0/255), a: 1)
        let orangeColorValueProvider = ColorValueProvider(orange)
        
        // Set color value provider to animation view
        // H1.Shape 1.Fill 1.Color
        // H2.Shape 1.Fill 1.Color
        let keyPath = AnimationKeypath(keypath: "**.Shape 1.Fill 1.Color")
        animationView.setValueProvider(orangeColorValueProvider, keypath: keyPath)
        
        
        // Scale up dots & ellipse
        let scaleValueProvider = SizeValueProvider(CGSize(width: 200, height: 200))
        let dotKeyPath = AnimationKeypath(keypath: "Dot*.Shape 1.Scale")
        animationView.setValueProvider(scaleValueProvider, keypath: dotKeyPath)
        // C1.Ellipse 1.Scale
        // C2.Ellipse 1.Scale
        let ellipseKeyPath = AnimationKeypath(keypath: "C*.Ellipse 1.Scale")
        animationView.setValueProvider(scaleValueProvider, keypath: ellipseKeyPath)
        
        
        // Change dots opacity (range 0 ~ 100)
        let opacityValueProvider = FloatValueProvider(CGFloat(50))
        let dotOpacityKeyPath = AnimationKeypath(keypath: "Dot*.Shape 1.Opacity")
        animationView.setValueProvider(opacityValueProvider, keypath: dotOpacityKeyPath)
    }
}

