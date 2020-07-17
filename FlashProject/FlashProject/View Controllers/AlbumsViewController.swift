//
//  AlbumsViewController.swift
//  FlashProject
//
//  Created by Luong Quang Huy on 7/11/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        registerTableView()
    }
    func configureNavigationBar(){
           self.title = "Albums"
           self.navigationController?.navigationBar.prefersLargeTitles = false
       }
    
    func registerTableView(){
        tableView.register(UINib(nibName: "AlbumSearchResultCell", bundle: nil), forCellReuseIdentifier: "AlbumCell")
    }

}

extension AlbumsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell") as! AlbumSearchResultCell
        cell.likeButton.likeButtonDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = storyboard?.instantiateViewController(identifier: "DetailAlbumViewController") as! DetailAlbumViewController
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
}

extension AlbumsViewController: UILikeButtonDelegate{
    func likeButtonTapped() {
        print("like an album")
    }
    
    func unlikeButtonTapped() {
        print("dislike an album")
    }
    
    
}
