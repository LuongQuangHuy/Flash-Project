//
//  ArtistSearchResultCell.swift
//  FlashProject
//
//  Created by Luong Quang Huy on 7/7/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit

class ArtistSearchResultCell: UITableViewCell {
    let cellType = "artist"
    let likeButton = UILikeButton(frame: .zero, originState: .unlike, unlikeImageName: "icons8-heart-50", likedImageName: "icons8-redheart-50")
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var artistname: UILabel!
    @IBOutlet weak var numberOfFans: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        layoutLikeButton()
    }
    
    func layoutLikeButton(){
        contentView.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        likeButton.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 0).isActive = true
        
        //layout avatar
        avatar.layer.cornerRadius = 30.0
    }
}
