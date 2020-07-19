//
//  MusicViewController.swift
//  FlashProject
//
//  Created by Luong Quang Huy on 7/6/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit

class MadeForUserViewController: UIViewController {
    private struct SectionInfo{
        enum CellType{
            case Track
            case MusicAlbumView
        }
        var type: CellType
        var title: String
        var description: String
        var numberOfrowInSection: Int
        var heightForRowInSection: CGFloat
    }
    
    private lazy var collectionViewForRegister : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    }()
    private var themes: [SectionInfo] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureThemes()
        configureNavigationBar()
        tableviewRegister()
    }
    
    func tableviewRegister(){
        tableView.register(UINib(nibName: "MusicCollectionView", bundle: nil), forCellReuseIdentifier: "AlbumsView")
        tableView.register(UINib(nibName: "TrackSearchResultCell" , bundle: nil), forCellReuseIdentifier: "TrackCell")
        collectionViewForRegister.register(UINib(nibName: "MusicAlbumCell", bundle: nil), forCellWithReuseIdentifier: "MusicAlbumCell")
    }
    
    func configureThemes(){
        themes.append(SectionInfo(type: .MusicAlbumView , title: "Latest albums release", description: "According to your favorite artists", numberOfrowInSection: 1 , heightForRowInSection: 570.0))
        themes.append(SectionInfo(type: .Track , title: "10 latest tracks release", description: "According to your favorite artists", numberOfrowInSection: 10 , heightForRowInSection: 80.0))
    }
    
    func configureNavigationBar(){
        self.title = "Music"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }


}

extension MadeForUserViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes[section].numberOfrowInSection
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return themes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return themes[indexPath.section].heightForRowInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch themes[indexPath.section].type {
        case .Track:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell") as! TrackSearchResultCell
            cell.likeButton.likeButtonDelegate = self
            return cell
        case .MusicAlbumView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumsView") as! MusicCollectionView
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HeaderMusicView", owner: self, options: nil)?.first as! HeaderMusicView
        headerView.headerTitle.text = themes[section].title
        headerView.headerDescription.text = themes[section].description
        return headerView as UIView
    }
}

extension MadeForUserViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewForRegister.dequeueReusableCell(withReuseIdentifier: "MusicAlbumCell", for: indexPath) as! MusicAlbumCell
        cell.playButton.playButtonDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180.0, height: 270.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    
}

extension MadeForUserViewController: UILikeButtonDelegate{
    func likeButtonTapped() {
        print("liked a track from latest tracks release")
    }
    
    func unlikeButtonTapped() {
        print("unlike a track from latest tracks release")
    }
}

extension MadeForUserViewController: UIPlayButtonDelegate{
    func playButtonTapped() {
        print("play an album from latest albums release")
    }
    
    func pauseButtonTapped() {
        print("pause an album form latest albums release")
    }
    
    
}
