//
//  DiscoveryVc.swift
//  Ust_TestDemo
//
//  Created by Athira Thilakan on 15/10/24.
//

import UIKit
import Network

class AirplayDev:NSObject
{
    var serviceItem: NetService?
    var ipAddress: String?
    var reachble :String = "NotReachable"
    init(serviceItem: NetService? = nil, ipAddress: String? = nil, reachble: String) {
        self.serviceItem = serviceItem
        self.ipAddress = ipAddress
        self.reachble = reachble
    }
}
class DiscoveryVc: UIViewController {
 
    var browser: NetServiceBrowser!
    var airplayDev: [AirplayDev] = []

    @IBOutlet weak var tb_Discover: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
        self.registerCell()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        airplayDev.removeAll()
        self.discoverDevItem()
    }
   
    func registerCell()
    {
        let nib : UINib = UINib(nibName: "discoveryCell", bundle: Bundle(for: DiscoveryVc.classForCoder()))
        self.tb_Discover.register(nib, forCellReuseIdentifier: "discoveryCell")
    }
    
    func discoverDevItem()
    {
         browser = NetServiceBrowser()
         browser.delegate = self
         browser.searchForServices(ofType: "_airplay._tcp", inDomain: "")
         tb_Discover.reloadData()
    }

    func stopDiscovery() {
        if browser != nil
        {
            browser.stop()
        }
       }
    
    func navigateToDetailVC()
    {
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let discoveryVC = storyboard.instantiateViewController(withIdentifier: "DetailIPVc")
        self.navigationController?.pushViewController(discoveryVC, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopDiscovery()
    }
}
extension DiscoveryVc :NetServiceBrowserDelegate,NetServiceDelegate {
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        print("Found service: \(service.name)")
        service.delegate = self
        service.resolve(withTimeout: 5.0)
        var ipAdress = "0:0:0"
        airplayDev.append(AirplayDev(serviceItem: service, ipAddress:"Searching IP..",reachble:"NotReachable"))
        if !moreComing {
            DispatchQueue.main.async {
                self.tb_Discover.reloadData()
            }
        }
    }
    
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didNotSearch errorDict: [String : NSNumber]) {
        print("Search failed: \(errorDict)")
    }
    
    func getIPAddress(from data: Data) -> String? {
        // Create a sockaddr_storage struct
        var storage = sockaddr_storage()
        let storageSize = MemoryLayout<sockaddr_storage>.size
        
        // Ensure data size matches the storage size to avoid overflow
        guard data.count <= storageSize else {
            print("Data size is too large for sockaddr_storage")
            return nil
        }
        
        // Copy data into storage
        data.withUnsafeBytes { buffer in
            guard let baseAddress = buffer.baseAddress else { return }
            memcpy(&storage, baseAddress, data.count)
        }
        
        // Check the address family (IPv4 or IPv6)
        switch Int32(storage.ss_family) {
        case AF_INET: // IPv4
            var addr = sockaddr_in()
            memcpy(&addr, &storage, MemoryLayout<sockaddr_in>.size)
            let ipString = String(cString: inet_ntoa(addr.sin_addr), encoding: .ascii)
            return ipString
            
        case AF_INET6: // IPv6
            var addr = sockaddr_in6()
            memcpy(&addr, &storage, MemoryLayout<sockaddr_in6>.size)
            var buffer = [CChar](repeating: 0, count: Int(INET6_ADDRSTRLEN))
            inet_ntop(AF_INET6, &addr.sin6_addr, &buffer, socklen_t(INET6_ADDRSTRLEN))
            return String(cString: buffer)
            
        default:
            return nil
        }
    }
    
    
    
    func netServiceDidResolveAddress(_ sender: NetService) {
        
        
        guard let addresses = sender.addresses else {
            print("No addresses found for service: \(sender.name)")
            return
        }
        if let host = sender.hostName {
            checkReachability(host: host,service: sender)
        }
        
        for addressData in addresses {
            if let ip = getIPAddress(from: addressData) {
                
                
                if let itemIndex = airplayDev.firstIndex { item in
                    item.serviceItem == sender
                }
                {
                    let currentItem = airplayDev[itemIndex]
                    currentItem.serviceItem =  sender
                    currentItem.ipAddress = ip
                }
                DispatchQueue.main.async {
                    self.tb_Discover.reloadData()
                }
                break
            }
            
        }
        
        
    }
    func checkReachability(host: String,service: NetService)
    {
        var reachablity = "Not reachable"
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                reachablity = "Reachable"
            }
            else {
                reachablity =  "Not reachable"
            }
            print("rechh \( reachablity)")
            if let itemIndex = self.airplayDev.firstIndex(where: { item in
                item.serviceItem == service
            })
            {
                let currentItem = self.airplayDev[itemIndex]
                currentItem.reachble = reachablity
                DispatchQueue.main.async {
                    CoredataManager().addDevice(name: currentItem.serviceItem?.name ?? "noName", ipAddress: currentItem.ipAddress ?? "0.0.0", status: currentItem.reachble)
                    self.tb_Discover.reloadData()
                }
            }
            
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
}

extension DiscoveryVc:UITableViewDelegate,UITableViewDataSource
{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return airplayDev.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : discoveryCell = tb_Discover.dequeueReusableCell(withIdentifier: "discoveryCell") as! discoveryCell
        let itemDev = airplayDev[indexPath.row]
        cell.lblName.text = itemDev.serviceItem?.name
        cell.lblStatus.text = itemDev.reachble
        cell.lblIpAddress.text = itemDev.ipAddress ??  "0:0:0"
        return cell;
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigateToDetailVC()
    }
    
}
