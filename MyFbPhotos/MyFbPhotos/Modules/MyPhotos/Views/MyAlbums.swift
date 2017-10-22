//
//  MyAlbums.swift
//  MyFbPhotos
//
//  Created by Mohamed BOUNAJMA on 10/21/17.
//  Copyright © 2017 Mohamed BOUNAJMA. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKCoreKit
import SwiftyJSON

class MyAlbums: UIViewController {

    
    @IBOutlet weak var albumsCollection: UICollectionView!
    @IBOutlet weak var logOutButton: UIButton!
    
    var albums = [FacebookAlbum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        getUserAlbums()
    }

    
    func setUpViews() {
        // set Collection view
        albumsCollection.delegate = self
        albumsCollection.dataSource = self
        albumsCollection.register(UINib(nibName: "AlbumCell", bundle: nil), forCellWithReuseIdentifier: "albumCell")
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        let usabeleWidth = screenWidth * 5/6
        layout.sectionInset = UIEdgeInsets(top: 20, left: screenWidth / 18, bottom: 0, right: screenWidth / 18)
        layout.itemSize = CGSize(width: usabeleWidth/2, height: usabeleWidth/2)
        /*layout.minimumInteritemSpacing = screenWidth/18*/
        layout.minimumLineSpacing = screenWidth/18
        albumsCollection.collectionViewLayout = layout
    }
    
    func getUserAlbums() {
        FacebookUtils.getUserAlbums{[weak self] (responseCode, albums) in
            if responseCode == .OK {
                self?.albums = albums
                self?.albumsCollection.reloadData()
            } else {
                self?.showErrorAlert()
            }
        }
    }
    
    func showErrorAlert() {
        self.showDefaultAlert(title: NSLocalizedString("Error occured", comment: ""), message: NSLocalizedString("An error occued while importing your Facebook photos, Please log out and log in again.", comment: ""))
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        let loginManager = LoginManager()
        loginManager.logOut()
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.setWelcomePage()
    }
    
    
}
