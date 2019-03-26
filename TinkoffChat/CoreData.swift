//
//  CoreData.swift
//  TinkoffChat
//
//  Created by Антон Шуплецов on 24/03/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    // NSPersistantStore:
    var storeUrl : URL{
        let documentUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentUrl.appendingPathComponent("MyStoree.sqlite")
    }
    //NSManagedObjectModel:
    
//    let dataModelName = "TinkoffChat"
//    let dataModelExtension = "momd"
//    lazy var managedObjectModel: NSManagedObjectModel = {
//        let modelURl = Bundle.main.url(forResource: self.dataModelName, withExtension: self.dataModelExtension)!
//        return NSManagedObjectModel(contentsOf: modelURl)!
//    }()
    
    private let managedObjectModelName = "TinkoffChat"
    private let dataModelExtension = "momd"
    private var _managedObjectModel : NSManagedObjectModel?
    private var managedObjectModel : NSManagedObjectModel? {
        get{
            if _managedObjectModel == nil {
                guard let modelURl = Bundle.main.url(forResource: self.managedObjectModelName, withExtension: self.dataModelExtension)
                    else{
                        print("Empty model url!")
                        return nil
                }
                _managedObjectModel = NSManagedObjectModel(contentsOf: modelURl)
            }
            return _managedObjectModel
        }
    }
    
    
    //NSPersistantStoreCoordinator:
    
//    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
//        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
//        do{
//            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: self.storeUrl, options: nil)
//        } catch{
//            assert(false, "Error adding store:\(error)")
//        }
//        return coordinator
//    }()
    
    private var _persistentStoreCoordinator : NSPersistentStoreCoordinator?
    private var persistentStoreCoordinator : NSPersistentStoreCoordinator?{
        get{
            if _persistentStoreCoordinator == nil {
                guard let model = self.managedObjectModel else{
                    print("Empty managed object model!")
                    return nil
                }
                
                _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
                do{
                    try _persistentStoreCoordinator?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: self.storeUrl, options: nil)
                } catch{
                    assert(false, "Error adding persistent store to coordinator:\(error)")
                }
            }
            return _persistentStoreCoordinator
        }
    }
    //MasterContext(1):
    
    
//        lazy var masterContext : NSManagedObjectContext = {
//            var masterContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
//            masterContext.persistentStoreCoordinator = self.persistentStoreCoordinator
//            masterContext.mergePolicy = NSOverwriteMergePolicy
//            return masterContext
//        }()
    
    private var _masterContext : NSManagedObjectContext?
    private var masterContext : NSManagedObjectContext?{
        get{
            if _masterContext == nil {
                let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
                guard self.persistentStoreCoordinator != nil else{
                    print("Empty persistent store coordinator!")
                    
                    return nil
                }
                context.persistentStoreCoordinator = self.persistentStoreCoordinator
                context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                context.undoManager = nil
                _masterContext = context
            }
            return _masterContext
        }
    }
    
    //MasterContext(2):
    
//    lazy var mainContext : NSManagedObjectContext = {
//        var mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//        mainContext.parent = self.masterContext
//        mainContext.mergePolicy = NSOverwriteMergePolicy
//        return mainContext
//    }()
    
    var _mainContext : NSManagedObjectContext?
     var mainContext : NSManagedObjectContext?{
        get{
            if _mainContext == nil {
                let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
                guard let parentContext = self.masterContext else{
                    print("No master context!")
                    
                    return nil
                }
                context.parent = parentContext
                context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                context.undoManager = nil
                _mainContext = context
            }
            return _mainContext
        }
    }
    
    //MasterContext(3):
    
//        lazy var saveContext : NSManagedObjectContext = {
//            var saveContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
//
//            saveContext.parent = self.mainContext
//            saveContext.mergePolicy = NSOverwriteMergePolicy
//            return saveContext
//        }()
    
     var _saveContext : NSManagedObjectContext?
     var saveContext : NSManagedObjectContext?{
        get{
            if _saveContext == nil {
                let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
                guard let parentContext = self.mainContext else{
                    print("No master context!")
                    
                    return nil
                }
                context.parent = parentContext
                context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                context.undoManager = nil
                _saveContext = context
            }
            return _saveContext
        }
    }
    
    
    
    
//   // typealias SaveCompletion = () -> Void
//
//    func performSave(with context: NSManagedObjectContext, comletionHandler: (() -> Void)? ) {
//        guard context.hasChanges else {
//            comletion?()
//            return
//        }
//        context.perform {
//            do{
//                try context.save()
//            } catch{
//                print("Context save error: \(error)")
//            }
//
//            if let parentContext = context.parent{
//                self.performSave(with: parentContext, comletion: comletion)
//            } else{
//                comletion?()
//            }
//        }
//
//    }
    
        func performSave(context: NSManagedObjectContext, comletionHandler: ((Error) -> Void)? ) {
            if context.hasChanges {
                context.perform {
                    [weak self] in
                    do{
                        try context.save()
                    } catch{
                        print("Context save error: \(error)")
                    }
    
                if let parent = context.parent{
                    self?.performSave(context : parent, comletionHandler: comletionHandler)
                } else
                {
                    //comletionHandler?()
                }
            }
    } else{
    //comletionHandler?()
            }
    }
    
}






extension AppUser {
    
    static func fetchRequestAppUser(model: NSManagedObjectModel) -> NSFetchRequest<AppUser>? {
        let templateName = "AppUser"
        guard let fetchRequest = model.fetchRequestTemplate(forName: templateName) as? NSFetchRequest<AppUser> else {
            assert(false, "No template with name \(templateName)!")
            return nil
        }
        return fetchRequest
    }
    
    
    
    
    
 

//    static func insertAppUser(in context: NSManagedObjectContext) -> AppUser? {
//        if let appUser = NSEntityDescription.insertNewObject(forEntityName: "AppUser", into: context) as? AppUser{
//            if appUser.currentUser == nil{
//                let currentUser = User.findOrInserUser( User.generateUserIdString(), in: context)
//                currentUser?.name = User.generateUserNameString()
//                appUser.currentUser = currentUser
//            }
//         return appUser
//        }
//        return nil
//    }
}

extension AppUser{
    
    static func generateUserNameString() -> String{
        let name = "Linkoln"
        return name
    }
    
    static func generateUserIdString() -> Int{
        let number = 1
        return number
    }
    
    static func findOrInsertAppUser(in context: NSManagedObjectContext) -> AppUser? {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("Model is not available in context!")
            assert(false)
            return nil
        }
        var appUser : AppUser?
        
        guard let fetchRequest = AppUser.fetchRequestAppUser(model: model) else { return nil }
        
        do {
            let results = try context.fetch(fetchRequest)
            assert(results.count < 2, "Multiple AppUsers found!" )
            if let foundUser = results.first {
                appUser = foundUser
            }
        } catch{
            print("Failed to Fetch AppUser: \(error)")
            
        }
//                if appUser == nil {
//                    appUser = AppUser.insertAppUser(in: context)
//                }
        return appUser
    }
    
}


//extension AppUser{
//    static func insertAppUser(in context: NSManagedObjectContext) -> AppUser? {
//        guard let appUser = NSEntityDescription.insertNewObject(forEntityName: "AppUser", into: context) as? AppUser else {return nil}
//
//        let currentUser = User.insertUser(in: context)
//        currentUser?.name = generateUserNameString()
//        appUser.currentUser = currentUser
//
////        appUser.name = "kekekekeke11"
////        appUser.timestamp = nil
//
//        return appUser
//    }
//}


