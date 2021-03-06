//
//  CashContactController.swift
//  wyretrade
//
//  Created by brian on 3/21/21.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class CashContactController: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var itemTable: UITableView! {
        didSet {
            itemTable.delegate = self
            itemTable.dataSource = self
            itemTable.showsVerticalScrollIndicator = false
            itemTable.separatorColor = UIColor.darkGray
            itemTable.separatorStyle = .singleLineEtched
            itemTable.register(UINib(nibName: "BankContactItem", bundle: nil), forCellReuseIdentifier: "BankContactItem")
        }
    }
    
    var itemList = [BankModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func submitDelete(param: NSDictionary) {
        self.startAnimating()
        RequestHandler.removeBankFriend(parameter: param as NSDictionary, success: { (successResponse) in
                                self.stopAnimating()
        let dictionary = successResponse as! [String: Any]
        
        var bank : BankModel!
        
        if let historyData = dictionary["data"] as? [[String:Any]] {
            self.itemList = [BankModel]()
            for item in historyData {
                bank = BankModel(fromDictionary: item)
                if bank.type == 2 {
                    self.itemList.append(bank)
                }
                
            }
            self.itemTable.reloadData()
        }
                
            self.showToast(message: "Removed successfully")
        
        }) { (error) in
                        self.stopAnimating()
            let alert = Alert.showBasicAlert(message: error.message)
                    self.presentVC(alert)
        }
    }
    
    func submitAdd(param: NSDictionary) {
        self.startAnimating()
        RequestHandler.addBankFriend(parameter: param as NSDictionary, success: { (successResponse) in
                                self.stopAnimating()
        let dictionary = successResponse as! [String: Any]
        
        var bank : BankModel!
        
        if let historyData = dictionary["data"] as? [[String:Any]] {
            self.itemList = [BankModel]()
            for item in historyData {
                bank = BankModel(fromDictionary: item)
                if bank.type == 2 {
                    self.itemList.append(bank)
                }
                
            }
            self.itemTable.reloadData()
        }
                
            self.showToast(message: "Added successfully")
        
        }) { (error) in
                        self.stopAnimating()
            let alert = Alert.showBasicAlert(message: error.message)
                    self.presentVC(alert)
        }
    }
    
    func showForm(param: NSDictionary) {
        let alertController = UIAlertController(title: "Fill in form", message: nil, preferredStyle: .alert)
        let copyAction = UIAlertAction(title: "Add", style: .default) { (_) in
            let textField1 = alertController.textFields?.first as! UITextField
            let text1 = textField1.text
            if text1 == "" {
                textField1.shake(6, withDelta: 10, speed: 0.06)
                return
            }
            let textField2 = alertController.textFields?[1] as! UITextField
            let text2 = textField2.text
            if text2 == "" {
                textField2.shake(6, withDelta: 10, speed: 0.06)
                return
            }
            
            let param = [
                "currency": param["currency"] as? String,
                "alias": text1,
                "account_id": text2,
                
            ] as! NSDictionary
            self.submitAdd(param: param)
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Full Name"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Account ID"
        }
        
        
        alertController.addAction(copyAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func actionAdd(_ sender: Any) {
        let alertController = UIAlertController(title: "Select currency", message: "", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "USD", style: .default) { (_) in
            self.showForm(param: ["currency": "USD"])
        }
        let action2 = UIAlertAction(title: "EUR", style: .default) { action in
            self.showForm(param: ["currency": "EUR"])
        }
        let action3 = UIAlertAction(title: "GBP", style: .default) { action in
            self.showForm(param: ["currency": "GBP"])
        }
        let action4 = UIAlertAction(title: "SGD", style: .default) { action in
            self.showForm(param: ["currency": "SGD"])
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        alertController.addAction(action4)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        self.presentVC(alertController);
    }
    
   
}

extension CashContactController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BankContactItem = tableView.dequeueReusableCell(withIdentifier: "BankContactItem", for: indexPath) as! BankContactItem
        let item = itemList[indexPath.row]
        cell.lbAlias.text = item.alias
        cell.lbCurrency.text = item.currency.currency
        cell.id = item.id

        return cell
    }
}

extension CashContactController: BankContactParamDelegate {
    func deleteParam(param: NSDictionary) {
        let alert = Alert.showConfirmAlert(message: "Are you sure removing this contact?", handler: {
            (_) in self.submitDelete(param: param)
        })
        self.presentVC(alert)
    }
}
