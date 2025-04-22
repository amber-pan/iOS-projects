//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Amber Pan on 11/09/2019.
//

import Foundation

protocol CoinManagerDelegate {
    func didFailWithError(_ error: Error)
    func didGetCoinPrice(_ rate: Double)
}

struct CoinManager {
      var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "YOUR_API_KEY_HERE"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    func getCoinPrice(for currency: String){
        let curl = "\(baseURL)/\(currency)?apikey=EFC4FC34-9D6D-4D6E-B46B-C836CA1E3FF9"
        print (curl)
        performRequest(with: curl)
    }
    
    func performRequest(with urlString: String){
        //create a URL
        //URLs cannot contain spaces. URL encoding normally replaces a space with a plus (+) sign or with %20.
        if let url = URL(string: urlString){
            
            //create a URLSession
            
            let session = URLSession(configuration: .default)
            
            //give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data //when data is retreived form the url, parse it into JSON format and get the interested values in the JSON structure
                {
                    if let dataString = String(data: safeData, encoding: .utf8)
                    {print(dataString)}
                    
                                        if let rate = self.parseJSON(safeData)//put interested values into a datamodel structure ready to be used by the app
                                        {
                                            self.delegate?.didGetCoinPrice(rate)//pass the result to the control that signed up to be the delegate
                                        }
                }
            }
            //start the task
            task.resume()
            
        }
    }
    
    func parseJSON(_ data: Data)-> Double?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let rate = decodedData.rate
            
            return rate
        }catch{
            print (error)
            self.delegate?.didFailWithError(error)
            return nil
        }
    }
}
