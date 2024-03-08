//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
 

    @IBOutlet weak var coinLabel: UIStackView!
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBOutlet weak var bitCoinPrice: UILabel!
    
    
    var coinManager = CoinManager()
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        coinManager.delegate = self

       
        // Do any additional setup after loading the view.
        
     
     
    }
    
    
    
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        
        coinManager.getCoinPrice(for: selectedCurrency)
        
        print(coinManager.currencyArray[row])
    }
    
    

    
    
    
    
}


extension ViewController: CoinManagerDelegate {
    
    func didUpdateCoin(_ coinManager:CoinManager, coin: CoinModel) {
        
        DispatchQueue.main.async {
            self.bitCoinPrice.text = String(coin.cena)
            self.currencyLabel.text = coin.waluta_2
          
        }
        
    }
    func didFailWithError(error: Error) {
        print(error)
    }
    
}


