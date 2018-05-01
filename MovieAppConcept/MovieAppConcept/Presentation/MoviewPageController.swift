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
    
    @IBOutlet var movieImage: UIImageView!
    
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
        let setup = [setColors, setupMovieImage]
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
        // gradient.frame.size.height = 64
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.opacity = 0.35
        movieImage.layer.addSublayer(gradientLayer)
    }
}
