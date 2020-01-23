//
//  FavoritesViewController.swift
//  PersistanceLab
//
//  Created by Melinda Diaz on 1/16/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import UIKit
import DataPersistence

class FavoritesViewController: UIViewController {
//ToDO: Fix alert when you sucessfully posted
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    var allFavoriteImages = [Hits]()
    var dataRef = DataPersistence<Hits>()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
        allFavoriteImages = try dataRef.loadItems()
            
        } catch {
    showAlert(title: "Error", message: "Cannot load favorites \(error)")
        }
        favoriteCollectionView.dataSource = self
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

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allFavoriteImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as? ImagesCollectionViewCell else {
            fatalError("Could not load favorites")}
        let images = allFavoriteImages[indexPath.row]
        cell.configureCell(with: images)
        return cell
        }
    }
    
    

