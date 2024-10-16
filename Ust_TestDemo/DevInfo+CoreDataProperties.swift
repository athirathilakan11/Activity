//
//  DevInfo+CoreDataProperties.swift
//  Ust_TestDemo
//
//  Created by Athira Thilakan on 15/10/24.
//
//

import Foundation
import CoreData


extension DevInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DevInfo> {
        return NSFetchRequest<DevInfo>(entityName: "DevInfo")
    }

    @NSManaged public var name: String?

}

extension DevInfo : Identifiable {

}
