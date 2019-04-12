//
//  GifsTableViewCell.swift
//  ImageFinder
//
//  Created by vit on 4/12/19.
//  Copyright © 2019 vit. All rights reserved.
//

import UIKit

class GifsTableViewCell: UITableViewCell {
    
    var titleView: UITextView = {
        var title = UITextView()
        title.isEditable = false
        title.font = .systemFont(ofSize: 22)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    var gifImageView: UIImageView = {
        var gifView = UIImageView()
        gifView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        gifView.translatesAutoresizingMaskIntoConstraints = false
        return gifView
    }()
    
    func updateCell(title: String, gif: NSObject?){
        titleView.text = title
        if gif != nil {
            if let image = UIImage(data: gif! as! Data) {
                gifImageView.image = image
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(titleView)
        self.addSubview(gifImageView)
        setConstraintsToTitleView()
        setConstraintsToGifImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Vit init(coder:) has not been implemented")
    }
    
    
    func setConstraintsToTitleView(){
        titleView.leftAnchor.constraint(equalTo: gifImageView.rightAnchor, constant: 10).isActive = true
        titleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        titleView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/4).isActive = true
        titleView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setConstraintsToGifImageView(){
        gifImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        gifImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        gifImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        gifImageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
