//
//  Image.swift
//  GalleryApp
//
//  Created by Jagriti on 01/12/23.
//

import UIKit

// MARK: - Hits
struct Hits: Codable {
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let largeImageURL: String
    let previewURL: String
}
