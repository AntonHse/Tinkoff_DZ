//
//  GCDDataManager.swift
//  TinkoffChat
//
//  Created by Антон Шуплецов on 10/03/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//

import Foundation

class CustomData{

    

    static let customData = CustomData()
    var name : String = ""
    var photo : UIImage = #imageLiteral(resourceName: "placeholder-user.png")
    var info : String = ""
    init(){}
    
//    init(name: String,photo: UIImage, info: String){
//        self.name = name
//        self.photo = photo
//        self.info = info
//    }
    func getName() -> String {
        return name
    }
    func getPhoto() -> UIImage{
        return photo
    }
    func getInfo() -> String {
        return info
    }

    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.photo = aDecoder.decodeObject(forKey: "photo") as! UIImage
        self.info = aDecoder.decodeObject(forKey: "info") as! String
    }
    func initWithCoder(aDecoder: NSCoder) -> CustomData{
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.photo = aDecoder.decodeObject(forKey: "photo") as! UIImage
        self.info = aDecoder.decodeObject(forKey: "info") as! String
        return self
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.photo, forKey: "photo")
        aCoder.encode(self.info, forKey: "info")
    }
}





//class GCDDataManager : NSObject, NSCoding {
//
//    var photo: UIImage?
//    var name: String?
//    var info: String?
//
//    override init() {}
//
//    required init(coder aDecoder: NSCoder) {
//        if let photo = aDecoder.decodeObject(forKey: "GCDDataManager") as? UIImage {
//                    self.photo = photo
//        }
//        if let name = aDecoder.decodeObject(forKey: "GCDDataManager") as? String {
//            self.name = name
//        }
//        if let info = aDecoder.decodeObject(forKey: "GCDDataManager") as? String {
//            self.info = info
//        }
//
//    }
//
//    func encode(with aCoder: NSCoder) {
//        if let photo = self.photo{
//            aCoder.encode(photo, forKey: "GCDDataManager")
//        }
//        if let name = self.name{
//            aCoder.encode(name, forKey: "GCDDataManager")
//        }
//        if let info = self.info{
//            aCoder.encode(info, forKey: "GCDDataManager")
//        }
//    }
//
//}

