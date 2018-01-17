//
//  ProductAttribute.swift
//  CoreDataManager
//
//  Created by Neil Francis Hipona on 1/17/18.
//  Copyright © 2018 Neil Francis Hipona. All rights reserved.
//

import Foundation
import CoreData

extension ProductAttribute {
    
    /*
     * on.success (true, [ProductAttribute]) | on.fail (false, [])
     */
    class func items(withPredicate predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, fetchLimit: Int = 0) -> (success: Bool, items: [ProductAttribute]) {
        
        let request: NSFetchRequest<ProductAttribute> = fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchLimit = fetchLimit
        
        guard let result = CoreDataManager.shared.executeFetchRequest(request as! NSFetchRequest<NSFetchRequestResult>) as? [ProductAttribute] else { return (false, []) }
        return (true, result)
    }
    
    class func isExist(id: String) -> ProductAttribute? {
        
        let predicate = NSPredicate(format: "id == %@", id)
        let result = items(withPredicate: predicate)
        
        return result.items.first
    }

    class func attribute(withInfo info: [String: AnyObject]) -> ProductAttribute {
        
        let id = "\(info["valueId"]!)"
        let value = "\(info["value"]!)"
        let attributeCode = "\(info["attributeCode"]!)"

        let attribute = isExist(id: id) ?? NSEntityDescription.insertNewObject(forEntityName: "ProductAttribute", into: CoreDataManager.shared.context) as! ProductAttribute

        attribute.id = id
        attribute.value = value
        attribute.attributeCode = attributeCode

        return attribute
    }
}
