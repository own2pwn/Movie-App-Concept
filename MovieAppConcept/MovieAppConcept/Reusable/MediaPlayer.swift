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

    private var player: AVPlayer?

    private var playerLayer: AVPlayerLayer?

    // MARK: - Interface

    public func play(_ fullName: String, in view: UIView) {
        let path = fullName.components(separatedBy: ".")
        guard let name = path.first,
            let ext = path.last,
            let mediaURL = Bundle.main.url(forResource: name, withExtension: ext) else { return }

        player = AVPlayer(url: mediaURL)
        playerLayer = AVPlayerLayer(player: player)
        guard let player = player, let playerLayer = playerLayer else { return }

        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill

        view.layer.addSublayer(playerLayer)
        player.play()
    }

    public func stop() {
        guard let player = player, let playerLayer = playerLayer else { return }

        player.pause()
        UIView.animate(withDuration: 0.25) {
            playerLayer.opacity = 0
        }
    }
}
