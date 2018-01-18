//
//  FavoriteProduct.swift
//  CoreDataManager
//
//  Created by Neil Francis Hipona on 1/17/18.
//  Copyright © 2018 Neil Francis Hipona. All rights reserved.
//

import Foundation
import CoreData

extension FavoriteProduct {
    
    /*
     * on.success (true, [FavoriteProduct]) | on.fail (false, [])
     */
    class func items(withPredicate predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, fetchLimit: Int = 0) -> (success: Bool, items: [FavoriteProduct]) {
        
        let request: NSFetchRequest<FavoriteProduct> = fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchLimit = fetchLimit
        
        guard let result = CoreDataManager.shared.executeFetchRequest(request as! NSFetchRequest<NSFetchRequestResult>) as? [FavoriteProduct] else { return (false, []) }
        return (true, result)
    }
    
    class func isExist(id: String) -> FavoriteProduct? {
        
        let predicate = NSPredicate(format: "id == %@", id)
        let result = items(withPredicate: predicate)
        
        return result.items.first
    }
    
    class func favoriteProduct(withProduct product: Product, userID: String) -> FavoriteProduct {
        
        let id = product.id!
        let favProduct = isExist(id: id) ?? NSEntityDescription.insertNewObject(forEntityName: "", into: CoreDataManager.shared.context) as! FavoriteProduct
        
        favProduct.productID = id
        favProduct.product = product
        //favProduct.storeID =
        
        return favProduct
    }
}
