//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate:AnyObject {
    func updatePrice(_ coinManager: CoinManager, price: Double, currency: String)
    func didFailWithError(error:Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "YOUR_API_KEY_HERE"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate:CoinManagerDelegate?
    
    func getBitcoinPrice(for currency:String) {
        let urlString = "\(self.baseURL)/\(currency)?apiKey=\(self.apiKey)"
        print(urlString)
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    //var backToString = (String(data: safeData, encoding: String.Encoding.utf8) ?? "") as String
                    if let price = self.parseJSON(safeData) {
                        delegate?.updatePrice(self, price: price, currency: currency)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            print(lastPrice ?? "")
            return lastPrice
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
