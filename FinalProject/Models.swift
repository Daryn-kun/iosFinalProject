//
//  Models.swift
//  FinalProject
//
//  Created by nagato on 12/15/20.
//  Copyright © 2020 nagato. All rights reserved.
//

import Foundation
import ObjectMapper


class UserResponse : NSObject, NSCoding, Mappable{

    var items : [Item]?
    var kind : String?
    var totalItems : Int?


    class func newInstance(map: Map) -> Mappable?{
        return UserResponse()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        items <- map["items"]
        kind <- map["kind"]
        totalItems <- map["totalItems"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         items = aDecoder.decodeObject(forKey: "items") as? [Item]
         kind = aDecoder.decodeObject(forKey: "kind") as? String
         totalItems = aDecoder.decodeObject(forKey: "totalItems") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if items != nil{
            aCoder.encode(items, forKey: "items")
        }
        if kind != nil{
            aCoder.encode(kind, forKey: "kind")
        }
        if totalItems != nil{
            aCoder.encode(totalItems, forKey: "totalItems")
        }

    }

}

class Item : NSObject, NSCoding, Mappable{

    var accessInfo : AccessInfo?
    var etag : String?
    var id : String?
    var kind : String?
    var selfLink : String?
    var volumeInfo : VolumeInfo?


    class func newInstance(map: Map) -> Mappable?{
        return Item()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        accessInfo <- map["accessInfo"]
        etag <- map["etag"]
        id <- map["id"]
        kind <- map["kind"]
        selfLink <- map["selfLink"]
        volumeInfo <- map["volumeInfo"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         accessInfo = aDecoder.decodeObject(forKey: "accessInfo") as? AccessInfo
         etag = aDecoder.decodeObject(forKey: "etag") as? String
         id = aDecoder.decodeObject(forKey: "id") as? String
         kind = aDecoder.decodeObject(forKey: "kind") as? String
         
         selfLink = aDecoder.decodeObject(forKey: "selfLink") as? String
         volumeInfo = aDecoder.decodeObject(forKey: "volumeInfo") as? VolumeInfo

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if accessInfo != nil{
            aCoder.encode(accessInfo, forKey: "accessInfo")
        }
        if etag != nil{
            aCoder.encode(etag, forKey: "etag")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if kind != nil{
            aCoder.encode(kind, forKey: "kind")
        }
        
        if selfLink != nil{
            aCoder.encode(selfLink, forKey: "selfLink")
        }
        if volumeInfo != nil{
            aCoder.encode(volumeInfo, forKey: "volumeInfo")
        }

    }

}
class VolumeInfo : NSObject, NSCoding, Mappable{

    var allowAnonLogging : Bool?
    var authors : [String]?
    var averageRating : Int?
    var categories : [String]?
    var descriptionField : String?
    var canonicalVolumeLink : String?
    var contentVersion : String?
    var imageLinks : ImageLink?
    var infoLink : String?
    var language : String?
    var maturityRating : String?
    var pageCount : Int?
    var previewLink : String?
    var printType : String?
    var publishedDate : String?
    var publisher : String?
    var ratingsCount : Int?
    var title : String?


