//
//  AddressBook.swift
//  CoreDataManager
//
//  Created by Neil Francis Hipona on 1/17/18.
//  Copyright © 2018 Neil Francis Hipona. All rights reserved.
//

import Foundation
import CoreData

extension AddressBook {
    
    /*
     * on.success (true, [AddressBook]) | on.fail (false, [])
     */
    class func items(withPredicate predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, fetchLimit: Int = 0) -> (success: Bool, items: [AddressBook]) {
        
        let request: NSFetchRequest<AddressBook> = fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchLimit = fetchLimit
        
        guard let result = CoreDataManager.shared.executeFetchRequest(request as! NSFetchRequest<NSFetchRequestResult>) as? [AddressBook] else { return (false, []) }
        return (true, result)
    }
    
    class func isExist(id: String) -> AddressBook? {
        
        let predicate = NSPredicate(format: "id == %@", id)
        let result = items(withPredicate: predicate)
        
        return result.items.first
    }
    
    class func addressBook(withInfo info: [String: AnyObject]) -> AddressBook {

        let id = "\(info["id"]!)"
        let firstName = "\(info["firstName"]!)"
        let middleName = info["middleName"] as? String ?? ""
        let lastName = "\(info["lastName"]!)"

        let company = info["company"] as? String ?? ""
        let telephone = info["telephone"] as? String ?? ""

        let addressName = "\(info["addressName"]!)"
        let houseNumber = "\(info["houseNumber"]!)"
        let street = "\(info["street"]!)"
        let barangay = "\(info["barangay"]!)"
        let province = info["province"] as? String ?? ""
        let city = info["city"] as? String ?? ""
        let postcode = info["postcode"] as? String ?? ""
        
        let lat = info["lat"]?.doubleValue ?? 0.0
        let lng = info["lng"]?.doubleValue ?? 0.0
        let cAddress = completeAddress(fromInfo: info)
        
        let addressBook = isExist(id: id) ?? NSEntityDescription.insertNewObject(forEntityName: "AddressBook", into: CoreDataManager.shared.context) as! AddressBook
        
        addressBook.id = id
        addressBook.firstName = firstName
        addressBook.middleName = middleName
        addressBook.lastName = lastName

        addressBook.company = company
        addressBook.telephone = telephone

        addressBook.addressName = addressName
        addressBook.houseNumber = houseNumber
        addressBook.street = street
        addressBook.barangay = barangay
        addressBook.city = city
        addressBook.province = province
        addressBook.postcode = postcode
        
        addressBook.latitude = lat
        addressBook.longitude = lng
        addressBook.completeAddress = cAddress
        
        return addressBook
    }
    
    class func completeAddress(fromInfo info: [String: AnyObject]) -> String {
        
        var text = "\(info["firstName"]!) \(info["lastName"]!)"
        if let houseNumber = info["houseNumber"] as? String, houseNumber.isEmpty == false {
            text += "\n\(houseNumber)"
        }
        if let street = info["street"] as? String, street.isEmpty == false {
            text += "\n\(street)"
        }
        if let city = info["city"] as? String, city.isEmpty == false {
            text += "\n\(city)"
        }
        if let province = info["province"] as? String, province.isEmpty == false {
            text += ", \(province)"
        }
        if let postCode = info["postcode"] as? String, postCode.isEmpty == false {
            text += ", \(postCode)"
        }
        if let countryId = info["countryId"] as? String, countryId.isEmpty == false {
            text += "\n\(countryId)"
        }
        if let telephone = info["telephone"] as? String, telephone.isEmpty == false {
            text += "\nT:\(telephone)"
        }
        
        return text
    }
}
