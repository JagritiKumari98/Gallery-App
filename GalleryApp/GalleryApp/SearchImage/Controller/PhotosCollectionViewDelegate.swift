//
//  PhotosCollectionViewControllerDelegate.swift
//  GalleryApp
//
//  Created by Jagriti on 02/12/23.
//

import UIKit

 // MARK: - CollectionView Delegate FlowLayout
extension PhotosCollectionViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewStyle {
        case .gridStyle:
            if switchViewButton.tag == 1 {
                return CGSize(width:self.view.frame.size.width/2, height:self.view.frame.size.width/2)
            }else{
                return CGSize(width:self.view.frame.size.width, height:self.view.frame.size.width)
            }
        case .fullScreenStyle:
            return CGSize(width:collectionView.frame.size.width, height:collectionView.frame.size.height)
        }
    }
}

// MARK: - CollectionView Delegate and Data Source
extension PhotosCollectionViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photosCollectionVm.imagesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        imageTasks[indexPath.row]?.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        imageTasks[indexPath.row]?.pause()
    }
    
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:ImageCollectionViewCell.identifier, for:indexPath) as! ImageCollectionViewCell
        let image = imageTasks[indexPath.row]?.image
        cell.set(image: image)
        cell.viewStyle = viewStyle
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewStyle == .gridStyle {
            if let searchVc = self.storyboard?.instantiateViewController(identifier:PhotosCollectionViewController.identifier) as? PhotosCollectionViewController {
                searchVc.viewStyle = .fullScreenStyle
                searchVc.photosCollectionVm.imagesData = self.photosCollectionVm.imagesData
                searchVc.receivedApiResponse()
                searchVc.scrollToItem(scrollToIndex:indexPath.row)
                searchVc.navigationController?.navigationItem.hidesBackButton = false
                self.navigationController?.pushViewController(searchVc, animated:true)
            }
        }
    }
}


