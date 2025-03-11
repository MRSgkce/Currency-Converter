//
//  ViewController.swift
//  Currency Converter
//
//  Created by Mürşide Gökçe on 11.03.2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var CAD: UILabel!
    
    @IBOutlet weak var TRY: UILabel!
    @IBOutlet weak var USD: UILabel!
    @IBOutlet weak var GBP: UILabel!
    @IBOutlet weak var CHF: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func getRates(_ sender: Any) {
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")!
        let session = URLSession.shared //request
        //closure datayı işleme
        let task = session.dataTask(with: url){ (data,reponse,error) in
            
        if error != nil {
            let alert = UIAlertController(title: "error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            let okbutton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okbutton)
            self.present(alert, animated: true, completion: nil)
        }
            
            else {
                    if data != nil{
                        
                        do{
                            let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                            
                            DispatchQueue.main.async {
                                if let rates = jsonResponse["rates"] as? [String : Any]{
                                    if let cad = rates["CAD"] as? Double{
                                        self.CAD.text = "CAD: \(cad)"
                                        
                                    }
                                    if let chf = rates["CHF"] as? Double{
                                        self.CHF.text = "CHF: \(chf)"
                                    }
                                    if let gbp = rates["GBP"] as? Double{
                                        self.GBP.text = "GBP: \(gbp)"
                                    }
                                    if let jpy = rates["TRY"] as? Double{
                                        self.TRY.text = "TRY: \(jpy)"
                                    }
                                    if let usd = rates["USD"] as? Double{
                                        self.USD.text = "USD: \(usd)"
                                    }
                                }
                            }
                        }catch{
                            print(error)
                        }
                    }
                    
                }
            
            }
        task.resume()
        }
    }
    


