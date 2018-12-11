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
    let activityView = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(MyTableViewCell.self, forCellReuseIdentifier: "marvelCell")
        self.view.addSubview(activityView)
        activityView.center = self.view.center
        activityView.startAnimating()
        self.getCharacterData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseTableViewData?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = mainTableView.dequeueReusableCell(withIdentifier: "marvelCell", for: indexPath) as? MyTableViewCell
        {
            cell.characterTitle.text = self.responseTableViewData?.results[indexPath.row].name
            cell.characterImageView.image = UIImage(named: "cellImage")
            cell.imageUrl1 = self.responseTableViewData?.results[indexPath.row].thumbnail?.url
        
            guard let cellData = self.responseTableViewData?.results[indexPath.row].imageData
                else {
                    return loadCellImage(cell: cell, indexPath: indexPath)
                }
            cell.characterImageView.image = UIImage(data: cellData as Data)
            return cell
        }
        return UITableViewCell()
    }
    
    
    func getCharacterData() {
        MarvelAPI().loadCharacters(offset: 0, limit: 50, success: { (response) in
            self.responseTableViewData = response
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
                self.activityView.stopAnimating()
            }
        }){ (error) in
            self.serviceErrorAlert(error: error)
        }
    }
    
    func serviceErrorAlert(error:Error) {
        let alertController = UIAlertController(title: "Error!", message: error.localizedDescription, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
        }
        let retryAction = UIAlertAction(title: "Retry?", style: .default) { (action:UIAlertAction) in
            self.getCharacterData()
        }
        alertController.addAction(okAction)
        alertController.addAction(retryAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let count = responseTableViewData?.results.count, indexPath.row == count - 1 {}
    }
    
    func loadCellImage(cell:MyTableViewCell, indexPath:IndexPath)->UITableViewCell{
        let url = self.responseTableViewData?.results[indexPath.row].thumbnail?.url
        if let url = url {
            cell.urlToImageData(imageUrl: url) { (image,flag) in
                self.responseTableViewData?.results[indexPath.row].imageData = image as Data
                if flag {
                    cell.characterImageView.image = UIImage(data: image as Data)
                }
            }
        }
        return cell
    }
}

