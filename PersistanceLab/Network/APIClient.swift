//
//  APIClient.swift
//  PersistanceLab
//
//  Created by Melinda Diaz on 1/16/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import Foundation
import NetworkHelper


struct APIClient {
    static func fetchData(userSearch: String , completion: @escaping (Result<[Hits], AppError>) -> ()) {
        
        let endpointURLString = "https://pixabay.com/api/?key=\(SecretKey.key)&q=\(userSearch)"
        
        guard let url = URL(string: endpointURLString) else {
            completion(.failure(.badURL(endpointURLString)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let results = try JSONDecoder().decode(PixaBayImage.self, from: data)
                    completion(.success(results.hits))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
