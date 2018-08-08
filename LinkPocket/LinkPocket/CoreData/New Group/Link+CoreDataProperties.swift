//
//  Link+CoreDataProperties.swift
//  LinkPocket
//
//  Created by user on 2018. 8. 7..
//  Copyright © 2018년 LP. All rights reserved.
//
//

import Foundation
import CoreData


extension Link {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Link> {
        return NSFetchRequest<Link>(entityName: "Link")
    }

    @NSManaged public var url: String?
    @NSManaged public var title: String?
    @NSManaged public var imageName: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var category: Category?

}
