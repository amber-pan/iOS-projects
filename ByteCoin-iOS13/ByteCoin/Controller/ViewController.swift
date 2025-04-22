//
//  ViewController.swift
//  ByteCoin
//
//  Created by Amber Pan on 11/09/2019.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var bitcoinLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
    
}
//MARK: - UIPickerViewDataSource & UIPickerViewDelegate
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            
            return coinManager.currencyArray.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return coinManager.currencyArray[row]
            
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            print(row)
            print(coinManager.currencyArray[row])
            let selectedCurrency = coinManager.currencyArray[row]
            self.currencyLabel.text = selectedCurrency
            coinManager.getCoinPrice(for: selectedCurrency)
        }
}
//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    func didFailWithError(_ error: Error) {
         print(error)
     }
     
     func didGetCoinPrice(_ rate: Double) {
         print(rate)
         DispatchQueue.main.async { // Correct
             self.bitcoinLabel.text = String(format: "%.2f", rate)
             
         }
     }
}
