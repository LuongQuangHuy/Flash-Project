//
//  FavoriteTracksViewController.swift
//  FlashProject
//
//  Created by Luong Quang Huy on 7/11/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit

class FavoriteTracksViewController: UIViewController {

   
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        registerTableView()
    }
    
    func configureNavigationBar(){
        self.title = "Favorite Tracks"
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func registerTableView(){
        tableView.register(UINib(nibName: "TrackSearchResultCell", bundle: nil), forCellReuseIdentifier: "TrackCell")
    }

}

extension FavoriteTracksViewController: UITableViewDataSource, UITableViewDelegate{
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
    
}

extension FavoriteTracksViewController: UILikeButtonDelegate{
    func likeButtonTapped() {
        print("like an album")
    }
    
    func unlikeButtonTapped() {
        print("dislike an album")
    }
    
    
}
