//
//  CoinData.swift
//  ByteCoin
//
//  Created by Marcin Zieliński on 06/03/2024.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable{
    
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Float
    
}



