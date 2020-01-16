//
//  APIClient.swift
//  PersistanceLab
//
//  Created by Melinda Diaz on 1/16/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import Foundation

struct APIClient {
    static func fetchData(completion: @escaping (Result<[String], AppError>) -> ()) {
        let endpointURLString = "https://dog.ceo/api/breeds/image/random/50"
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
                    let results = try JSONDecoder().decode(RandomDogInfo.self, from: data)
                    completion(.success(results.message))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
