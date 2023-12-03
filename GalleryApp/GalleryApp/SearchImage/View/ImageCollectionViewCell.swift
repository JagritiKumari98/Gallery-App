//
//  ImageCollectionViewCell.swift
//  GalleryApp
//
//  Created by Jagriti on 01/12/23.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!    
    @IBOutlet weak var imageView: UIImageView!
    
    var imageTask:ImageTask?
    
    var viewStyle:ViewStyle? {
        didSet {
            switch viewStyle {
            case .fullScreenStyle:
                self.imageView.layer.borderWidth = 0
                self.imageView.contentMode = .scaleAspectFit
            case .gridStyle:
                self.imageView.layer.borderWidth = 1.0
                self.imageView.layer.borderColor = UIColor.lightGray.cgColor
                self.imageView.contentMode = .scaleToFill
            case .none:
                print("")
            }
        }
    }
    
    func set(image: UIImage?) {
        imageView.image = image
        
        if image == nil {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
