//
//  RealmCommunicator.swift
//  ImageFinder
//
//  Created by vit on 4/11/19.
//  Copyright © 2019 vit. All rights reserved.
//

import Foundation
import RealmSwift

// Create an object template to save to the database
class GifsList: Object {
    @objc dynamic var gif: NSData?
    @objc dynamic var title = ""
}

struct RealmCommunicator {
    
    // access to database
    static let realm = try! Realm()
    static var items: Results<GifsList>!
    
    // Save object to db
    static func saveToRealm(title: String, url: String) {
         let gifUrl = URL(string: url)!
         
         if let gifData = NSData(contentsOf: gifUrl) {
             let newGif = GifsList()
             newGif.gif = gifData
             newGif.title = title
            
             try! realm.write {
                realm.add(newGif)
            }
        }
    }
    
    // read from db
    static func readFromRealm() -> [GifsList] {
        var result = [GifsList]()
        
        items = realm.objects(GifsList.self)
        for item in items {
            if item.gif != nil {
            } else {
                print("GIF NOT FOUND")
            }
            print(item.title)
            result.append(item)
        }
        return result
    }
    
    // delete all data from db
    static func deleteAllRealmData() {
        try! realm.write {
            realm.deleteAll()
            print("REALM CLEANED!")
        }
    }
    
    
}
