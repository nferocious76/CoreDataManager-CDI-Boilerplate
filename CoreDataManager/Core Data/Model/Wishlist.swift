//
//  Wishlist.swift
//  CoreDataManager
//
//  Created by Neil Francis Hipona on 1/17/18.
//  Copyright © 2018 Neil Francis Hipona. All rights reserved.
//

import Foundation
import CoreData

extension Wishlist {
    
    /*
     * on.success (true, [Wishlist]) | on.fail (false, [])
     */
    class func addressBook(withPredicate predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, fetchLimit: Int = 0) -> (success: Bool, result: [Wishlist]) {
        
        let request: NSFetchRequest<Wishlist> = fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchLimit = fetchLimit
        
        guard let result = CoreDataManager.shared.executeFetchRequest(request as! NSFetchRequest<NSFetchRequestResult>) as? [Wishlist] else { return (false, []) }
        return (true, result)
    }
}
