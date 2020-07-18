//
//  ArtistViewController.swift
//  FlashProject
//
//  Created by Luong Quang Huy on 7/11/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit

class DetailArtistViewController: UIViewController {
    var tracklist: [Track]?
    @IBOutlet weak var artistAvatar: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var numberOfFans: UILabel!
    @IBOutlet weak var likeButtonFrame: UIView!
    @IBOutlet weak var playArtistMixButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let likeButton = UILikeButton(frame: .zero, originState: .unlike, unlikeImageName: "icons8-heart-50", likedImageName: "icons8-redheart-50")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        layoutSubviews()
    }
    
    func registerTableView(){
        tableView.register(UINib(nibName: "TrackSearchResultCell", bundle: nil), forCellReuseIdentifier: "TrackCell")
    }
    
    func layoutSubviews(){
        //layout like button
        likeButtonFrame.layer.cornerRadius = 20.0
        likeButtonFrame.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        likeButton.centerXAnchor.constraint(equalTo: likeButtonFrame.centerXAnchor).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: likeButtonFrame.centerYAnchor).isActive = true
        //add delegate like button
        likeButton.likeButtonDelegate = self
        
        //layout avatar
        self.artistAvatar.layer.cornerRadius = 110.0
        
        //layout playButton
        playArtistMixButton.layer.cornerRadius = 20.0
       }
    
   
    @IBAction func playArtistMixTapped(_ sender: UIButton) {
        if let trackList = self.tracklist{
            MusicPlayer.shared.restartMusicPlayerWithTrackList(tracklist: trackList)
        }
    }
}

extension DetailArtistViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let data = tracklist?[indexPath.row]{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell") as! TrackSearchResultCell
            cell.likeButton.likeButtonDelegate = self
            cell.track_title.text = data.title
            cell.artist_album.text = data.artist.name
            let url = URL(string:data.album?.cover_xl ?? "https://media.idownloadblog.com/wp-content/uploads/2018/03/Apple-Music-icon-003.jpg")
            cell.avatar.kf.setImage(with: url)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed("HeaderMusicView", owner: self, options: nil)?.first as! HeaderMusicView
        header.headerTitle.text = "Top tracks"
        header.headerDescription.text = ""
        return header as UIView
    }
}

extension DetailArtistViewController: UIPlayButtonDelegate{
    func playButtonTapped() {
        MusicPlayer.shared.play()
    }
    
    func pauseButtonTapped() {
        MusicPlayer.shared.pause()
    }
    
    
}

extension DetailArtistViewController: UILikeButtonDelegate{
    func likeButtonTapped() {
        print("like")
    }
    
    func unlikeButtonTapped() {
        print("dislike")
    }
    
    
}
