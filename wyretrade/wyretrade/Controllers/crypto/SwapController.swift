//
//  SwapController.swift
//  wyretrade
//
//  Created by maxus on 3/1/21.
//

import UIKit

class SwapController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtSellAmount: UITextField! {
        didSet {
            txtSellAmount.delegate = self
        }
    }
    @IBOutlet weak var lbSendCoinBalance: UILabel!
//    @IBOutlet weak var lbBuyCoinBalance: UILabel!
    @IBOutlet weak var lbBuyEstAmount: UILabel!
    @IBOutlet weak var lbSwapRate: UILabel!
    @IBOutlet weak var lbSendingLimit: UILabel!
    
    @IBOutlet weak var lbFee: UILabel!
    
    @IBOutlet weak var sendingIcon: UIImageView!
    @IBOutlet weak var receiveIcon: UIImageView!
    
    @IBOutlet weak var btnSendCoin: UIButton! {
        didSet {
            btnSendCoin.semanticContentAttribute = .forceRightToLeft
        }
    }
    @IBOutlet weak var btnReceiveCoin: UIButton! {
        didSet {
            btnReceiveCoin.semanticContentAttribute = .forceRightToLeft
        }
    }
    
    
    
//    @IBOutlet weak var historyTable: UITableView!{
//        didSet {
//            historyTable.delegate = self
//            historyTable.dataSource = self
//            historyTable.showsVerticalScrollIndicator = false
//            historyTable.separatorColor = UIColor.darkGray
//            historyTable.separatorStyle = .singleLineEtched
//            historyTable.register(UINib(nibName: "SwapItem", bundle: nil), forCellReuseIdentifier: "SwapItem")
//        }
//    }
    
//    var historyList = [SwapModel]()
    var coinList = [CoinModel]()
    var rateModel: SwapRateModel!
//    var buyCoinList = [CoinModel]()
    var sendCoin: CoinModel!
    var receiveCoin: CoinModel!
    
    var sellAmount = 0.1
    var receiveAmount = 0.0
    var selectedType = "buy"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu")!)
        txtSellAmount.addTarget(self, action: #selector(StocksBuyController.amountTextFieldDidChange), for: .editingChanged)
        self.loadData()
//        self.loadHistory()
    }
    
    
    
    func loadData() {
        let param : [String : Any] = [:]
        RequestHandler.getCoinExchange(parameter: param as NSDictionary, success: { (successResponse) in
//                        self.stopAnimating()
            let dictionary = successResponse as! [String: Any]
            
            var coin : CoinModel!
            
            if let coins = dictionary["coins"] as? [[String:Any]] {
                self.coinList = [CoinModel]()
                for item in coins {
                    coin = CoinModel(fromDictionary: item)
                    self.coinList.append(coin)
                }
                
            }
            
            
            self.rateModel = SwapRateModel(fromDictionary: dictionary["rate"] as! [String : Any])
            self.sendCoin = CoinModel(fromDictionary: dictionary["sendCoin"] as! [String : Any])
            self.receiveCoin = CoinModel(fromDictionary: dictionary["receiveCoin"] as! [String : Any])
            
            self.lbSendCoinBalance.text = self.sendCoin.balance
            self.receiveIcon.load(url: URL(string: self.receiveCoin.icon)!)
            self.btnReceiveCoin.setTitle(self.receiveCoin.symbol, for: .normal)
            
            self.displayEstCost()
            self.displayExchangeRate()
            
            }) { (error) in
                let alert = Alert.showBasicAlert(message: error.message)
                        self.presentVC(alert)
            }
    }
    
    
    @objc func amountTextFieldDidChange(_ textField: UITextField) {
        guard let amount = self.txtSellAmount.text else {
            return
        }
        
        if amount == "" {
            self.sellAmount = 0.0
        } else {
            self.sellAmount = Double(amount)!
        }
        
        self.displayEstCost()
    }
    
