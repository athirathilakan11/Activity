//
//  StoredDevListVC.swift
//  Ust_TestDemo
//
//  Created by Athira Thilakan on 16/10/24.
//

import UIKit

class StoredDevListVC: UIViewController {
    var discoverListFromDb : [DeviceInfomation] = []

    @IBOutlet weak var tb_DevList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        self.getDeviceFromDb()
    }
    func registerCell()
    {
        let nib : UINib = UINib(nibName: "discoveryCell", bundle: Bundle(for: DiscoveryVc.classForCoder()))
        self.tb_DevList.register(nib, forCellReuseIdentifier: "discoveryCell")
    }
    func getDeviceFromDb()
    {
        discoverListFromDb = CoredataManager().fetchDevices()
        self.tb_DevList.reloadData()
    }
   

}
extension StoredDevListVC:UITableViewDelegate,UITableViewDataSource
{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
            return discoverListFromDb.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
            let cell : discoveryCell = tb_DevList.dequeueReusableCell(withIdentifier: "discoveryCell") as! discoveryCell
            let itemDev = discoverListFromDb[indexPath.row]
            cell.lblName.text = itemDev.devieName
            cell.lblStatus.text = itemDev.reachability
            cell.lblIpAddress.text = itemDev.ipAddress
              return cell;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let discoveryVC = storyboard.instantiateViewController(withIdentifier: "DetailIPVc")
        self.navigationController?.pushViewController(discoveryVC, animated: true)
    }
}
