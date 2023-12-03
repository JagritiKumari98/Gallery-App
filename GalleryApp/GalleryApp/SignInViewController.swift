//
//  SignInViewController.swift
//  GalleryApp
//
//  Created by Jagriti on 01/12/23.
//

import UIKit
import GoogleSignIn

class SignInViewController: UIViewController {

    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    let photosCollectionVm = PhotosCollectionViewModel()

    @IBAction func googleSignInAction(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            if let userData = signInResult {
                print(userData.user)
                print(userData.user.profile?.name)
                print(userData.user.profile?.email)
                if let photosCollectionVC = self.storyboard?.instantiateViewController(identifier:PhotosCollectionViewController.identifier) as? PhotosCollectionViewController {
                    photosCollectionVC.viewStyle = .gridStyle
                    photosCollectionVC.photosCollectionVm.imagesData = self.photosCollectionVm.imagesData
                    photosCollectionVC.receivedApiResponse()
                    photosCollectionVC.navigationItem.hidesBackButton = true
                    self.navigationController?.pushViewController(photosCollectionVC, animated:true)
                }
                
            } else {
                print(error?.localizedDescription)
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        googleSignInButton.style = .standard
        googleSignInButton.colorScheme = .dark
    }


}

