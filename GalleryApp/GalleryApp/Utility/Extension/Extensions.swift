//
//  Extension.swift
//  GalleryApp
//
//  Created by Jagriti on 02/12/23.
//

import UIKit

extension UICollectionViewCell {
    static var identifier:String! {
        return String(describing: self)
    }
}

extension UIViewController {
    static var identifier:String! {
        return String(describing: self)
    }
}


extension Array {
    func getElement(at index: Int) -> Element? {
        let isValidIndex = index >= 0 && index < count
        return isValidIndex ? self[index] : nil
    }
}
