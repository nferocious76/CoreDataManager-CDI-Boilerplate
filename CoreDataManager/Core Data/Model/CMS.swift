//
//  CMS.swift
//  CoreDataManager
//
//  Created by Neil Francis Hipona on 1/17/18.
//  Copyright © 2018 Neil Francis Hipona. All rights reserved.
//

import Foundation
import CoreData

extension CMS {
    
    /*
     * on.success (true, [CMS]) | on.fail (false, [])
     */
    class func items(withPredicate predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, fetchLimit: Int = 0) -> (success: Bool, items: [CMS]) {
        
        let request: NSFetchRequest<CMS> = fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchLimit = fetchLimit
        
        guard let result = CoreDataManager.shared.executeFetchRequest(request as! NSFetchRequest<NSFetchRequestResult>) as? [CMS] else { return (false, []) }
        return (true, result)
    }
}
