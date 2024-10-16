//
//  DetailIPVc.swift
//  Ust_TestDemo
//
//  Created by Athira Thilakan on 15/10/24.
//

import UIKit

class DetailIPVc: UIViewController {

    @IBOutlet weak var pleaseWaitIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lblInfo: UILabel!
    var detailModel:DetailIPVcModel = DetailIPVcModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = false;
        self.fetchIp()
        
    }
  
    func fetchIp()
    {
        let ipDetails = self.detailModel.fetchIP { ipAddress in
            guard let iP = ipAddress else {
                        print("Failed to get public IP")
                        return
                    }
            
            self.detailModel.fetchGeoInfo(for: ipAddress!) { geoInfo in
                guard let geoInfoDetails = geoInfo else {
                            print("Failed to getGeoInfomation")
                            return
                        }
                DispatchQueue.main.async {
                    self.lblInfo.isHidden = false
                    self.pleaseWaitIndicator.isHidden = true
                    self.lblInfo.text = "geological info \n\n ip: \(geoInfo?.ip ?? "Not getting") \n\n  city:\(geoInfo?.city ?? "Not getting") \n\n carrier :\(geoInfo?.carrier ?? "Not getting") \n\n and postal :\(geoInfo?.postal ?? "Not getting") \n\n  timezone :\(geoInfo?.timezone ?? "Not getting")"
                }
                
            }
            
        }
    }

    
    
}
