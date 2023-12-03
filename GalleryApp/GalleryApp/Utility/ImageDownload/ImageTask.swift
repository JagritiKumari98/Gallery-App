//
//  ImageTask.swift
//  GalleryApp
//
//  Created by Jagriti on 02/12/23.
//

import UIKit

protocol ImageTaskDownloadedDelegate: AnyObject {
    func imageDownloaded(position: Int)
}

class ImageTask {
    
    let position: Int
    let url: URL
    let session: URLSession
    weak var delegate: ImageTaskDownloadedDelegate?
    
    var image: UIImage?
    
    private var task: URLSessionDownloadTask?
    private var resumeData: Data?
    
    private var isDownloading = false
    private var isFinishedDownloading = false

    init(position: Int, url: URL, delegate: ImageTaskDownloadedDelegate) {
        self.position = position
        self.url = url
        self.session = URLSession(configuration: URLSessionConfiguration.default)
        self.delegate = delegate
    }
    
    func resume() {
        if !isDownloading && !isFinishedDownloading {
            isDownloading = true
            
            if let resumeData = resumeData {
                task = session.downloadTask(withResumeData: resumeData, completionHandler: downloadTaskCompletionHandler)
            } else {
                task = session.downloadTask(with: url, completionHandler: downloadTaskCompletionHandler)
            }
            
            task?.resume()
        }
    }
    
    func pause() {
        if isDownloading && !isFinishedDownloading {
            task?.cancel(byProducingResumeData: { (data) in
                self.resumeData = data
            })
            
            self.isDownloading = false
        }
    }
    
    private func downloadTaskCompletionHandler(url: URL?, response: URLResponse?, error: Error?) {
        if let error = error {
            print("Error downloading: ", error)
            return
        }
        
        guard let url = url else { return }
        guard let data = FileManager.default.contents(atPath: url.path) else { return }
        guard let image = UIImage(data: data) else { return }
        
        
        DispatchQueue.main.async {
            print("Image Downloaded successfully: ")
            self.image = image
            self.delegate?.imageDownloaded(position: self.position)
        }
        
        self.isFinishedDownloading = true
    }
}
