//
//  StorageManager.swift
//  TinkoffChat
//
//  Created by Антон Шуплецов on 26/03/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StorageManager: NSObject {
    
    // Init core data stack:
    private let coreDataStack = CoreDataStack()
    
    // Save function:
    func saveProfile(profile: CustomData, completion: @escaping (Error?) -> Void) {
        let appUser = AppUser.findOrInsertAppUser(in: coreDataStack.saveContext!)
        
        self.coreDataStack.saveContext!.perform {
            appUser?.name = profile.name
            appUser?.info = profile.info
            appUser?.image = (profile.photo.jpegData(compressionQuality: 1.0)! as NSObject)
            
            UserDefaults.standard.set(profile.name, forKey: "profileName")
            
            self.coreDataStack.performSave(context: self.coreDataStack.saveContext!) { (error) in
                DispatchQueue.main.async {
                    completion(error)
                }
            }
        }
    }
    
    // Load :
    func readProfile(completion: @escaping (CustomData) -> ()) {
        let appUser = AppUser.findOrInsertAppUser(in: coreDataStack.mainContext!)
        let profile: CustomData
        let name = appUser?.name ?? "User: \(UIDevice.current.name)"
        _ = appUser?.info ?? "decription"
        let image: UIImage
        
        if let imageData = appUser?.image {
            image = UIImage(data: imageData as! Data) ?? UIImage(named: "placeholder-user")!
        } else {
            image = UIImage(named: "placeholder-user")!
        }
        
        profile = CustomData(name: name, photo: image, info: description)
        DispatchQueue.main.async {
            completion(profile)
        }
}
}
