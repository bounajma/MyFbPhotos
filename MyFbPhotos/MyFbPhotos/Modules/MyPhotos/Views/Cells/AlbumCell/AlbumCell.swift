//
//  AlbumCell.swift
//  MyFbPhotos
//
//  Created by Mohamed BOUNAJMA on 10/21/17.
//  Copyright © 2017 Mohamed BOUNAJMA. All rights reserved.
//

import UIKit

class AlbumCell: UICollectionViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var photosNumber: UILabel!
    @IBOutlet weak var coverPhoto: UIImageView!
    var albumPhotoId: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 8
       
    }

}
