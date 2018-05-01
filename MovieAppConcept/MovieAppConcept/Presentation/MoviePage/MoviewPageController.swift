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
    
    @IBOutlet var bookmarkButton: EPButton!
    
    @IBOutlet var playButton: EPButton!
    
    @IBOutlet var videoContainer: UIView!
    
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
        bookmarkButton.normalTintColor = #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1)
        bookmarkButton.highlightTintColor = #colorLiteral(red: 0.7422102094, green: 0.764362216, blue: 0.7821244597, alpha: 1)
        bookmarkButton.normalImage = #imageLiteral(resourceName: "ic_heart_normal")
        bookmarkButton.selectedImage = #imageLiteral(resourceName: "ic_heart_selected")
        bookmarkButton.adjustsImageWhenHighlighted = false
        
        playButton.normalTintColor = #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1)
        playButton.highlightTintColor = #colorLiteral(red: 0.7422102094, green: 0.764362216, blue: 0.7821244597, alpha: 1)
        playButton.isSelectable = false
        playButton.adjustsImageWhenHighlighted = false
        playButton.onPrimaryAction = playVideo
    }
    
    // MARK: - Actions
    
    @IBAction func bookmarkMovie(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    private func playVideo() {
        topContainer.bringSubview(toFront: videoContainer)
        EPMediaPlayer.shared.play("vid_back_to_the_future.mp4", in: videoContainer)
    }
}
