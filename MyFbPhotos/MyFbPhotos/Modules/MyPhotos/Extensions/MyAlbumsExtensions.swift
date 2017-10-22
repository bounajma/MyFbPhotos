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
extension MyAlbums: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let usableWidth = (screenWidth * 5/6)
        let itemSize = usableWidth / 2
        let size = CGSize(width: floor(itemSize), height: floor(itemSize))
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as? AlbumCell else {
            return UICollectionViewCell()
        }
        if indexPath.row < albums.count {
            let album = albums[indexPath.row]
            cell.name.text = album.name
            cell.photosNumber.text = "\(album.count) " + NSLocalizedString("photos", comment: "")
            if let photoId = album.coverPhoto?.id {
                cell.albumPhotoId = photoId
                FacebookUtils.getUserPhoto(photoId: photoId) { (photo) in
                    if let id = photo.id, let cellPhoto = cell.albumPhotoId, id == cellPhoto, let link = photo.link, let url = URL(string: link) {
                        cell.coverPhoto.hnk_setImageFromURL(url)
                    }
                }
                    
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = albums[indexPath.row].id, albums[indexPath.row].count > 0 {
            let photos = MyPhotos(nibName: "MyPhotos", bundle: nil)
            photos.albumId = id
            photos.name = albums[indexPath.row].name
            self.navigationController?.pushViewController(photos, animated: true)
        }
    }
    
}
