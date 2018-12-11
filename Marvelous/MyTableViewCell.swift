//
//  MyTableViewCell.swift
//  Marvelous
//
//  Created by Rocky on 12/9/18.
//  Copyright © 2018 Mark Turner. All rights reserved.
//

import Foundation
import UIKit

class MyTableViewCell: UITableViewCell {
    
    
    var imageUrl1:URL?
    
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
       imageView.backgroundColor = .red
        return imageView
    }()
    let characterTitle: UILabel = {
        let title = UILabel()
        title.backgroundColor = .orange
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
       super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(characterImageView)
        self.addSubview(characterTitle)
        [
        characterImageView.topAnchor.constraint(equalTo: self.topAnchor),
        characterImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
        characterImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        characterImageView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.3)
            ].forEach{
            $0.isActive = true
        }
        
        [
            characterTitle.topAnchor.constraint(equalTo: self.topAnchor),
            characterTitle.rightAnchor.constraint(equalTo: self.rightAnchor),
            characterTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            characterTitle.leftAnchor.constraint(equalTo: characterImageView.rightAnchor)
            ].forEach{
                $0.isActive = true
        }
    
    }
    
    func urlToImageData(imageUrl:URL, onCompltetion:@escaping (NSData,Bool)->()){
        var image = NSData()
        var flag = true
        DispatchQueue.global().async {
            if let data = NSData(contentsOf: imageUrl){
                image = data
            }else{
                return
            }
            DispatchQueue.main.async {
                flag = self.imageUrl1 == imageUrl ? true : false
                onCompltetion(image, flag)
            }
        }
        
    }
    
    
    
    
}
