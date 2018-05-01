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
    
    @IBOutlet var bookmarkButton: EPButton!
    
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
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.9).cgColor, UIColor.clear.cgColor]
        gradientLayer.opacity = 0.35
        movieImage.layer.addSublayer(gradientLayer)
        
        bookmarkButton.normalTintColor = #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1)
        bookmarkButton.highlightTintColor = #colorLiteral(red: 0.8832735419, green: 0.8961638808, blue: 0.900493443, alpha: 1)
        bookmarkButton.normalImage = #imageLiteral(resourceName: "ic_heart_normal")
        bookmarkButton.selectedImage = #imageLiteral(resourceName: "ic_heart_selected")
    }
    
    // MARK: - Actions
    
    @IBAction func bookmarkMovie(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
}
