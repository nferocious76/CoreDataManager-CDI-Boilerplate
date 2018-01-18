//
//  Review.swift
//  CoreDataManager
//
//  Created by Neil Francis Hipona on 1/17/18.
//  Copyright © 2018 Neil Francis Hipona. All rights reserved.
//

import Foundation
import CoreData

extension Review {
    
    /*
     * on.success (true, [Review]) | on.fail (false, [])
     */
    class func items(withPredicate predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, fetchLimit: Int = 0) -> (success: Bool, items: [Review]) {
        
        let request: NSFetchRequest<Review> = fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchLimit = fetchLimit
        
        guard let result = CoreDataManager.shared.executeFetchRequest(request as! NSFetchRequest<NSFetchRequestResult>) as? [Review] else { return (false, []) }
        return (true, result)
    }
    
    class func isExist(id: String) -> Review? {
        
        let predicate = NSPredicate(format: "id == %@", id)
        let result = items(withPredicate: predicate)
        
        return result.items.first
    }

    class func review(withInfo info: [String: AnyObject]) -> Review {
        
        let id = "\(info["reviewId"]!)"
        let customerID = "\(info["customerId"]!)"
        let createdAt = "\(info["createdAt"]!)"
        let detail = "\(info["detail"]!)"
        let username = "\(info["nickname"]!)"
        let title = "\(info["title"]!)"
        let detailId = "\(info["detailId"]!)"
        let productName = "\(info["productName"]!)"
        let productImageURL = "\(info["smallImage"]!)"
        let productID = "\(info["entityPkValue"]!)"
        
        let statusID = "\(info["statusId"]!)"
        let rating = info["rating"]?.floatValue ?? 0.0
        let storeID = "\(info["storeId"]!)"

        let review = isExist(id: id) ?? NSEntityDescription.insertNewObject(forEntityName: "Review", into: CoreDataManager.shared.context) as! Review
        
        review.id = id
        review.customerID = customerID
        review.createdAt = createdAt
        review.detail = detail
        review.userName = username
        review.title = title
        review.detailID = detailId
        review.productName = productName
        review.productImageURL = productImageURL
        review.productID = productID
        review.statusID = statusID
        review.rating = rating
        review.storeID = storeID
     
        if let product = Product.isExist(id: productID) {
            product.addToReview(review)
        }
        
        return review
    }
}
