//
//  ViewController.swift
//  Marvelous
//
//  Created by Mark Turner on 11/9/18.
//  Copyright © 2018 Mark Turner. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mainTableView: UITableView!
    
    var responseTableViewData: ResponseData<Character>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(MyTableViewCell.self, forCellReuseIdentifier: "marvelCell")

        MarvelAPI().loadCharacters(offset: 10, limit: 50, success: { (response) in
            self.responseTableViewData = response
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }

        }){ (error) in
    
            let alertController = UIAlertController(title: "Error!", message: error.localizedDescription, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                print("You've pressed ok");
            }
            
            let retryAction = UIAlertAction(title: "Retry?", style: .default) { (action:UIAlertAction) in
                self.viewDidLoad()
            }
            alertController.addAction(okAction)
            alertController.addAction(retryAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseTableViewData?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = mainTableView.dequeueReusableCell(withIdentifier: "marvelCell", for: indexPath) as? MyTableViewCell
       {
        cell.characterTitle.text = self.responseTableViewData?.results[indexPath.row].name
        
        guard let url = self.responseTableViewData?.results[indexPath.row].thumbnail?.url
            else {
                let alertController = UIAlertController(title: "Error!", message: "Unable to load data!", preferredStyle: .alert)
                self.present(alertController, animated: true, completion: nil)
                return UITableViewCell()
        }
        cell.urlToImageData(imageUrl: url) { (image) in
            cell.characterImageView.image = image
        }
            return cell
        }
        return UITableViewCell()
    }
    
}

