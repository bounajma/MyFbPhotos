//
//  FacebookAlbum.swift
//  MyFbPhotos
//
//  Created by Mohamed BOUNAJMA on 10/21/17.
//  Copyright © 2017 Mohamed BOUNAJMA. All rights reserved.
//

import Foundation
import SwiftyJSON

class FacebookAlbum {
    var id: String?
    var name: String?
    var createdTime: String?
    var count: Int = 0
    var description: String?
    var coverPhoto: FacebookPhoto?
    
    init(album: JSON) {
        
        if let id = album["id"].string {
            self.id = id
        }
        
        if let name = album["name"].string {
            self.name = name
        }
        
        if let date = album["created_time"].string {
            self.createdTime = date
        }
        
        if let count = album["count"].int {
            self.count = count
        }
        
        if let description = album["description"].string {
            self.description = description
        }
        self.coverPhoto = FacebookPhoto(photo: album["cover_photo"])
    }
}
