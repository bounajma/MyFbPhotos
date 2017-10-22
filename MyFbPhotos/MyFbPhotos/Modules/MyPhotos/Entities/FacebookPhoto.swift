//
//  FacebookPhoto.swift
//  MyFbPhotos
//
//  Created by Mohamed BOUNAJMA on 10/21/17.
//  Copyright © 2017 Mohamed BOUNAJMA. All rights reserved.
//

import Foundation
import SwiftyJSON

class FacebookPhoto {
    var id: String?
    var createdTime: String?
    var link: String?
    
    init(photo: JSON) {
        
        if let id = photo["id"].string {
            self.id = id
        }
        if let date = photo["created_time"].string {
            self.createdTime = date
        }
        if let images = photo["images"].array {
            if let largest = images[0]["source"].string {
                self.link = largest
            } else if let link = photo["picture"].string {
                self.link = link
            }
        }
    }
    
}
