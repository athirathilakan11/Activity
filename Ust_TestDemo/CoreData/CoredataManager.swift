//
//  CoredataManager.swift
//  Ust_TestDemo
//
//  Created by Athira Thilakan on 15/10/24.
//

import UIKit
import CoreData
class CoredataManager: NSObject {

    let context: NSManagedObjectContext
    override init() {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            self.context = appDelegate.persistentContainer.viewContext
        }

        func addDevice(name: String, ipAddress: String, status: String) {
       
            let newDevice = DeviceInfomation(context: context)
            newDevice.devieName = name
            newDevice.ipAddress = ipAddress
            newDevice.reachability = status
            do {
                try context.save()
                print("Device saved successfully.")
            } catch {
                print("Failed to save device: \(error.localizedDescription)")
            }
        }
    
    func fetchDevices() -> [DeviceInfomation] {
        let fetchRequest: NSFetchRequest<DeviceInfomation> = DeviceInfomation.fetchRequest()
        
        do {
            let devices = try context.fetch(fetchRequest)
            return devices
        } catch {
            print("Failed to fetch devices: \(error.localizedDescription)")
            return []
        }
    }
    
    
    }
