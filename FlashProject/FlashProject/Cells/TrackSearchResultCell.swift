//
//  SearchResultCell.swift
//  FlashProject
//
//  Created by Luong Quang Huy on 7/6/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit

class TrackSearchResultCell: UITableViewCell {
    let cellType = "track"
    let likeButton = UILikeButton(frame: .zero, originState: .unlike, unlikeImageName: "icons8-heart-50", likedImageName: "icons8-redheart-50")
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var track_title: UILabel!
    @IBOutlet weak var artist_album: UILabel!
    @IBOutlet weak var stackView: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        layoutSubview()
    }
    
    func layoutSubview(){
        //layout like button
        contentView.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        likeButton.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 0).isActive = true
       
        //layout avatar
        avatar.layer.cornerRadius = 4.0
        
    }
}
