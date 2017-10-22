//
//  PhotoDetails.swift
//  MyFbPhotos
//
//  Created by Mohamed BOUNAJMA on 10/21/17.
//  Copyright © 2017 Mohamed BOUNAJMA. All rights reserved.
//

import UIKit

class PhotoDetails: UIViewController {
    
    @IBOutlet weak var photo: UIImageView!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = image
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
