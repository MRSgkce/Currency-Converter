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
    
    @IBOutlet weak var tableView: UITableView!
    
    var para = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource=self
        tableView.delegate=self
        
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
                            
                            
                            /*DispatchQueue.main.async {
                                if let rates = jsonResponse["rates"] as? [String : Any]{
                                    
                                    if let cad = rates["CAD"] as? Double{
                                        self.CAD.text = "CAD: \(cad)"
                                        self.para.append("CAD: \(cad)")
                                        
                                    }
                                    if let chf = rates["CHF"] as? Double{
                                        self.CHF.text = "CHF: \(chf)"
                                      //  para.append(chf)
                                    }
                                    if let gbp = rates["GBP"] as? Double{
                                        self.GBP.text = "GBP: \(gbp)"
                                       // para.append(gbp)
                                    }
                                    if let jpy = rates["TRY"] as? Double{
                                        self.TRY.text = "TRY: \(jpy)"
                                       //para.append(jpy)
                                    }
                                    if let usd = rates["USD"] as? Double{
                                        self.USD.text = "USD: \(usd)"
                                        //para.append(usd)
                                    }
                                    self.tableView.reloadData()*/
                            
                            DispatchQueue.main.async {
                                if let rates = jsonResponse["rates"] as? [String: Any] {
                                    self.para.removeAll() // Eski verileri temizleyelim (tekrar eklenmesin diye)
                                    
                                    for (currency, value) in rates {
                                        if let rate = value as? Double {
                                            let currencyString = "\(currency): \(rate)"
                                            self.para.append(currencyString)
                                        }
                                    }
                                    
                                    // TableView'ı yenile
                                    self.tableView.reloadData()
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
    


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        para.count
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = para[indexPath.row]
        return cell
    }
}