//    func loadHistory() {
//        let param : [String : Any] = [:]
//        RequestHandler.getCoinExchangeList(parameter: param as NSDictionary, success: { (successResponse) in
////                        self.stopAnimating()
//            let dictionary = successResponse as! [String: Any]
//
//            var history : SwapModel!
//
//            if let historyData = dictionary["data"] as? [[String:Any]] {
//                self.historyList = [SwapModel]()
//                for item in historyData {
//                    history = SwapModel(fromDictionary: item)
//                    self.historyList.append(history)
//                }
//                self.historyTable.reloadData()
//            }
//
//
//            }) { (error) in
//                let alert = Alert.showBasicAlert(message: error.message)
//                        self.presentVC(alert)
//            }
//    }
    
    func submitExchange() {
        
        
        
            let param : [String : Any] = [
                "sendCoin" : self.sendCoin.symbol!,
                "receiveCoin": self.receiveCoin.symbol!,
                "send_amount" : self.sellAmount,
                "receive_amount": self.receiveAmount
            ]
            
//                    self.showLoader()
            RequestHandler.coinExchange(parameter: param as NSDictionary, success: { (successResponse) in
//                        self.stopAnimating()
                let dictionary = successResponse as! [String: Any]
                
//                var history : SwapModel!
                
//                self.showToast(message: dictionary["message"] as! String)
                self.showToast(message: "Requested successfully")
                
                self.sendCoin = CoinModel(fromDictionary: dictionary["sendCoin"] as! [String : Any])
                self.lbSendCoinBalance.text = self.sendCoin.balance
//                if let historyData = dictionary["history"] as? [[String:Any]] {
//                    self.historyList = [SwapModel]()
//                    for item in historyData {
//                        history = SwapModel(fromDictionary: item)
//                        self.historyList.append(history)
//                    }
//                    self.historyTable.reloadData()
//                }
            }) { (error) in
                let alert = Alert.showBasicAlert(message: error.message)
                        self.presentVC(alert)
            }
        
    }
    
    func getBuyCoins() {
        let param : [String : Any] = ["send_coin_id": self.sendCoin.id!]
        
//                    self.showLoader()
        RequestHandler.coinExchangeBuyAssets(parameter: param as NSDictionary, success: { (successResponse) in
//                        self.stopAnimating()
            let dictionary = successResponse as! [String: Any]
            
            var coin : CoinModel!
            
//            if let coins = dictionary["assets"] as? [[String:Any]] {
//                self.buyCoinList = [CoinModel]()
//                for item in coins {
//                    coin = CoinModel(fromDictionary: item)
//                    self.buyCoinList.append(coin)
//                }
//                let detailController = self.storyboard?.instantiateViewController(withIdentifier: "CoinSelectController") as! CoinSelectController
//                detailController.delegate = self
//                detailController.coinList = self.buyCoinList
//                self.navigationController?.pushViewController(detailController, animated: true)
//            }
        }) { (error) in
            let alert = Alert.showBasicAlert(message: error.message)
                    self.presentVC(alert)
        }
    }
    
    func getSellCoins() {
        let param : [String : Any] = [:]
        
//                    self.showLoader()
        RequestHandler.coinExchangeSendAssets(parameter: param as NSDictionary, success: { (successResponse) in
//                        self.stopAnimating()
            let dictionary = successResponse as! [String: Any]
            
            var coin : CoinModel!
            
            if let coins = dictionary["assets"] as? [[String:Any]] {
////                self.sendCoinList = [CoinModel]()
////                for item in coins {
////                    coin = CoinModel(fromDictionary: item)
////                    self.sendCoinList.append(coin)
////                }
//                let detailController = self.storyboard?.instantiateViewController(withIdentifier: "CoinSelectController") as! CoinSelectController
//                detailController.delegate = self
//                detailController.coinList = self.sendCoinList
//                self.navigationController?.pushViewController(detailController, animated: true)
            }
        }) { (error) in
            let alert = Alert.showBasicAlert(message: error.message)
                    self.presentVC(alert)
        }
    }
    
    func getRate() {
        let param : [String : Any] = [
            "sendCoin": self.sendCoin.symbol!,
            "receiveCoin": self.receiveCoin.symbol!
        ]
        
//                    self.showLoader()
        RequestHandler.getCoinExchangeRate(parameter: param as NSDictionary, success: { (successResponse) in
//                        self.stopAnimating()
            let dictionary = successResponse as! [String: Any]
            
            self.rateModel = SwapRateModel(fromDictionary: dictionary["rate"] as! [String: Any])
            
            self.displayEstCost()
            self.displayExchangeRate()
            
        }) { (error) in
            let alert = Alert.showBasicAlert(message: error.message)
                    self.presentVC(alert)
        }
    }
    
    func displayExchangeRate() {
        self.lbSwapRate.text = "1 \(self.sendCoin.symbol!) ± \(self.rateModel.rate!) \(self.receiveCoin.symbol!)"
        self.lbSendingLimit.text = "\(self.rateModel.min!) - \(self.rateModel.max!)"
        self.lbFee.text = "\(self.rateModel.fee!)"
    }
    
    func displayEstCost() {
        self.receiveAmount = self.sellAmount * self.rateModel.rate
        self.lbBuyEstAmount.text = NumberFormat(value: self.sellAmount * self.rateModel.rate - self.rateModel.fee, decimal: 4).description
    }

    @IBAction func actionSelectSellCoin(_ sender: Any) {
        self.selectedType = "sell"
//        self.getSellCoins()
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: "CoinSelectController") as! CoinSelectController
        detailController.delegate = self
        detailController.coinList = self.coinList
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    @IBAction func actionSelectBuyCoin(_ sender: Any) {
//        if self.sellCoinId == "" {
//            self.showToast(message: "Please select selling coin")
//            return
//        }
        self.selectedType = "buy"
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: "CoinSelectController") as! CoinSelectController
        detailController.delegate = self
        detailController.coinList = self.coinList
        self.navigationController?.pushViewController(detailController, animated: true)
