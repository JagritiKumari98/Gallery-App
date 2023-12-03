//
//  PhotosCollectionViewModel.swift
//  GalleryApp
//
//  Created by Jagriti on 02/12/23.
//

import UIKit
import Foundation

class PhotosCollectionViewModel {

    var imagesData = [Hit]()
    
    func searchImages(completion: @escaping () -> ()) {
        let apiRequest = EndPoints.imageSearchApi
        Network().requestApi(url:apiRequest, completion: {
            (response,error) in
            if let resp =  response {
                self.imagesData.removeAll()
                let welcome = try? JSONDecoder().decode(Hits.self, from: resp)
                self.imagesData = welcome?.hits ?? [Hit]()
                completion()
            }
        })
    }
    
}
