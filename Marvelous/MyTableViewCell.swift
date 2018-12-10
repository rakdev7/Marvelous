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
    
    func urlToImageData(imageUrl:URL, onCompltetion:@escaping (UIImage)->()){
        var image = UIImage()
        DispatchQueue.global().async {
            if let data = NSData(contentsOf: imageUrl), let marvelImage = UIImage(data: data as Data){
                image = marvelImage
            }else{
                return
            }
            DispatchQueue.main.async {
                onCompltetion(image)
            }
        }
        
    }
    
    
    
    
}
