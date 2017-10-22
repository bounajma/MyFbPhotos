//
//  FacebookUtils.swift
//  MyFbPhotos
//
//  Created by Mohamed BOUNAJMA on 10/21/17.
//  Copyright © 2017 Mohamed BOUNAJMA. All rights reserved.
//

import Foundation
import FacebookCore
import FBSDKCoreKit
import SwiftyJSON

class FacebookUtils {
    
    static func getUserAlbums(completion: @escaping (FacebookResponseCode, [FacebookAlbum]) -> Void) {
        if let token = AccessToken.current, let id = token.userId {
            let request = FBSDKGraphRequest(graphPath: "/\(id)/albums", parameters: ["fields": "id,name,created_time,cover_photo,count,description"])
            let _ = request?.start { (_, result, error) in
                guard error == nil else {
                    completion(.Error, [FacebookAlbum]())
                    return
                }
                guard let data = result else {
                    completion(.Error, [FacebookAlbum]())
                    return
                }
                let responseJson = JSON(data)
                guard let albumsArray = responseJson["data"].array else {
                    completion(.Error, [FacebookAlbum]())
                    return
                }
                var albums = [FacebookAlbum]()
                for album in albumsArray {
                    albums.append(FacebookAlbum(album: album))
                }
                completion(.OK, albums)
            }
        }
    }
    
    static func getAlbumPhotos(albumId: String, completion: @escaping (FacebookResponseCode, [FacebookPhoto]) -> Void) {
        
            let request = FBSDKGraphRequest(graphPath: "/\(albumId)/photos", parameters: ["fields": "id,link, picture, images"])
            let _ = request?.start { (_, result, error) in
                guard error == nil else {
                    completion(.Error, [FacebookPhoto]())
                    return
                }
                guard let data = result else {
                    completion(.Error, [FacebookPhoto]())
                    return
                }
                let responseJson = JSON(data)
                guard let photosArray = responseJson["data"].array else {
                    completion(.Error, [FacebookPhoto]())
                    return
                }
                var photos = [FacebookPhoto]()
                for photo in photosArray {
                    photos.append(FacebookPhoto(photo: photo))
                }
                completion(.OK, photos)
            }
        
    }
    
    static func getUserPhoto(photoId: String, completion: @escaping (FacebookPhoto) -> Void) {
        let request = FBSDKGraphRequest(graphPath: "/\(photoId)", parameters: ["fields": "id,link, picture, images"])
        let _ = request?.start { (_, result, _) in
            guard let data = result else {
                return
            }
            let responseJson = JSON(data)
            print ("response photo \(responseJson)")
            completion(FacebookPhoto(photo: responseJson))
        }
    }
    
}
