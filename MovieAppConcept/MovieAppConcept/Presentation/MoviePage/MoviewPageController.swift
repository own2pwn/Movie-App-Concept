//
//  MoviewPageController.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 01.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

final class MoviewPageController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet var topContainer: UIView!
    
    @IBOutlet var movieImage: UIImageView!
    
    @IBOutlet var closeButton: EPButton!
    
    @IBOutlet var bookmarkButton: EPButton!
    
    @IBOutlet var playButton: EPButton!
    
    @IBOutlet var videoContainer: UIView!
    
    @IBOutlet var nextScreenButton: EPButton!
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    // MARK: - Methods
    
    private func setupScreen() {
        setup()
    }
    
    private func setup() {
        let setup = [setColors, setupMovieImage, setupButtons]
        setup.forEach { $0() }
    }
    
    private func setColors() {
        view.backgroundColor = CUI.MoviePage.backgroundColor
    }
    
    private func setupMovieImage() {
        movieImage.layer.cornerRadius = 8
        
        // add fade layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = movieImage.frame
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.9).cgColor, UIColor.clear.cgColor]
        gradientLayer.opacity = 0.35
        movieImage.layer.addSublayer(gradientLayer)
    }
    
    private func setupButtons() {
        let btns = [bookmarkButton!, playButton!, closeButton!]
        btns.forEach {
            $0.normalTintColor = #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1)
            $0.highlightTintColor = #colorLiteral(red: 0.7422102094, green: 0.764362216, blue: 0.7821244597, alpha: 1)
            $0.adjustsImageWhenHighlighted = false
        }
        
        closeButton.isCheckable = false
        closeButton.onPrimaryAction = stopVideo
        
        bookmarkButton.normalImage = #imageLiteral(resourceName: "ic_heart_normal")
        bookmarkButton.selectedImage = #imageLiteral(resourceName: "ic_heart_selected")
        
        playButton.isCheckable = false
        playButton.onPrimaryAction = playVideo
        
        nextScreenButton.makeFlat()
        nextScreenButton.normalColor = nextScreenButton.backgroundColor
        nextScreenButton.highlightColor = nextScreenButton.normalColor?.withAlphaComponent(0.8)
        
        nextScreenButton.isCheckable = false
        nextScreenButton.isSelectable = false
        nextScreenButton.onPrimaryAction = showPicker
    }
    
    // MARK: - Actions
    
    @IBAction func bookmarkMovie(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    private func showPicker(_ sender: EPButton) {
        performSegue(withIdentifier: "showPicker", sender: self)
    }
    
    private func playVideo(_ sender: EPButton) {
        topContainer.bringSubview(toFront: videoContainer)
        EPMediaPlayer.shared.play("vid_back_to_the_future.mp4", in: videoContainer)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35, execute: animateVideoTransition)
    }
    
    private func animateVideoTransition() {
        UIView.animate(withDuration: 0.25) { [closeButton = closeButton!, topContainer = topContainer!] in
            closeButton.alpha = 1
            topContainer.bringSubview(toFront: closeButton)
        }
    }
    
    private func stopVideo(_ sender: EPButton) {
        EPMediaPlayer.shared.stop()
        
        UIView.animate(withDuration: 0.25) { [closeButton = closeButton!, videoContainer = videoContainer!, topContainer = topContainer!] in
            closeButton.alpha = 0
            topContainer.sendSubview(toBack: closeButton)
            topContainer.sendSubview(toBack: videoContainer)
        }
    }
}
