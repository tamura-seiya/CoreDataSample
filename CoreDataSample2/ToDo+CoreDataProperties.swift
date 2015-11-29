//
//  ToDo+CoreDataProperties.swift
//  CoreDataSample2
//
//  Created by tamura seiya on 2015/11/19.
//  Copyright © 2015年 Seiya Tamura. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ToDo {

    @NSManaged var sameDate: NSDate?
    @NSManaged var title: String?
    @NSManaged var dictionary: NSData?

}
