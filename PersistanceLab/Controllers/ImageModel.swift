//
//  ImageModel.swift
//  PersistanceLab
//
//  Created by Melinda Diaz on 1/16/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import Foundation



struct PixaBayImage: Codable {
    let hits: [Hits]
  
}

struct Hits: Codable, Equatable {
    let largeImageURL: String
    let id: Int
    let tags: String
    let user: String
    
}
