//
//  ViewController.swift
//  Api
//
//  Created by Atil Samancioglu on 19/06/2017.
//  Copyright © 2017 Atil Samancioglu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchForCurrency(currency: searchBar.text!)
        searchBar.text = ""
    }
    
    
    func searchForCurrency(currency: String) {
        
        let url = URL(string: "http://api.fixer.io/latest?base=\(currency)")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                if data != nil {
                    do {
                        
                        let jSONResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, AnyObject>
                        
                        DispatchQueue.main.async {
                            print(jSONResult)
                            
                            let rates = jSONResult["rates"] as! [String:AnyObject]
                            
                            let usd = String(describing: rates["USD"]!)
                            self.usdLabel.text = "USD: \(usd)"
                            
                            let cad = String(describing: rates["CAD"]!)
                            self.cadLabel.text = "CAD: \(cad)"
                            
                            let chf = String(describing: rates["CHF"]!)
                            self.chfLabel.text = "CHF: \(chf)"
                            
                        }
                        
                    } catch {
                        
                    }
                }
            }
            
            
        }
        task.resume()
    }

}

