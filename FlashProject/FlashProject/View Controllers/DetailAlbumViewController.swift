//
//  AlbumViewController.swift
//  FlashProject
//
//  Created by Luong Quang Huy on 7/11/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit

class DetailAlbumViewController: UIViewController {
    var trackList: [Track]?
    @IBOutlet weak var albumAvatar: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var byArtists: UILabel!
    @IBOutlet weak var playAlbumButton: UIView!
    @IBOutlet weak var likeButtonFrame: UIView!
    @IBOutlet weak var tableView: UITableView!
    let playButton = UIPlayButton(frame: .zero, originState: .pause, playImageName: "icons8-play-white-50", pauseImageName: "icons8-pause-white-50")
    let likeButton = UILikeButton(frame: .zero, originState: .liked, unlikeImageName: "icons8-heart-50", likedImageName: "icons8-redheart-50")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        layoutSubviews()
        configurePlayAlbumButton()
    }
    
    func registerTableView(){
        tableView.register(UINib(nibName: "TrackSearchResultCell", bundle: nil), forCellReuseIdentifier: "TrackCell")
    }
    
    func layoutSubviews(){
        // layout play button
        playAlbumButton.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.centerYAnchor.constraint(equalTo: playAlbumButton.centerYAnchor).isActive = true
        playButton.leadingAnchor.constraint(equalTo: playAlbumButton.leadingAnchor, constant: 10).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        playAlbumButton.layer.cornerRadius = 20.0
        //add delegate play button
        playButton.playButtonDelegate = self
        
        //layout like button
        likeButtonFrame.layer.cornerRadius = 20.0
        likeButtonFrame.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        likeButton.centerXAnchor.constraint(equalTo: likeButtonFrame.centerXAnchor).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: likeButtonFrame.centerYAnchor).isActive = true
        // add delegate like button
        likeButton.likeButtonDelegate = self
    }
    
    func configurePlayAlbumButton(){
        playAlbumButton.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(playAlbumButtonTapped(_:)))
        playAlbumButton.addGestureRecognizer(tapGesture)
    }
    
    @objc func playAlbumButtonTapped(_ sender: UILabel){
        self.playButton.toggle()
        if let tracklist = self.trackList{
            MusicPlayer.shared.restartMusicPlayerWithTrackList(tracklist: tracklist)
        }
    }
}

extension DetailAlbumViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell") as! TrackSearchResultCell
        cell.likeButton.likeButtonDelegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed("HeaderMusicView", owner: self, options: nil)?.first as! HeaderMusicView
        header.headerTitle.text = "Album tracks"
        header.headerDescription.text = ""
        return header as UIView
    }
}

extension DetailAlbumViewController: UIPlayButtonDelegate{
    func playButtonTapped() {
        print("play album")
    }
    
    func pauseButtonTapped() {
        print("pause album")
    }
}

extension DetailAlbumViewController: UILikeButtonDelegate{
    func likeButtonTapped() {
        print("like")
    }
    
    func unlikeButtonTapped() {
        print("dislike")
    }
}

