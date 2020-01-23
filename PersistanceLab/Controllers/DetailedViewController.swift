//
//  DetailedViewController.swift
//  PersistanceLab
//
//  Created by Melinda Diaz on 1/16/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import UIKit
import DataPersistence

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var detailedImageView: UIImageView!
    @IBOutlet weak var userOutlet: UILabel!
    @IBOutlet weak var tagOutlet: UILabel!
    @IBOutlet weak var idOutlet: UILabel!
    
    var allDetailedImages: Hits?
    var persistanceHelperRef = DataPersistence<Hits>()//This is your handler to use DataPersistance
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    @IBAction func favoriteHeartButton(_ sender: UIBarButtonItem) {
        guard let unwrapped = allDetailedImages else {
         showAlert(title: "error", message: "Nothing worked")
            return
        }
    
        persistanceHelperRef.save(item: unwrapped)
        //this message is for the user that they have added this into their favorites
        showAlert(title: "Added to Favorites", message: "You successfully added this to your favorites! You may now find this picture in your favorites tab")
        }
    
    func setUp() {
        guard let x = allDetailedImages else {
        showAlert(title: "No data", message: "cant set up detail")
        return
        }
        userOutlet.text = x.user
        tagOutlet.text = x.tags
        idOutlet.text = "\(x.id)"
        
        detailedImageView.getImage(with: x.largeImageURL) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Image Error", message: "No image available \(appError)")
                    self?.detailedImageView.image = UIImage(named: "uhoh")
                }
            case .success(let imageURL):
                DispatchQueue.main.async {
                    self?.detailedImageView.image = imageURL
                }
            }
        }
    }
}

