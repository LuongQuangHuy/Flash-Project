//
//  RecentlyPlayedCell.swift
//  FlashProject
//
//  Created by Luong Quang Huy on 7/7/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit

class RecentlyPlayedCell: UICollectionViewCell {

    
    
    @IBOutlet weak var buttonFrame: UIView!
    @IBOutlet weak var avatar: UIImageView!
    let playButton = UIPlayButton(frame: .zero, originState: .pause, playImageName: "icons8-play-24", pauseImageName: "icons8-pause-24")
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutSubView()
    }
    func layoutSubView(){
        //layout avatar
        avatar.layer.cornerRadius = 5.0
        //layout button frame
        contentView.addSubview(buttonFrame)
        buttonFrame.layer.cornerRadius = 20.0
        //layout play button
        buttonFrame.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        playButton.centerXAnchor.constraint(equalTo: buttonFrame.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: buttonFrame.centerYAnchor).isActive = true
    }
}
