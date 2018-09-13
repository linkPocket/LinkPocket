//
//  LPCoreDataManager.swift
//  LinkPocket
//
//  Created by user on 2018. 8. 7..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit
import CoreData
import Foundation

final class LPCoreDataManager {
    static let store = LPCoreDataManager()
    
    lazy var persistentContainer: CustomPersistantContainer = {
        let container = CustomPersistantContainer(name: "LinkPocket")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var saveIfCanSave: Bool {
        do {
            try managedObjectContext.save()
            print("[info] .... Save Successfully")
            return true
        } catch _ as NSError {
            print("[info] .... Save Function Failed")
        }
        return false
    }
    
    @discardableResult func executeCategoryQuery<T>(query: (NSFetchRequest<Category>) -> T) -> T {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Category", in: managedObjectContext)
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.entity = entityDescription
        return query(request)
    }
    
    @discardableResult func executeLinkQuery<T>(query: (NSFetchRequest<Link>) -> T) -> T {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Link", in: managedObjectContext)
        let request: NSFetchRequest<Link> = Link.fetchRequest()
        request.entity = entityDescription
        
        return query(request)
    }
    
    @discardableResult func insertIntoCategory(valueCategory: LPCategoryModel) -> Bool {
        guard (selectObjectFromCategoryWhere(nameIs: valueCategory.name!) == nil) else {
            print("[info] .... Data is Exist")
            return false
        }
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Category", in: managedObjectContext)
        let contact = Category(entity: entityDescription!, insertInto: managedObjectContext)
        contact.name = valueCategory.name
        contact.r = valueCategory.r!
        contact.g = valueCategory.g!
        contact.b = valueCategory.b!
        contact.alpha = valueCategory.alpha!
        
        return saveIfCanSave
    }
    
    @discardableResult func selectAllObjectFromCategory() -> NSArray {
        let categorys: NSMutableArray = NSMutableArray()
        return executeCategoryQuery { (request) -> NSArray in
            do {
                let objects = try managedObjectContext.fetch(request) // as! [NSManagedObject]
                if objects.count > 0 {
                    print("FindContact => Data founded!!")
                    for object in objects {
                        if let name = object.value(forKey: "name") as? String,
                            let r = object.value(forKey: "r") as? Double,
                            let g = object.value(forKey: "g") as? Double,
                            let b = object.value(forKey: "b") as? Double,
                            let alpha = object.value(forKey: "alpha") as? Double {
                            let category: LPCategoryModel = LPCategoryModel(name: name, r: r, g: g, b: b, alpha: alpha)
                            categorys.add(category)
                        }
                    }
                } else {
                    print("FindContact => Nothing founded!!")
                }
            } catch _ as NSError  {
                print("findContact => managedObjectContext find function failed!!")
            }
            
            return categorys
        }
    }
    
    @discardableResult func selectObjectFromCategoryWhere(nameIs: String) -> LPCategoryModel? {
        var category: LPCategoryModel? = nil
        return executeCategoryQuery(query: { (request) -> LPCategoryModel? in
            do {
                let objects = try managedObjectContext.fetch(request)
                let match = objects.filter {$0.name == nameIs}.first
                guard match != nil else {
                    print("FindContact => Nothing founded!!")
                    return nil
                }
                if let name = match?.value(forKey: "name") as? String,
                    let r = match?.value(forKey: "r") as? Double,
                    let g = match?.value(forKey: "g") as? Double,
                    let b = match?.value(forKey: "b") as? Double,
                    let alpha = match?.value(forKey: "alpha") as? Double {
                    category = LPCategoryModel(name: name, r: r, g: g, b: b, alpha: alpha)
                }
                
            } catch _ as NSError  {
                print("findContact => managedObjectContext find function failed!!")
            }
            return category
        })
    }
    
    @discardableResult func updateCategorySet(valueCategory: LPCategoryModel, whereNameIs: String) -> Bool {
        return executeCategoryQuery(query: { (request) -> Bool in
            do {
                let objects = try managedObjectContext.fetch(request)
                let match = objects.filter {$0.name == whereNameIs}.first
                guard match != nil else {
                    print("[info] .... can't find \(whereNameIs) category")
                    return false
                }
                
                match?.setValue(valueCategory.r, forKey: "r")
                match?.setValue(valueCategory.g, forKey: "g")
                match?.setValue(valueCategory.b, forKey: "b")
                match?.setValue(valueCategory.alpha, forKey: "alpha")
                
                if match?.name != valueCategory.name {
                    let isUpdateDataIsExist = objects.filter { $0.name == valueCategory.name }.first
                    
                    guard isUpdateDataIsExist == nil else {
                        print("[info] .... \(String(describing: valueCategory.name)) category is already exist")
                        return false
                    }
                    match?.setValue(valueCategory.name, forKey: "name")
                }
                
                try managedObjectContext.save()
                print("[info] .... Save Successfully")
            } catch _ as NSError  {
                print("findContact => managedObjectContext find function failed!!")
                return false
            }
            
            return true
        })
        
    }
    
    @discardableResult func deleteFromCategoryWhere(nameIs: String) -> Bool {
        return executeCategoryQuery(query: { (request) -> Bool in
            do {
                let objects = try managedObjectContext.fetch(request)
                let match = objects.filter {$0.name == nameIs}.first
                guard match != nil else {
                    print("[info] .... \(nameIs) category is not exist so delete failed")
                    return false
                }
                managedObjectContext.delete(match!)
                try managedObjectContext.save()
                print("[info] .... Delete Successfully")
                return true
            } catch _ as NSError  {
                print("findContact => managedObjectContext find function failed!!")
                return false
            }
        })
    }
    
    @discardableResult func selectCategoryFromCategoryWhere(nameIs: String) -> Category? {
        return executeCategoryQuery(query: { (request) -> Category? in
            do {
                let objects = try managedObjectContext.fetch(request) // as! [NSManagedObject]
                let match = objects.filter {$0.name == nameIs}.first
                
                guard match != nil else {
                    print("FindContact => Nothing founded!!")
                    return nil
                }
                
                return match
                
            } catch _ as NSError  {
                print("findContact => managedObjectContext find function failed!!")
                return nil
            }
        })
    }

    @discardableResult func insertIntoLink(valueLink: LPLinkModel) -> Bool {
        guard (selectObjectFromLinkWhere(urlIs: valueLink.url!) == nil) else {
            return false
        }
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Link", in: managedObjectContext)
        let contact = Link(entity: entityDescription!, insertInto: managedObjectContext)
        
        let optionalMatch = executeCategoryQuery(query: { (request) -> Category? in
            do {
                let objects = try managedObjectContext.fetch(request)
                let match = objects.filter {$0.name == valueLink.category?.name}.first
                guard match != nil else {
                    print("FindContact => Nothing founded!!")
                    return nil
                }
                contact.category = match
                return match
            } catch _ as NSError  {
                print("findContact => managedObjectContext find function failed!!")
                return nil
            }
        })
        
        contact.title = valueLink.title
        contact.date = valueLink.date
        contact.imageName = valueLink.imageName
        contact.url = valueLink.url
        
        if let match = optionalMatch {
            match.link.insert(contact)
        }
        
        return saveIfCanSave
    }
    
    @discardableResult func selectAllObjectFromLink() -> NSArray {
        let links: NSMutableArray = NSMutableArray()
        return executeLinkQuery { (request) -> NSArray in
            do {
                let objects = try managedObjectContext.fetch(request)
                if objects.count > 0 {
                    print("FindContact => Data founded!!")
                    
                    for object in objects {
                        var link: LPLinkModel = LPLinkModel()
                        if let title = object.value(forKey: "title") as? String,
                            let url = object.value(forKey: "url") as? String,
                            let imageName = object.value(forKey: "imageName") as? String,
                            let date = object.value(forKey: "date") as? NSDate,
                            let category = object.value(forKey: "category") as? Category? {
                            link.title = title
                            link.date = date
                            link.imageName = imageName
                            link.url = url
                            
                            if let _ = category {
                                let categoryModel = LPCategoryModel(name: category?.name, r: category?.r, g: category?.g, b: category?.b, alpha: category?.alpha)
                                link.category = categoryModel
                            }
                            links.add(link)
                        }
                    }
                } else {
                    print("FindContact => Nothing founded!!")
                }
            } catch _ as NSError  {
                print("findContact => managedObjectContext find function failed!!")
            }
            
            return links
        }
    }
    
    @discardableResult func selectObjectFromLinkWhere(urlIs: String) -> LPLinkModel? {
        var link: LPLinkModel? = nil
        return executeLinkQuery(query: { (request) -> LPLinkModel? in
            do {
                let objects = try managedObjectContext.fetch(request) // as! [NSManagedObject]
                let match = objects.filter {$0.url == urlIs}.first
                
                guard match != nil else {
                    print("FindContact => Nothing founded!!")
                    return nil
                }
                
                link = LPLinkModel()
                link?.title = match?.value(forKey: "title") as? String
                link?.url = match?.value(forKey: "url") as? String
                link?.imageName = match?.value(forKey: "imageName") as? String
                link?.date = match?.value(forKey: "date") as? NSDate
                link?.category = match?.value(forKey: "category") as? LPCategoryModel
                
            } catch _ as NSError  {
                print("findContact => managedObjectContext find function failed!!")
            }
            
            return link
        })
    }
    
    @discardableResult func updateLinkSet(valueLink: LPLinkModel, whereUrlIs: String) -> Bool {
        return executeLinkQuery(query: { (request) -> Bool in
            do {
                let objects = try managedObjectContext.fetch(request)
                let match = objects.filter {$0.url == whereUrlIs}.first
                guard match != nil else {
                    print("[info] .... can't find \(whereUrlIs) category")
                    return false
                }
                
                match?.setValue(valueLink.title, forKey: "title")
                match?.setValue(valueLink.date, forKey: "date")
                match?.setValue(valueLink.imageName, forKey: "imageName")
                
                let optionalName = match?.category?.name
                if let name = optionalName {
                    let categoryMatch = selectCategoryFromCategoryWhere(nameIs: name)
                    categoryMatch?.link.remove(match!)
                }
                
                let changeName = valueLink.category?.name
                if let name = changeName {
                    let categoryMatch = selectCategoryFromCategoryWhere(nameIs: name)
                    match?.category = categoryMatch
                    categoryMatch?.link.insert(match!)
                }
                
                if match?.url != valueLink.url {
                    let isUpdateDataIsExist = objects.filter { $0.url == valueLink.url }.first
                    
                    guard isUpdateDataIsExist == nil else {
                        print("[info] .... \(String(describing: valueLink.url)) category is already exist")
                        return false
                    }
                    
                    match?.setValue(valueLink.url, forKey: "url")
                }
                
                try managedObjectContext.save()
                print("[info] .... Save Successfully")
            } catch _ as NSError  {
                print("findContact => managedObjectContext find function failed!!")
                return false
            }
            return true
        })
        
    }
    
    @discardableResult func deleteFromLinkWhere(urlIs: String) -> Bool {
        return executeLinkQuery(query: { (request) -> Bool in
            do {
                let objects = try managedObjectContext.fetch(request)
                let match = objects.filter {$0.url == urlIs}.first
                guard match != nil else {
                    print("[info] .... \(urlIs) link is not exist so delete failed")
                    return false
                }
                managedObjectContext.delete(match!)
                try managedObjectContext.save()
                print("[info] .... Delete Successfully")
                return true
            } catch _ as NSError  {
                print("findContact => managedObjectContext find function failed!!")
                return false
            }
        })
    }
}

class CustomPersistantContainer : NSPersistentContainer {
    
    static let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.CoreDataTest2")!
    let storeDescription = NSPersistentStoreDescription(url: url)
    
    override class func defaultDirectoryURL() -> URL {
        return url
    }
}

