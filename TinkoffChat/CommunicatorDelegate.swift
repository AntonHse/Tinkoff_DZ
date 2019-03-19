//
//  CommunicatorDelegate.swift
//  TinkoffChat
//
//  Created by Антон Шуплецов on 18/03/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//

import Foundation

protocol CommunicatorDelegate : class {
    //discovering
    func didFoundUser( userID : String, userName : String?)
    func didLostUser( userID : String)
    
    //errors
    func failedToStartBrowsingForUsers(error : Error)
    func failedToStartAdvertising(error : Error)
    
    //messages
    func didReceiveMessage(text : String, fromUser : String, toUser: String)
}
