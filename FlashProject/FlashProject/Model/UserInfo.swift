//
//  UserInfo.swift
//  FlashProject
//
//  Created by Techmaster on 7/31/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import Foundation

class UserData{
    
    class UserInfo{
        var name: String
        var email: String
        var userID: String
        var userPassword: String
        init(name: String, email: String, userID: String, userPassword: String){
            self.name = name
            self.email = email
            self.userID = userID
            self.userPassword = userPassword
        }
    }
    
    class UserStoredData{
        var userLikedTrackIDs: [Int]{
            didSet{
                let likedTrackChanged = Notification.Name.init("likedTrackChanged")
                NotificationCenter.default.post(name: likedTrackChanged, object: self)
            }
        }
        var userLikedArtistIDs: [Int] {
            didSet{
                let likedArtistChanged = Notification.Name.init("likedArtistChanged")
                NotificationCenter.default.post(name: likedArtistChanged, object: self)
            }
        }
        var userLikedAlbumIDs: [Int] {
            didSet{
                let likedAlbumChanged = Notification.Name.init("likedAlbumChanged")
                NotificationCenter.default.post(name: likedAlbumChanged, object: self)
            }
        }
        var historyTrackIDs: [Int] {
            didSet{
                let historyTrackChanged = Notification.Name.init("historyTrackChanged")
                NotificationCenter.default.post(name: historyTrackChanged, object: self)
            }
        }
        init(likedTrackIds: [Int], likedAlbumIds: [Int], likedArtistIds: [Int], historyTrackIds: [Int]){
            self.userLikedTrackIDs = likedTrackIds
            self.userLikedAlbumIDs = likedAlbumIds
            self.userLikedArtistIDs = likedArtistIds
            self.historyTrackIDs = historyTrackIds
        }
    }
    
    static let shared = UserData()
    
    var userStoreData: UserStoredData?
    var userInfo: UserInfo?
    
    func addFavoriteTrackId(id: Int){
        self.userStoreData?.userLikedTrackIDs.insert(id, at: 0)
    }
    func addFavoriteAlbumId(id: Int){
        self.userStoreData?.userLikedAlbumIDs.insert(id, at: 0)
    }
    func addFavoriteArtistId(id: Int){
        self.userStoreData?.userLikedArtistIDs.insert(id, at: 0)
    }
    
    func addHistoryTrackId(id: Int){
        guard var historyTrackIDs = userStoreData?.historyTrackIDs else {return}
        if historyTrackIDs.count >= 10{
            historyTrackIDs.removeLast()
            historyTrackIDs.insert(id, at: 0)
        }else{
            historyTrackIDs.insert(id, at: 0)
        }
    }
    
    func getTop10NewTracksForYou() -> [Track]?{
        guard let artistIds = self.userStoreData?.userLikedArtistIDs else{return nil}
         var tracks: [Track] = []
        if artistIds.count >= 10{
            let semaphore = DispatchSemaphore.init(value: 1)
            for index in 0...9{
                let getTrackById = CommunicateWithAPI()
                getTrackById.getTrackById(id: artistIds[index]) {
                    if let track = getTrackById.track{
                        semaphore.wait()
                         tracks.append(track)
                        semaphore.signal()
                    }
                }
                return tracks
            }
        }else{
            let semaphore = DispatchSemaphore.init(value: 1)
            for id in artistIds{
                let getTrackById = CommunicateWithAPI()
                getTrackById.getTrackById(id: id) {
                    if let track = getTrackById.track{
                        semaphore.wait()
                        tracks.append(track)
                        semaphore.signal()
                    }
                }
                return tracks
            }
        }
        return nil
    }
    
    func getTop10AlbumsForYou() -> [Album]?{
       guard let artistIds = self.userStoreData?.userLikedArtistIDs else{return nil}
        var albums: [Album] = []
        if artistIds.count >= 10{
            let semaphore = DispatchSemaphore.init(value: 1)
            for index in 0...9{
                let getAlbumById = CommunicateWithAPI()
                getAlbumById.getAlbumById(id: artistIds[index]) {
                    if let album = getAlbumById.album{
                        semaphore.wait()
                        albums.append(album)
                        semaphore.signal()
                    }
                }
                return albums
            }
        }else{
            let semaphore = DispatchSemaphore.init(value: 1)
            for id in artistIds{
                let getAlbumById = CommunicateWithAPI()
               getAlbumById.getAlbumById(id: id) {
                    if let album = getAlbumById.album{
                        semaphore.wait()
                        albums.append(album)
                        semaphore.signal()
                    }
                }
                return albums
            }
        }
        return nil
    }
    
   
    
    private init(){}
    
}
