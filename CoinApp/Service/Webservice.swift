//
//  Webservice.swift
//  CoinApp
//
//  Created by mervekarabulut on 3.08.2023.
//

import Foundation

enum CryptoError : Error {
    case serverError
    case parsingError
}

class Webservice {
    func downloadCurrencies (url: URL, completion: @escaping (Result<[CryptoModel], CryptoError>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.serverError))
            } else if let data = data {
                let cryptoList = try?
                JSONDecoder().decode([CryptoModel].self, from: data)
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList))
                } else {
                    completion(.failure(.parsingError))
                }
            }
        }.resume()
    }
}
