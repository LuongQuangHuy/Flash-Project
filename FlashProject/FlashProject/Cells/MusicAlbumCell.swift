//
//  MusicAlbumCell.swift
//  FlashProject
//
//  Created by Luong Quang Huy on 7/9/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit

class MusicAlbumCell: UICollectionViewCell {
    @IBOutlet weak var playButtonFrame: UIView!
    let playButton = UIPlayButton(frame: .zero, originState: .pause, playImageName: "icons8-play-24", pauseImageName: "icons8-pause-24")
    @IBOutlet weak var albumAvatar: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutSubview()
    }
    
    func layoutSubview(){
        albumAvatar.layer.cornerRadius = 5.0
        playButtonFrame.layer.cornerRadius = 24.0
        playButtonFrame.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.centerXAnchor.constraint(equalTo: playButtonFrame.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: playButtonFrame.centerYAnchor).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 36.0).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
    }

}
