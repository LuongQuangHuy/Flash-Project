//
//  FavoritesViewController.swift
//  FlashProject
//
//  Created by Luong Quang Huy on 7/6/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private struct SectionInfo{
        enum SectionCellType{
            case History
            case Themes
        }
        var type: SectionCellType
        var titleHeader: String
        var themes: [Theme]?
        var heightForRowInSection: CGFloat
    }
    
    private struct Theme{
        var themeTitle: String
        var count: Int
        var responseSelectAction: (() -> Void)?
    }
    
    private var sectionInfo: [SectionInfo] = []
    
    private lazy var collectionViewForRegister: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        configureNavigationBar()
        tableViewRegister()
        tableViewConfigureSection()
    }
    func configureNavigationBar(){
        self.title = "Favorites"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    func tableViewRegister(){
        // tableview register
        tableView.register(UINib(nibName: "MusicCollectionView", bundle: nil), forCellReuseIdentifier: "HistoryView")
        tableView.register(UINib(nibName: "FavoriteThemeCell", bundle: nil), forCellReuseIdentifier: "ThemeCell")
        // history view register cell
        collectionViewForRegister.register(UINib(nibName: "RecentlyPlayedCell", bundle: nil), forCellWithReuseIdentifier: "RecentlyPlayedCell")
    }
    
    func tableViewConfigureSection(){
        //configure history section
        let historySection = SectionInfo(type: .History, titleHeader: "Recently Played", themes: nil , heightForRowInSection: 200)
        // configure themes section
        let favoriteTracks = Theme(themeTitle: "Favorite Tracks", count: 0) {
            [unowned self] () -> Void in
            if let favoriteTracksVC = self.storyboard?.instantiateViewController(identifier: "FavoriteTracksViewController") as? FavoriteTracksViewController{
                self.navigationController?.pushViewController(favoriteTracksVC, animated: true)
            }
        }
        let albums = Theme(themeTitle: "Albums", count: 0) {
            [unowned self] () -> Void in
            if let albumsVC = self.storyboard?.instantiateViewController(identifier: "AlbumsViewController") as? AlbumsViewController{
                self.navigationController?.pushViewController(albumsVC, animated: true)
            }
        }
        let artists = Theme(themeTitle: "Artists", count: 0) {
            [unowned self] () -> Void in
            if let artistsVC = self.storyboard?.instantiateViewController(identifier: "ArtistsViewController") as? ArtistsViewController{
                self.navigationController?.pushViewController(artistsVC, animated: true)
            }
        }
        let themesSection = SectionInfo(type: .Themes, titleHeader: "", themes: [favoriteTracks, albums, artists], heightForRowInSection: 80)
        sectionInfo.append(historySection)
        sectionInfo.append(themesSection)
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfRow = sectionInfo[section].themes?.count{
            return numberOfRow
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sectionInfo[indexPath.section].type {
            
        case .History:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryView") as! MusicCollectionView
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            return cell
        case .Themes:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThemeCell") as! FavoriteThemeCell
            if let theme = sectionInfo[indexPath.section].themes?[indexPath.row]{
                cell.themeTitle.text = theme.themeTitle
                cell.count.text = String(theme.count)
                return cell
            }else{
                return cell
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionInfo.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sectionInfo[indexPath.section].heightForRowInSection
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HeaderMusicView", owner: self, options: nil)?.first as! HeaderMusicView
        headerView.headerTitle.text = sectionInfo[section].titleHeader
        headerView.headerDescription.text = ""
        return headerView as UIView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let responseSelectAction = sectionInfo[indexPath.section].themes?[indexPath.row].responseSelectAction{
            responseSelectAction()
        }
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewForRegister.dequeueReusableCell(withReuseIdentifier: "RecentlyPlayedCell", for: indexPath) as! RecentlyPlayedCell
        cell.playButton.playButtonDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
    
}

extension FavoritesViewController: UIPlayButtonDelegate{
    func playButtonTapped() {
        print("a history track on play")
    }
    
    func pauseButtonTapped() {
        print("a history track on pause")
    }
    
}
