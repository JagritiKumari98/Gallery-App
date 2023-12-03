//
//  PhotosCollectionAPI.swift
//  GalleryApp
//
//  Created by Jagriti on 02/12/23.

import Foundation


// MARK: - API Request and Response Hnadler
extension PhotosCollectionViewController {
    
    @objc func requestApi() {
            photosCollectionVm.searchImages(completion: { [weak self] () in
                DispatchQueue.main.async {
                    self?.receivedApiResponse()
                }
            })
    }
    
    func receivedApiResponse() {
         DispatchQueue.main.async {
            self.setupImageTasks()
            self.imageCollectionView?.reloadData()
         }
     }
     
    private func setupImageTasks() {
        
        for task in self.imageTasks {
            task.value.session.invalidateAndCancel()
        }
        imageTasks.removeAll()
        
        for i in 0..<self.photosCollectionVm.imagesData.count {
            var imageURL = ""
            switch viewStyle {
            case .fullScreenStyle:
                if let media = self.photosCollectionVm.imagesData.getElement(at:i) {
                    imageURL = media.largeImageURL
                }
            case .gridStyle:
               if let media = self.photosCollectionVm.imagesData.getElement(at:i) {
                    imageURL = media.previewURL
                }
            }
            if let url = URL(string:imageURL) {
                let imageTask = ImageTask(position: i, url: url, delegate: self)
                imageTasks[i] = imageTask
            }
        }
    }
    
}


// MARK: - Image Download Task Delegate
extension PhotosCollectionViewController:ImageTaskDownloadedDelegate {
    func imageDownloaded(position: Int) {
        if position < self.photosCollectionVm.imagesData.count {
            imageCollectionView.performBatchUpdates({
                self.imageCollectionView?.reloadItems(at: [IndexPath(row: position, section: 0)])
            }, completion: nil)
        }
    }
}
