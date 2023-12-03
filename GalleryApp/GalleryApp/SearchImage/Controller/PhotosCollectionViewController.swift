//
//  PhotosCollectionViewController.swift
//  GalleryApp
//
//  Created by Jagriti on 02/12/23.
//

import UIKit
import GoogleSignIn
enum ViewStyle {
    case fullScreenStyle
    case gridStyle
}

class PhotosCollectionViewController: UIViewController {

    @IBOutlet weak var switchViewButton: UIBarButtonItem!
    @IBOutlet weak var signOutButton: UIBarButtonItem!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    var viewStyle = ViewStyle.gridStyle
    let photosCollectionVm = PhotosCollectionViewModel()
    var imageTasks = [Int: ImageTask]()
    
    //For Pagination
    var isDataLoading:Bool=false
    var pageNo:Int=0
    var limit:Int = 8
    var offset:Int=0
    var selectedFilterIndex = 0
    var didEndReached:Bool=false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = StringConstants.navTitle
        setupUI()
    }
 
    // MARK: - UI 
    fileprivate func setupUI() {
        switch viewStyle {
        case .gridStyle:
            if let layout = imageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .vertical
            }
            self.imageCollectionView.isPagingEnabled = false
            requestApi()
        case .fullScreenStyle:
            self.navigationItem.rightBarButtonItem  = nil
           print("")
        }
    }
    
    func scrollToItem(scrollToIndex:Int) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute:{
            self.imageCollectionView.scrollToItem(at:IndexPath(item: scrollToIndex, section: 0), at: .right, animated: false)
        })
    }
    
    @IBAction func switchViewBtnAction(_ sender: Any) {
        if switchViewButton.tag == 1 {
            switchViewButton.image = UIImage(named:"grid")
            switchViewButton.tag = 2
        }else {
            switchViewButton.image = UIImage(named:"list")
            switchViewButton.tag = 1
        }
        self.imageCollectionView.reloadData()
    }
    
    /// Signs out the current user.
    func signOut() {
      GIDSignIn.sharedInstance.signOut()
    }
    
    func disconnect(completion: @escaping () -> Void) {
        GIDSignIn.sharedInstance.disconnect { error in
            if let error = error {
                print("Encountered error disconnecting scope: \(error).")
            } else {
                self.signOut()
                completion() // Call the completion closure when sign-out is successful
            }
        }
    }

    
    @IBAction func signoutBtnAction(_ sender: UIBarButtonItem) {
       showLogoutAlert()
    }
    
    func showLogoutAlert() {
        let alertController = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        let signOutAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            self.disconnect {
                if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                    if let rootViewController = window.rootViewController {
                        if let navigationController = rootViewController as? UINavigationController {
                            navigationController.popToRootViewController(animated: true)
                        }
                    }
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(signOutAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }

    
    deinit {
        print("deallocated")
    }
}

