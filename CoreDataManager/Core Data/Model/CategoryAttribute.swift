//
//  CategoryAttribute.swift
//  CoreDataManager
//
//  Created by Neil Francis Hipona on 1/17/18.
//  Copyright © 2018 Neil Francis Hipona. All rights reserved.
//

import Foundation
import CoreData

extension CategoryAttribute {
    
    /*
     * on.success (true, [CategoryAttribute]) | on.fail (false, [])
     */
    class func items(withPredicate predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, fetchLimit: Int = 0) -> (success: Bool, items: [CategoryAttribute]) {
        
        let request: NSFetchRequest<CategoryAttribute> = fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchLimit = fetchLimit
        
        guard let result = CoreDataManager.shared.executeFetchRequest(request as! NSFetchRequest<NSFetchRequestResult>) as? [CategoryAttribute] else { return (false, []) }
        return (true, result)
    }
    
    class func isExist(id: String) -> CategoryAttribute? {
        
        let predicate = NSPredicate(format: "id == %@", id)
        let result = items(withPredicate: predicate)
        
        return result.items.first
    }

    class func attribute(withInfo info: [String: AnyObject]) -> CategoryAttribute {
        
        let id = "\(info["valueId"]!)"
        let value = "\(info["value"]!)"
        let attributeCode = "\(info["attributeCode"]!)"

        let attribute = isExist(id: id) ?? NSEntityDescription.insertNewObject(forEntityName: "CategoryAttribute", into: CoreDataManager.shared.context) as! CategoryAttribute
        
        attribute.id = id
        attribute.value = value
        attribute.attributeCode = attributeCode
        
        return attribute
    }
}
