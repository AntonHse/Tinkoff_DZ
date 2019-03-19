//
//  CommunicatorManager.swift
//  TinkoffChat
//
//  Created by Антон Шуплецов on 18/03/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//

import Foundation

class CommunicationManager: CommunicatorDelegate {
    func failedToStartAdvertising(error: Error) {
        
    }
    
    
    let communicationManager = CommunicationManager()
    var multiPeerCommunicator: MultiPeerCommunicator!
    
    
    private init() {
        self.multiPeerCommunicator = MultiPeerCommunicator()
        self.multiPeerCommunicator.delegate = self
    }
    
  
    
    func didFoundUser(userID: String, userName: String?) {
      
    }
    
    func didLostUser(userID: String) {
  
    }
    
    func failedToStartBrowsingForUsers(error: Error) {
        print(error.localizedDescription)
    }
    
    func failedToStartAdvertisingForUsers(error: Error) {
        print(error.localizedDescription)
    }
    
    func didReceiveMessage(text: String, fromUser: String, toUser: String) {
        
        
    }
    
    
}

