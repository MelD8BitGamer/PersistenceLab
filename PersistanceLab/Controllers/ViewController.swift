//
//  ViewController.swift
//  PersistanceLab
//
//  Created by Melinda Diaz on 1/16/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageSearch: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var allPics = [Hits]() {
    didSet{
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    }
    
    var userQuery = "" {
    didSet {
        allPics = allPics.filter{$0.tags.lowercased().contains(self.userQuery.lowercased())}
            }
        }

        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSearch.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        setUp()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? ImagesCollectionViewCell,
            let indexPath = collectionView.indexPath(for: cell),
            let detailedVC = segue.destination as? DetailedViewController else {
                fatalError("Could not segue")}
        let eachCell = allPics[indexPath.row]
        detailedVC.allDetailedImages = eachCell
    }
    func setUp() {
           APIClient.fetchData() { [weak self] (result) in
               switch result {
               case .failure(let appError):
                   DispatchQueue.main.async {
                       self?.showAlert(title: "Error", message: "Cannot load pics \(appError)")
                   }
               case .success(let data):
                   self?.allPics = data
               }
           }
       }

@IBAction func favoritesButton(_ sender: UIBarButtonItem) {
}
}

extension ViewController: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImagesCollectionViewCell else {
            fatalError("Blah")
        }
        let pictureImage = allPics[indexPath.row]
        cell.configureCell(with: pictureImage)
        return cell
       }
       
}

extension ViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   let interItemSpacing: CGFloat = 10 //This is the space between items. if we dont type annotate it from Int to cgfloat it will expect an Int
   let maxWidth = UIScreen.main.bounds.size.width //device width
   let numberOfItems: CGFloat = 2 //items
   let totalSpacing: CGFloat = numberOfItems * interItemSpacing
   let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
   
   return CGSize(width: itemWidth, height: itemWidth)
}
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 20, left: 0, bottom: 5, right: 0)
           //interface builder automatically resizes(self-resizing) the cells by default so we have to fix that!!!! it is done via interface builder NOTCODE. So we have to set the estimated size on the collectionview from automatic to none
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 5
       }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           guard !searchText.isEmpty else {
               setUp()
               return
           }
           userQuery = searchText
       }
}
