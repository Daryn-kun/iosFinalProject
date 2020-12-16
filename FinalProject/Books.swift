//
//  Books.swift
//  FinalProject
//
//  Created by nagato on 12/15/20.
//  Copyright © 2020 nagato. All rights reserved.
//

import Foundation
import RealmSwift

class Books: Object{
    @objc dynamic var id = 0
    @objc dynamic var bookTitle: String?
    @objc dynamic var imgUrl: String?
    @objc dynamic var urlId: String?
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
