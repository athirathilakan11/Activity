//
//  DeviceInfomation+CoreDataProperties.swift
//  Ust_TestDemo
//
//  Created by Athira Thilakan on 15/10/24.
//
//

import Foundation
import CoreData


extension DeviceInfomation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeviceInfomation> {
        return NSFetchRequest<DeviceInfomation>(entityName: "DeviceInfomation")
    }

    @NSManaged public var devieName: String?
    @NSManaged public var ipAddress: String?
    @NSManaged public var reachability: String?

}

extension DeviceInfomation : Identifiable {

}
