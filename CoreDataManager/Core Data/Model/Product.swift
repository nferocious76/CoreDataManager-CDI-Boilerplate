//
//  Product.swift
//  CoreDataManager
//
//  Created by Neil Francis Hipona on 1/17/18.
//  Copyright © 2018 Neil Francis Hipona. All rights reserved.
//

import Foundation
import CoreData

extension Product {
    
    /*
     * on.success (true, [Product]) | on.fail (false, [])
     */
    class func items(withPredicate predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, fetchLimit: Int = 0) -> (success: Bool, items: [Product]) {
        
        let request: NSFetchRequest<Product> = fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchLimit = fetchLimit
        
        guard let result = CoreDataManager.shared.executeFetchRequest(request as! NSFetchRequest<NSFetchRequestResult>) as? [Product] else { return (false, []) }
        return (true, result)
    }
    
    class func isExist(id: String) -> Product? {
        
        let predicate = NSPredicate(format: "id == %@", id)
        let result = items(withPredicate: predicate)

        return result.items.first
    }

    class func product(withInfo info: [String: AnyObject]) -> Product {
        
        let id = "\(info["entityId"]!)"
        let sku = "\(info["sku"]!)"
        let typeID = "\(info["typeId"]!)"
        let name = "\(info["name"]!)"
        let imageURL = "\(info["image"]!)"
        let totalReviews = info["totalReviews"]?.int32Value ?? 0
        let price = info["price"]?.floatValue ?? 0.0
        let rating = info["rating"]?.floatValue ?? 0.0
        let stockQty = info["stockQty"]?.int32Value ?? 0
        let maxSaleQty = info["maxSaleQty"]?.int32Value ?? 0
        let minSaleQty = info["minSaleQty"]?.int32Value ?? 0

        let product = isExist(id: id) ?? NSEntityDescription.insertNewObject(forEntityName: "Product", into: CoreDataManager.shared.context) as! Product

        product.id = id
        product.sku = sku
        product.typeID = typeID
        product.name = name
        product.imageURL = imageURL
        product.totalReviews = totalReviews
        product.price = price
        product.rating = rating
        product.qty = stockQty
        product.minSaleQty = minSaleQty
        product.maxSaleQty = maxSaleQty

        setProperties(info: info, forProduct: product)
        
        return product
    }
    
    class func setProperties(info: [String: AnyObject], forProduct product: Product) {
        
        if let attributes = info["attributes"] as? [[String: AnyObject]] {
            for attribute in attributes {
                let a = ProductAttribute.attribute(withInfo: attribute)
                product.addToProductAttribute(a)
            }
        }

        if let categories = info["categories"] as? [Int] {
            for id in categories {
                let id = "\(id)"
                if let category = Category.isExist(id: id) {
                    product.addToCategory(category)
                }else{
                    let info: [String: AnyObject] = ["entityId" : id as AnyObject,
                                                     "parentId": "0" as AnyObject]
                    let category = Category.category(withInfo: info)
                    product.addToCategory(category)
                }
            }
        }
    }
}
