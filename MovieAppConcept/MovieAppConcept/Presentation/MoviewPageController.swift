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
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    // MARK: - Methods
    
    private func setupScreen() {
        setup()
    }
    
    private func setup() {
        let setup = [setColors]
        setup.forEach { $0() }
    }
    
    private func setColors() {
    }
}