    class func newInstance(map: Map) -> Mappable?{
        return VolumeInfo()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        allowAnonLogging <- map["allowAnonLogging"]
        authors <- map["authors"]
        categories <- map["categories"]
        descriptionField <- map["description"]
        averageRating <- map["averageRating"]
        canonicalVolumeLink <- map["canonicalVolumeLink"]
        contentVersion <- map["contentVersion"]
        imageLinks <- map["imageLinks"]
        infoLink <- map["infoLink"]
        language <- map["language"]
        maturityRating <- map["maturityRating"]
        pageCount <- map["pageCount"]
        previewLink <- map["previewLink"]
        printType <- map["printType"]
        publishedDate <- map["publishedDate"]
        publisher <- map["publisher"]
        ratingsCount <- map["ratingsCount"]
        title <- map["title"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         allowAnonLogging = aDecoder.decodeObject(forKey: "allowAnonLogging") as? Bool
         authors = aDecoder.decodeObject(forKey: "authors") as? [String]
         categories = aDecoder.decodeObject(forKey: "categories") as? [String]
         averageRating = aDecoder.decodeObject(forKey: "averageRating") as? Int
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         canonicalVolumeLink = aDecoder.decodeObject(forKey: "canonicalVolumeLink") as? String
         contentVersion = aDecoder.decodeObject(forKey: "contentVersion") as? String
         imageLinks = aDecoder.decodeObject(forKey: "imageLinks") as? ImageLink
         infoLink = aDecoder.decodeObject(forKey: "infoLink") as? String
         language = aDecoder.decodeObject(forKey: "language") as? String
         maturityRating = aDecoder.decodeObject(forKey: "maturityRating") as? String
         pageCount = aDecoder.decodeObject(forKey: "pageCount") as? Int
         previewLink = aDecoder.decodeObject(forKey: "previewLink") as? String
         printType = aDecoder.decodeObject(forKey: "printType") as? String
         publishedDate = aDecoder.decodeObject(forKey: "publishedDate") as? String
         publisher = aDecoder.decodeObject(forKey: "publisher") as? String
         ratingsCount = aDecoder.decodeObject(forKey: "ratingsCount") as? Int
         title = aDecoder.decodeObject(forKey: "title") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if allowAnonLogging != nil{
            aCoder.encode(allowAnonLogging, forKey: "allowAnonLogging")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if authors != nil{
            aCoder.encode(authors, forKey: "authors")
        }
        if categories != nil{
            aCoder.encode(categories, forKey: "categories")
        }
        if averageRating != nil{
            aCoder.encode(averageRating, forKey: "averageRating")
        }
        if canonicalVolumeLink != nil{
            aCoder.encode(canonicalVolumeLink, forKey: "canonicalVolumeLink")
        }
        if contentVersion != nil{
            aCoder.encode(contentVersion, forKey: "contentVersion")
        }
        if imageLinks != nil{
            aCoder.encode(imageLinks, forKey: "imageLinks")
        }

        if infoLink != nil{
            aCoder.encode(infoLink, forKey: "infoLink")
        }
        if language != nil{
            aCoder.encode(language, forKey: "language")
        }
        if maturityRating != nil{
            aCoder.encode(maturityRating, forKey: "maturityRating")
        }
        if pageCount != nil{
            aCoder.encode(pageCount, forKey: "pageCount")
        }

        if previewLink != nil{
            aCoder.encode(previewLink, forKey: "previewLink")
        }
        if printType != nil{
            aCoder.encode(printType, forKey: "printType")
        }
        if publishedDate != nil{
            aCoder.encode(publishedDate, forKey: "publishedDate")
        }
        if publisher != nil{
            aCoder.encode(publisher, forKey: "publisher")
        }
        if ratingsCount != nil{
            aCoder.encode(ratingsCount, forKey: "ratingsCount")
        }

        if title != nil{
            aCoder.encode(title, forKey: "title")
        }

    }

}
class ImageLink : NSObject, NSCoding, Mappable{

    var smallThumbnail : String?
    var thumbnail : String?
    var medium : String?

    class func newInstance(map: Map) -> Mappable?{
        return ImageLink()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        smallThumbnail <- map["smallThumbnail"]
        thumbnail <- map["thumbnail"]
        medium <- map["medium"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         smallThumbnail = aDecoder.decodeObject(forKey: "smallThumbnail") as? String
         thumbnail = aDecoder.decodeObject(forKey: "thumbnail") as? String
         medium = aDecoder.decodeObject(forKey: "medium") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if smallThumbnail != nil{
            aCoder.encode(smallThumbnail, forKey: "smallThumbnail")
        }
        if thumbnail != nil{
            aCoder.encode(thumbnail, forKey: "thumbnail")
        }
        if medium != nil{
            aCoder.encode(medium, forKey: "medium")
        }

    }

}
class AccessInfo : NSObject, NSCoding, Mappable{

