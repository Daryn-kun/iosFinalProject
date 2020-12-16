//
//  User.swift
//  FinalProject
//
//  Created by nagato on 12/14/20.
//  Copyright © 2020 nagato. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object{
    @objc dynamic var id = 0
    @objc dynamic var fullName: String?
    @objc dynamic var userEmail: String?
    @objc dynamic var userPassword: String?
    @objc dynamic var userImg: NSData?
    @objc dynamic var userContact: String?
    @objc dynamic var userPreference: String?
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
