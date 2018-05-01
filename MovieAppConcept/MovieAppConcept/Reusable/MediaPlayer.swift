//
//  MediaPlayer.swift
//  MovieAppConcept
//
//  Created by Evgeniy on 01.05.18.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import AVFoundation
import AVKit
import UIKit

public final class EPMediaPlayer {

    // MARK: - Members

    public static let shared = EPMediaPlayer()

    // MARK: - Interface

    public func play(_ fullName: String, in view: UIView) {
        let path = fullName.components(separatedBy: ".")
        guard path.count == 2,
            let mediaURL = Bundle.main.url(forResource: path[0], withExtension: path[1]) else { return }

        let player = AVPlayer(url: mediaURL)
        let playerController = AVPlayerViewController()

        playerController.player = player
        playerController.view.frame = view.bounds
        view.addSubview(playerController.view)
        player.play()
    }
}
