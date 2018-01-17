//
//  Category.swift
//  CoreDataManager
//
//  Created by Neil Francis Hipona on 1/17/18.
//  Copyright © 2018 Neil Francis Hipona. All rights reserved.
//

import Foundation
import CoreData

extension Category {
    
    /*
     * on.success (true, [Category]) | on.fail (false, [])
     */
    class func items(withPredicate predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, fetchLimit: Int = 0) -> (success: Bool, items: [Category]) {
        
        let request: NSFetchRequest<Category> = fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchLimit = fetchLimit
        
        guard let result = CoreDataManager.shared.executeFetchRequest(request as! NSFetchRequest<NSFetchRequestResult>) as? [Category] else { return (false, []) }
        return (true, result)
    }
    
    class func isExist(id: String) -> Category? {
        
        let predicate = NSPredicate(format: "id == %@", id)
        let result = items(withPredicate: predicate)
        
        return result.items.first
    }

    class func category(withInfo info: [String: AnyObject]) -> Category {

        let id = "\(info["entityId"]!)"
        let parentId = "\(info["parentId"]!)"
        let level = info["level"]?.int32Value ?? 0
        let position = info["position"]?.int32Value ?? 0

        let category = isExist(id: id) ?? NSEntityDescription.insertNewObject(forEntityName: "Category", into: CoreDataManager.shared.context) as! Category
        
        category.id = id
        category.parentID = parentId
        category.level = level
        category.position = position

        setProperties(info: info, forCategory: category)
        
        return category
    }
    
    class func setProperties(info: [String: AnyObject], forCategory category: Category) {
        
        if let attributes = info["attributes"] as? [[String: AnyObject]] {
            for attribute in attributes {
                let a = CategoryAttribute.attribute(withInfo: attribute)
                a.categoryID = category.id
                category.addToCategoryAttribute(a)
            }
        }
    }
}
