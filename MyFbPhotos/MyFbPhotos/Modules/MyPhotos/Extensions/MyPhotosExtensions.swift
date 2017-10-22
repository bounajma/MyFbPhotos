//
//  MyAlbumsExtensions.swift
//  MyFbPhotos
//
//  Created by Mohamed BOUNAJMA on 10/21/17.
//  Copyright © 2017 Mohamed BOUNAJMA. All rights reserved.
//

import Foundation
import UIKit
import Haneke
extension MyPhotos: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let usableWidth = (screenWidth * 5/6)
        let itemSize = usableWidth / 3
        let size = CGSize(width: floor(itemSize), height: floor(itemSize))
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        if indexPath.row < albumPhotos.count {
            let photo = albumPhotos[indexPath.row]
            if let photoId = photo.id {
                cell.photoId = photoId
                FacebookUtils.getUserPhoto(photoId: photoId) { (photo) in
                    if let id = photo.id, let cellPhoto = cell.photoId, id == cellPhoto, let link = photo.link, let url = URL(string: link) {
                        cell.photo.hnk_setImageFromURL(url)
                    }
                }
                
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell {
            let detail = PhotoDetails(nibName: "PhotoDetails", bundle: nil)
            detail.image = cell.photo.image
            self.present(detail, animated: true)
        }
    }
    
}

