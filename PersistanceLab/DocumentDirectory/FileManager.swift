//
//  FileManager.swift
//  PersistanceLab
//
//  Created by Melinda Diaz on 1/21/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import Foundation

class DataFileManager {
    //FileManager is built in and it gets the contents of the file and add and create within the file
    static func documentDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    static func filePathToDirectory(filename: String) -> URL {
        return documentDirectory().appendingPathComponent(filename)
    }
}