//        self.getBuyCoins()
    }
    
    @IBAction func actionSubmit(_ sender: Any) {
        
        if self.sellAmount == 0 {
            self.txtSellAmount.shake(6, withDelta: 10, speed: 0.06)
            return
        }
        
        if self.sellAmount > Double(self.sendCoin.balance)! {
            self.showToast(message: "Insufficient balance")
            return
        }
        
        let alert = Alert.showConfirmAlert(message: "Are you sure swap \(self.sellAmount) \(self.sendCoin.symbol!) ?", handler: {
            (_) in self.submitExchange()
        })
        self.presentVC(alert)
    }
    

    
    @IBAction func actionViewHistory(_ sender: Any) {
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: "SwapHistoryController") as! SwapHistoryController
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
}

//extension SwapController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return historyList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: SwapItem = tableView.dequeueReusableCell(withIdentifier: "SwapItem", for: indexPath) as! SwapItem
//        let item = historyList[indexPath.row]
//        cell.lbSend.text = "\(item.amount!) \(item.sendSymbol!)"
//        cell.lbGet.text = item.getSymbol
//        cell.lbDate.text = item.date
//        cell.lbStatus.text = item.status
//
//        return cell
//    }
//}

extension SwapController: CoinSelectControllerDelegate {
    func selectCoin(param: CoinModel) {
        if self.selectedType == "buy" {
            self.receiveCoin = param
            self.receiveIcon.load(url: URL(string: param.icon)!)
//            self.lbBuyCoinBalance.text = param.balance
            self.btnReceiveCoin.setTitle(param.symbol, for: UIControl.State.normal)

        } else {
            self.sendCoin = param
            self.lbSendCoinBalance.text = param.balance
            self.sendingIcon.load(url: URL(string: param.icon)!)
            self.btnSendCoin.setTitle(param.symbol, for: UIControl.State.normal)
            
        }
        
        self.getRate()
    }
}
