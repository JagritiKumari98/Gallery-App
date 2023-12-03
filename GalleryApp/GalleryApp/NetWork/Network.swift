//
//  Network.swift
//  GalleryApp
//
//  Created by Jagriti on 02/12/23.
//

import Foundation

class Network {

    func requestApi(url:String,completion: @escaping ((Data?,Error?)) -> ()) {
        guard let apiUrl = URL(string:url) else {
            print("Invalid Request")
            completion((nil,nil))
            return
        }
        print("Api Request: \(String(describing: apiUrl))")
        URLSession.shared.dataTask(with: apiUrl, completionHandler: {(data, response, error) -> Void in
            if data != nil {
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any] {
                    print("Api Response: \(jsonObj)")
                    completion((data,nil))
                }else {
                    print("Failed to Parse the response")
                    completion((nil,error))
                }
            }else {
                if error != nil {
                    print("Api request Failed: \(String(describing:error?.localizedDescription))")
                    completion((nil,error))
                }
            }
        }).resume()
    }
}
