//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    
    func didUpdateCoin(_ coinManger: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}



struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "APIKEY="
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    
    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)/\(currency)?\(apiKey)"
        
        print(urlString)
        
    performRequest(with: urlString)
        
    }
    
    func performRequest(with urlString: String){
        //1.Create a url
        if let url = URL(string: urlString){
            
            //2.Create a URLSession
            
            let session = URLSession(configuration: .default)
            
            //3.Give the session a task
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    print(error!)
                    return
                }
                if let safeDate = data {
                    
                    if let coin = self.parseJSON(safeDate){
                        self.delegate?.didUpdateCoin(self, coin: coin)
                    }
                    
                }
                
            }
            
            //4.Start the task
            task.resume()
            
        }
    }
    
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        
        let decoder = JSONDecoder()
        
        do{
            let decodeData = try decoder.decode(CoinData.self, from: coinData)
            
            
            
            let time = decodeData.time
            let asset_id_base = decodeData.asset_id_base
            let asset_id_quote = decodeData.asset_id_quote
            let rate = decodeData.rate
            
            
            let coin = CoinModel(czas: time, waluta_1: asset_id_base, waluta_2: asset_id_quote, cena: rate)
            
            print(decodeData.time)
            print(decodeData.asset_id_base)
            print(decodeData.asset_id_quote)
            print(decodeData.rate)
            

            return coin
    
            
            
        }catch
        {
            delegate?.didFailWithError(error: error)
            print(error)
            return nil
        }
    }
}
    

