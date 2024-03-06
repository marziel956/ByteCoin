//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    
    func didUpdateWeather(_ weatherManger:WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}



struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "YOUR_API_KEY_HERE"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    var delegate: CoinManagerDelegate?
    func getCoinPrice(for currency: String){
        
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
                    
                    if let weather = self.parseJSON(safeDate){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    
                }
                
            }
            
            //4.Start the task
            task.resume()
            
        }
    }
    
    
    
}
