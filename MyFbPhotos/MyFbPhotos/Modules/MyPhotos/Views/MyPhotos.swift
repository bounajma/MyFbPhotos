//
//  MyPhotos.swift
//  MyFbPhotos
//
//  Created by Mohamed BOUNAJMA on 10/21/17.
//  Copyright © 2017 Mohamed BOUNAJMA. All rights reserved.
//

import UIKit

class MyPhotos: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var PhotosCollection: UICollectionView!
    
    var albumId: String?
    var albumPhotos = [FacebookPhoto]()
    var name: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        getalbumPhotos()
    }
    
    
    func setUpViews() {
        // set Collection view
        PhotosCollection.delegate = self
        PhotosCollection.dataSource = self
        PhotosCollection.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "photoCell")
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        let usabeleWidth = screenWidth * 5/6
        layout.sectionInset = UIEdgeInsets(top: 20, left: screenWidth / 18, bottom: 0, right: screenWidth / 18)
        layout.itemSize = CGSize(width: usabeleWidth/3, height: usabeleWidth/3)
        /*layout.minimumInteritemSpacing = screenWidth/18*/
        layout.minimumLineSpacing = screenWidth/36
        PhotosCollection.collectionViewLayout = layout
        
        albumName.text = name ?? NSLocalizedString("My Photos", comment: "")
    }
    
    func getalbumPhotos() {
        if let id = albumId {
            FacebookUtils.getAlbumPhotos(albumId: id) {[weak self] (responseCode, photos) in
                if responseCode == .OK {
                    self?.albumPhotos = photos
                    self?.PhotosCollection.reloadData()
                } else {
                    self?.showDefaultAlert(title: NSLocalizedString("Error occured", comment: ""), message: NSLocalizedString("Please try again.", comment: ""))
                }
            }
        } else {
            self.showDefaultAlert(title: NSLocalizedString("Error occured", comment: ""), message: NSLocalizedString("Please try again.", comment: ""))
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
