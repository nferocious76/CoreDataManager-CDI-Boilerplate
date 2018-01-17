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
    class func addressBook(withPredicate predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, fetchLimit: Int = 0) -> (success: Bool, result: [CategoryAttribute]) {
        
        let request: NSFetchRequest<CategoryAttribute> = fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchLimit = fetchLimit
        
        guard let result = CoreDataManager.shared.executeFetchRequest(request as! NSFetchRequest<NSFetchRequestResult>) as? [CategoryAttribute] else { return (false, []) }
        return (true, result)
    }
}
