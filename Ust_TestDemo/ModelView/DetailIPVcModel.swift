//
//  DetailIPVcModel.swift
//  Ust_TestDemo
//
//  Created by Athira Thilakan on 15/10/24.
//

import UIKit

class DetailIPVcModel: NSObject {
    
    
    func fetchIP(completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://api.ipify.org?format=json") else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let publicIPResponse = try JSONDecoder().decode(PublicIPDetail.self, from: data)
                completion(publicIPResponse.ip)
            } catch {
                print("Error decoding public IP: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }

    
    func fetchGeoInfo(for ipAddress: String, completion: @escaping (GeoInfo?) -> Void) {
        let urlString = "https://ipinfo.io/\(ipAddress)/geo"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let geoInfo = try JSONDecoder().decode(GeoInfo.self, from: data)
                completion(geoInfo)
            } catch {
                print("Error decoding geo info: \(error)")
                completion(nil)
            }
        }
        print(task)
        task.resume()
    }

}
