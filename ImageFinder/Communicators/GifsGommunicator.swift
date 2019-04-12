//
//  GifsGomunicator.swift
//  ImageFinder
//
//  Created by vit on 4/11/19.
//  Copyright © 2019 vit. All rights reserved.
//

import Foundation

struct GifsCommunicator {
    
    static func getGif(withTitle title: String, completionHandler: @escaping (OriginalGif?) -> Void){
            // create URLRequest from url
            let gifsUrl = "https://api.giphy.com/v1/gifs/search?q=\(title)&api_key=k9vOiam3eVlRBO9hKWV3JLPRmhRU6zww"
            guard let url = URL(string: gifsUrl) else { return }
            let urlRequest = URLRequest(url: url)
            
            // url request
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                guard let data = data, error == nil else { return }
                do {
                    let result = try JSONDecoder().decode(ReceivedData.self, from: data)
                    if result.data.isEmpty {
                        completionHandler(nil)
                    } else {
                        completionHandler(result.data[0].images.original)
                    }
                } catch {
                    completionHandler(nil)
                }
            }.resume()
        }

}


