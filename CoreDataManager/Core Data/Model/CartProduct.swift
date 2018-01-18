//
//  CartProduct.swift
//  CoreDataManager
//
//  Created by Neil Francis Hipona on 1/17/18.
//  Copyright © 2018 Neil Francis Hipona. All rights reserved.
//

import Foundation
import CoreData

extension CartProduct {
    
    /*
     * on.success (true, [CartProduct]) | on.fail (false, [])
     */
    class func items(withPredicate predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, fetchLimit: Int = 0) -> (success: Bool, items: [CartProduct]) {
        
        let request: NSFetchRequest<CartProduct> = fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchLimit = fetchLimit
        
        guard let result = CoreDataManager.shared.executeFetchRequest(request as! NSFetchRequest<NSFetchRequestResult>) as? [CartProduct] else { return (false, []) }
        return (true, result)
    }
    
    class func isExist(id: String) -> CartProduct? {
        
        let predicate = NSPredicate(format: "id == %@", id)
        let result = items(withPredicate: predicate)
        
        return result.items.first
    }
    
    class func cartProduct(withProduct product: Product, itemCount: Int) -> CartProduct {
        
        let id = product.id!
        let cartProduct = isExist(id: id) ?? NSEntityDescription.insertNewObject(forEntityName: "CartProduct", into: CoreDataManager.shared.context) as! CartProduct
        
        cartProduct.productID = id
        cartProduct.itemCount = Int32(itemCount)
        cartProduct.product = product
        
        return cartProduct
    }
}
