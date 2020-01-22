//
//  FavoritesViewController.swift
//  PersistanceLab
//
//  Created by Melinda Diaz on 1/16/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    var allFavoriteImages = [Hits]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          guard let cell = sender as? ImagesCollectionViewCell,
            let indexPath = favoriteCollectionView.indexPath(for: cell),
            let detailedVC = segue.destination as? DetailedViewController else {
                      fatalError("Could not segue")}
              let eachCell = allFavoriteImages[indexPath.row]
              detailedVC.allDetailedImages = eachCell
    }

}
