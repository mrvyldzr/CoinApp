//
//  CryptoViewModel.swift
//  CoinApp
//
//  Created by mervekarabulut on 5.08.2023.
//

import Foundation
import RxSwift
import RxCocoa

class CryptoViewModel {
    
    let cryptos : PublishSubject<[CryptoModel]> = PublishSubject()
    let error : PublishSubject<String> = PublishSubject()
    let loading : PublishSubject<Bool> = PublishSubject()
    
    
    func requestData () {
        self.loading.onNext(true)
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        Webservice().downloadCurrencies(url: url) { result in
            self.loading.onNext(false)
            switch result {
            case .success(let cryptos):
                self.cryptos.onNext(cryptos)
            case .failure(let error):
                print(error)
                switch error {
                case .parsingError:
                    self.error.onNext("Parsing Error")
                case .serverError:
                    self.error.onNext("Server Error")
                }
            }
        }
    }
}
