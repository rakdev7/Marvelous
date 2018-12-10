//
//  ViewController.swift
//  Marvelous
//
//  Created by Mark Turner on 11/9/18.
//  Copyright © 2018 Mark Turner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     let marvelApiInstance = MarvelAPI()
        
        marvelApiInstance.loadCharacters(offset: 10, limit: 20, success: { (response) in
            
            print("success")
        }) { (Error) in
            print("error")
        }
        
    }


}

