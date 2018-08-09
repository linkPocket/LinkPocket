//
//  Category+CoreDataProperties.swift
//  LinkPocket
//
//  Created by user on 2018. 8. 7..
//  Copyright © 2018년 LP. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var r: Double
    @NSManaged public var g: Double
    @NSManaged public var b: Double
    @NSManaged public var alpha: Double
    @NSManaged public var link: Set<Link>

}
