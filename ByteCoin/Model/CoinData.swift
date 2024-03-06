//
//  CoinData.swift
//  ByteCoin
//
//  Created by Marcin Zieliński on 06/03/2024.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable{
    
    let name: String
    let main: Main
    let coin: [Coin]
    
    
    
}

struct Main: Codable{
    
    let bnc: Float
}


struct Coin: Codable{
    
    let description: String
    let id: Int
}
