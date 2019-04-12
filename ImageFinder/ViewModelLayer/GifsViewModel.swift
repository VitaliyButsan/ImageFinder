//
//  GifsViewModel.swift
//  ImageFinder
//
//  Created by vit on 4/11/19.
//  Copyright © 2019 vit. All rights reserved.
//

import Foundation

class GifsViewModel {

    // Save a data received from the Realm
    var arrayOfGifs = [GifsList]()
    
    //search Gif
    func searchGif(withTitle title: String, complitionHandler: @escaping (String?) -> Void) {
        GifsCommunicator.getGif(withTitle: title) { (data) in
            switch data {
            case .none:
                complitionHandler(nil)
            case .some(let gif):
                complitionHandler(gif.url)
            }
        }
    }
    
    // Save gif to db
    func saveGif(title: String, url: String) {
        RealmCommunicator.saveToRealm(title: title, url: url)
    }
    
    // Read gif image and gif name from db
    func getSavedGif(){
       arrayOfGifs = RealmCommunicator.readFromRealm()
    }
    
}
