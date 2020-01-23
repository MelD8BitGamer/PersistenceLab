//
//  ImagesCollectionViewCell.swift
//  PersistanceLab
//
//  Created by Melinda Diaz on 1/16/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import UIKit
import ImageKit

class ImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCollection: UIImageView!
    
    public func configureCell(with picCell: Hits) {
        imageCollection.getImage(with: picCell.largeImageURL ?? "nil") { [weak self] (result) in
               switch result {
               case .failure:
                   DispatchQueue.main.async {
                       self?.imageCollection.image = UIImage(systemName: "exclamationmark-triangle")
                   }
               case .success(let image):
                   DispatchQueue.main.async {
                       self?.imageCollection.image = image
                   }
               }
               
           }
       }
    
}
