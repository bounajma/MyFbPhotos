//
//  WelcomePage.swift
//  MyFbPhotos
//
//  Created by Mohamed BOUNAJMA on 10/21/17.
//  Copyright © 2017 Mohamed BOUNAJMA. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKCoreKit

class WelcomePage: UIViewController {

    @IBOutlet weak var facebookButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews() {
        facebookButton.layer.cornerRadius = ViewsConfig.buttonsRadius
    }
    
    @IBAction func facebookLogin(_ sender: UIButton) {
        logIn()
    }
    
    // facebook login method
    func logIn(){
        let loginManager = LoginManager()
        self.view.isUserInteractionEnabled = false
        loginManager.logIn(readPermissions: [ReadPermission.publicProfile, ReadPermission.userPhotos], viewController: self){[weak self] loginResult in
            self?.view.isUserInteractionEnabled = true
            switch loginResult {
            case .success(let grantedPermissions, _, _) :
                guard grantedPermissions.contains("user_photos") else {
                    self?.showPhotosAccessDeniedAlert()
                    return
                }
                // go to the albums page
                self?.setAlbumsPage()
            case .cancelled :
                self?.showDefaultAlert(title: NSLocalizedString("Fb login cancelled", comment: ""), message: NSLocalizedString("Please try again.", comment: ""))
            case .failed:
                self?.showDefaultAlert(title: NSLocalizedString("Fb login failed", comment: ""), message: NSLocalizedString("Please try again.", comment: ""))
            }
        }
    }
    
    func showPhotosAccessDeniedAlert() {
        let actions: [(String, UIAlertActionStyle, ((UIAlertAction) -> Void)?)] = [(NSLocalizedString("Cancel", comment: ""), UIAlertActionStyle.cancel, nil), (NSLocalizedString("Authorize", comment: ""), UIAlertActionStyle.default, { action in
                self.askForFacebookPhotos()
            })]
        self.showCustomAlert(title: NSLocalizedString("Access denied", comment: ""), message: NSLocalizedString("Please Authorize us to access your faceboof photos in order to export them for you.", comment: ""), style: .alert, actions: actions)
    }
    
    func askForFacebookPhotos() {
        let loginManager = LoginManager()
        self.view.isUserInteractionEnabled = false
        loginManager.logIn(readPermissions: [ReadPermission.userPhotos], viewController: self){[weak self] loginResult in
            self?.view.isUserInteractionEnabled = true
            switch loginResult {
            case .success(let grantedPermissions, _, _) :
                guard grantedPermissions.contains("user_photos") else {
                    self?.showPhotosAccessDeniedAlert()
                    return
                }
            // go to the albums Page
                self?.setAlbumsPage()
            case .cancelled :
                self?.showDefaultAlert(title: NSLocalizedString("fb login cancelled", comment: "Facebook login cancelled alert title"), message: NSLocalizedString("fb login cancelled message", comment: "Facebook login cancelled alert message"))
            case .failed:
                self?.showDefaultAlert(title: NSLocalizedString("fb login failed", comment: "Facebook login cancelled alert title"), message: NSLocalizedString("fb login cancelled message", comment: "Facebook login cancelled alert message"))
            }
        }
    }
    
    func setAlbumsPage() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.setAlbumPage()
    }
}