    var accessViewStatus : String?
    var country : String?
    var embeddable : Bool?

    var publicDomain : Bool?
    var quoteSharingAllowed : Bool?
    var textToSpeechPermission : String?
    var viewability : String?
    var webReaderLink : String?


    class func newInstance(map: Map) -> Mappable?{
        return AccessInfo()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        accessViewStatus <- map["accessViewStatus"]
        country <- map["country"]
        embeddable <- map["embeddable"]

        publicDomain <- map["publicDomain"]
        quoteSharingAllowed <- map["quoteSharingAllowed"]
        textToSpeechPermission <- map["textToSpeechPermission"]
        viewability <- map["viewability"]
        webReaderLink <- map["webReaderLink"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         accessViewStatus = aDecoder.decodeObject(forKey: "accessViewStatus") as? String
         country = aDecoder.decodeObject(forKey: "country") as? String
         embeddable = aDecoder.decodeObject(forKey: "embeddable") as? Bool
         
         publicDomain = aDecoder.decodeObject(forKey: "publicDomain") as? Bool
         quoteSharingAllowed = aDecoder.decodeObject(forKey: "quoteSharingAllowed") as? Bool
         textToSpeechPermission = aDecoder.decodeObject(forKey: "textToSpeechPermission") as? String
         viewability = aDecoder.decodeObject(forKey: "viewability") as? String
         webReaderLink = aDecoder.decodeObject(forKey: "webReaderLink") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if accessViewStatus != nil{
            aCoder.encode(accessViewStatus, forKey: "accessViewStatus")
        }
        if country != nil{
            aCoder.encode(country, forKey: "country")
        }
        if embeddable != nil{
            aCoder.encode(embeddable, forKey: "embeddable")
        }
        
        if publicDomain != nil{
            aCoder.encode(publicDomain, forKey: "publicDomain")
        }
        if quoteSharingAllowed != nil{
            aCoder.encode(quoteSharingAllowed, forKey: "quoteSharingAllowed")
        }
        if textToSpeechPermission != nil{
            aCoder.encode(textToSpeechPermission, forKey: "textToSpeechPermission")
        }
        if viewability != nil{
            aCoder.encode(viewability, forKey: "viewability")
        }
        if webReaderLink != nil{
            aCoder.encode(webReaderLink, forKey: "webReaderLink")
        }

    }

}
class UserResponse2 : NSObject, NSCoding, Mappable{

    var accessInfo : AccessInfo?
    var etag : String?
    var id : String?
    var kind : String?
    var selfLink : String?
    var volumeInfo : VolumeInfo?


    class func newInstance(map: Map) -> Mappable?{
        return UserResponse2()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        accessInfo <- map["accessInfo"]
        etag <- map["etag"]
        id <- map["id"]
        kind <- map["kind"]
        selfLink <- map["selfLink"]
        volumeInfo <- map["volumeInfo"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         accessInfo = aDecoder.decodeObject(forKey: "accessInfo") as? AccessInfo
         etag = aDecoder.decodeObject(forKey: "etag") as? String
         id = aDecoder.decodeObject(forKey: "id") as? String
         kind = aDecoder.decodeObject(forKey: "kind") as? String
         selfLink = aDecoder.decodeObject(forKey: "selfLink") as? String
         volumeInfo = aDecoder.decodeObject(forKey: "volumeInfo") as? VolumeInfo

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if accessInfo != nil{
            aCoder.encode(accessInfo, forKey: "accessInfo")
        }
        if etag != nil{
            aCoder.encode(etag, forKey: "etag")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if kind != nil{
            aCoder.encode(kind, forKey: "kind")
        }
        if selfLink != nil{
            aCoder.encode(selfLink, forKey: "selfLink")
        }
        if volumeInfo != nil{
            aCoder.encode(volumeInfo, forKey: "volumeInfo")
        }

    }

}
