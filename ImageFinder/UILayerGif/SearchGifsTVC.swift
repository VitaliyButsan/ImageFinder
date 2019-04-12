//
//  SearchGifsTVC.swift
//  ImageFinder
//
//  Created by vit on 4/11/19.
//  Copyright © 2019 vit. All rights reserved.
//

import UIKit

class SearchGifsTVC: UITableViewController {
    
    private let gifsViewModel = GifsViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchController()
        gifsViewModel.getSavedGif()
        tableView.allowsSelection = false
        
        tableView.register(GifsTableViewCell.self, forCellReuseIdentifier: "GifsCell")
    }
    
    // Set up the search controller
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search Image"
        searchController.searchBar.tintColor = UIColor(cgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        searchController.searchBar.textField?.addTarget(self, action: #selector(trigger), for: UIControl.Event.primaryActionTriggered)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    @objc func trigger(){
        if let inputText = searchController.searchBar.text {
            gifsViewModel.searchGif(withTitle: inputText ){ (link) in
                if link != nil {
                    DispatchQueue.main.async {
                        // Save gif to db
                        self.gifsViewModel.saveGif(title: inputText, url: link!)
                        // Get gif from db
                        self.gifsViewModel.getSavedGif()
                        // Reload tableView
                        self.tableView.reloadData()
                    }
                } else {
                    self.alertHandler()
                }
            }
        }
    }
    
    // alert
    func alertHandler() {
        let alert = UIAlertController(title: "Image not found!", message: "Try to find another Image", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gifsViewModel.arrayOfGifs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GifsCell", for: indexPath) as! GifsTableViewCell
        let reverseGif = gifsViewModel.arrayOfGifs.count - indexPath.row - 1
        cell.updateCell(title: gifsViewModel.arrayOfGifs[reverseGif].title, gif: gifsViewModel.arrayOfGifs[reverseGif].gif)
        return cell
    }
   
}


extension SearchGifsTVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
       
    }
}

extension UISearchBar {
    // Access to textField of searchBar
    public var textField: UITextField? {
        let subViews = subviews.flatMap { $0.subviews }
        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }
        return textField
    }
}


