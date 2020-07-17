//
//  ArtistsViewController.swift
//  FlashProject
//
//  Created by Luong Quang Huy on 7/11/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit

class ArtistsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        registerTableView()
    }
    
    func configureNavigationBar(){
           self.title = "Artists"
           self.navigationController?.navigationBar.prefersLargeTitles = false
       }
    func registerTableView(){
        tableView.register(UINib(nibName: "ArtistSearchResultCell", bundle: nil), forCellReuseIdentifier: "ArtistCell")
    }
}

extension ArtistsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell") as! ArtistSearchResultCell
        cell.likeButton.likeButtonDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = storyboard?.instantiateViewController(identifier: "DetailArtistViewController") as! DetailArtistViewController
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
}

extension ArtistsViewController: UILikeButtonDelegate{
    func likeButtonTapped() {
        print("like an artist")
    }
    
    func unlikeButtonTapped() {
        print("dislike an artist")
    }
    
    
}
