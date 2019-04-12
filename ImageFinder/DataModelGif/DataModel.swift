//
//  File.swift
//  ImageFinder
//
//  Created by vit on 4/11/19.
//  Copyright © 2019 vit. All rights reserved.
//

import Foundation

// The Model of Data to Dacoding
struct ReceivedData: Decodable {
    let data: [AllAboutGif]
}

struct AllAboutGif: Decodable {
    let images: FirstGif
}

struct FirstGif: Decodable {
    let original: OriginalGif
}

struct OriginalGif: Decodable {
    let url: String
}
