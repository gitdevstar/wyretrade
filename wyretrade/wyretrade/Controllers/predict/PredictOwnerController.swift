//
//  PredictOwnerController.swift
//  wyretrade
//
//  Created by maxus on 3/4/21.
//

import Foundation
import UIKit
import XLPagerTabStrip
import NVActivityIndicatorView

class PredictOwnerController: UIViewController, IndicatorInfoProvider, NVActivityIndicatorViewable {
    var itemInfo: IndicatorInfo = "Owner"
    
    @IBOutlet weak var predictTable: UITableView! {
        didSet {
            predictTable.delegate = self
            predictTable.dataSource = self
            predictTable.showsVerticalScrollIndicator = false
            predictTable.separatorColor = UIColor.darkGray
            predictTable.separatorStyle = .singleLineEtched
            predictTable.register(UINib(nibName: "PredictionItem", bundle: nil), forCellReuseIdentifier: "PredictionItem")
        }
    }
    
    @IBOutlet weak var lbEmpty: UILabel!
    
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    var predictList = [PredictionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    func submitCancel(param: NSDictionary) {
        self.startAnimating()
        RequestHandler.cancelPredict(parameter: param as NSDictionary, success: { (successResponse) in
                                self.stopAnimating()
                    let dictionary = successResponse as! [String: Any]
                    
            self.showToast(message: "Cancelled successfully")
                    
                    }) { (error) in
                        self.stopAnimating()
                        let alert = Alert.showBasicAlert(message: error.message)
                                self.presentVC(alert)
                    }    }
}

extension PredictOwnerController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableHeight.constant = CGFloat( Double(predictList.count) * 150.0)
        if predictList.count > 0 {
            lbEmpty.isHidden = true
        } else {
            lbEmpty.isHidden = false
        }
        return predictList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
//        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PredictionItem = tableView.dequeueReusableCell(withIdentifier: "PredictionItem", for: indexPath) as! PredictionItem
        cell.delegate = self
        let item = predictList[indexPath.row]
        cell.id = item.id
        cell.lbAsset.text = item.asset
        cell.lbPrice.text = item.price
        cell.lbStatus.text = item.status
        cell.lbPayout.text = item.payout
        cell.lbContent.text = item.content
        
        if item.status != "Created" {
            cell.cancelView.isHidden = true
        }
        cell.betView.isHidden = true
        cell.remainingTime = item.remainTime
        cell.precessTimer()

        return cell
    }
}

extension PredictOwnerController: PredictionItemParameterDelegate{
    func betParam(param: NSDictionary) {
        
    }
    
    func cancelParam(param: NSDictionary) {
        let alert = Alert.showConfirmAlert(message: "Are you sure you want to cancel this predict?", handler: {
            (_) in self.submitCancel(param: param)
        })
        self.presentVC(alert)
    }
    
    
}
