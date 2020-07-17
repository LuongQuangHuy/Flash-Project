//
//  MusicPlayerController.swift
//  FlashProject
//
//  Created by Luong Quang Huy on 7/15/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit
import Kingfisher
class MusicPlayerViewController: UIViewController {

    @IBOutlet weak var typeName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var trackTitleVersion: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var downloadButton: UIImageView!
    @IBOutlet weak var menuButton: UIImageView!
    @IBOutlet weak var menuButtonFrame: UIView!
    @IBOutlet weak var likeButtonFrame: UIView!
    @IBOutlet weak var playButtonFrame: UIView!
    @IBOutlet weak var backwardButton: UIImageView!
    @IBOutlet weak var forwardButton: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    let likeButton = UILikeButton(frame: .zero, originState: .unlike, unlikeImageName: "icons8-heart-32", likedImageName: "icons8-whiteheart-32")
    let playButton = UIPlayButton(frame: .zero, originState: .pause, playImageName: "icons8-play-white-50", pauseImageName: "icons8-pause-white-50")
    
    unowned let commander: MusicPlayer = MusicPlayer.shared
    var updateUI: Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSubViews()
        addActionTargetForSubViews()
    }
    
    // update UI base on MusicPlayer status
    @objc func updateUIfrequently(){
    if let audioPlayer = commander.audioPlayer{
            DispatchQueue.main.async {
                self.currentTime.text = Caculating.shared.doubleToMiniute(double: audioPlayer.currentTime)
                self.endTime.text = Caculating.shared.doubleToMiniute(double: audioPlayer.duration)
                self.slider.maximumValue = 0.0
                self.slider.maximumValue = Float(audioPlayer.duration)
                self.slider.value = Float(audioPlayer.currentTime)
            }
        }
    }
    
    func layoutSubViews(){
        //layout like button
        likeButtonFrame.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        likeButton.centerXAnchor.constraint(equalTo: likeButtonFrame.centerXAnchor).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: likeButtonFrame.centerYAnchor).isActive = true
        likeButton.likeButtonDelegate = self
        
        //layout play button
        playButtonFrame.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        playButton.centerXAnchor.constraint(equalTo: playButtonFrame.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: playButtonFrame.centerYAnchor).isActive = true
        playButton.playButtonDelegate = self
        
        //layout border for menu button frame
        menuButtonFrame.layer.cornerRadius = 25.0
        menuButtonFrame.layer.borderWidth = 1
        menuButtonFrame.layer.borderColor = UIColor.white.cgColor
        
        //layout avatar
        avatar.layer.cornerRadius = 10.0
    }
    
    func addActionTargetForSubViews(){
        // add action for menu button
        menuButton.isUserInteractionEnabled = true
        let menuTapGesture = UITapGestureRecognizer(target: self, action: #selector(menuTapResponse))
        menuButton.addGestureRecognizer(menuTapGesture)
        
        //add action for backward button
        let backwardTapGesture = UITapGestureRecognizer(target: self, action: #selector(backwardTapResponse))
        backwardButton.addGestureRecognizer(backwardTapGesture)
        
        //add action for forward button
        let forwardTapGesture = UITapGestureRecognizer(target: self, action: #selector(forwardTapResponse))
        forwardButton.addGestureRecognizer(forwardTapGesture)
    }
    
    //action for buttons
    @objc func menuTapResponse(){
        let detailView = storyboard?.instantiateViewController(identifier: "DetailMPmenuVC") as! DetailMPmenuTableViewController
        detailView.modalPresentationStyle = .popover
        present(detailView, animated: true, completion: nil)
    }
    
    @objc func backwardTapResponse(){
        commander.backTrack()
    }
    
    @objc func forwardTapResponse(){
        commander.nextTrack()
    }
    
    
    @IBAction func sliderChangeValue(_ sender: UISlider) {
        commander.pause()
        if let player = commander.audioPlayer{
            player.currentTime = Double(sender.value / sender.maximumValue) * player.duration
        }
        commander.play()
    }

    @IBAction func dissMissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func reloadDataInSubViews(){
        let index = commander.index
        if commander.trackList.count <= 1{
            backwardButton.isUserInteractionEnabled = false
            backwardButton.alpha = 0.5
            forwardButton.isUserInteractionEnabled = false
            forwardButton.alpha = 0.5
            self.artistName.text = commander.trackList[index].artist.name
            self.typeName.text = "Track"
            self.trackName.text = commander.trackList[index].title
            self.trackTitleVersion.text = commander.trackList[index].title_version
            let url = URL(string: commander.trackList[index].artist.picture_xl)
            self.avatar.kf.setImage(with: url)
        }else{
            backwardButton.isUserInteractionEnabled = true
            forwardButton.isUserInteractionEnabled = true
            self.artistName.text = commander.trackList[index].artist.name
            self.typeName.text = "Track"
            self.trackName.text = commander.trackList[index].title
            self.trackTitleVersion.text = commander.trackList[index].title_version
        }
    }
       
    func musicIsPlaying(){
        self.updateUI = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateUIfrequently), userInfo: nil, repeats: true)
        self.updateUI.fire()
        self.reloadDataInSubViews()
        self.playButton.updateButtonByState(state: .play)
    }
       
    func musicOnPause(){
        self.updateUI.invalidate()
        self.playButton.updateButtonByState(state: .pause)
    }
}

extension MusicPlayerViewController: UIPlayButtonDelegate, UILikeButtonDelegate{
    func likeButtonTapped() {
        print("User like a track on Music Player")
    }
    
    func unlikeButtonTapped() {
        print("User dislike a track on Music Player")
    }
    
    func playButtonTapped() {
        self.commander.play()
    }
    
    func pauseButtonTapped() {
        self.commander.pause()
    }
}
