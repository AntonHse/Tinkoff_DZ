//
//  MultipeerCommunicator.swift
//  TinkoffChat
//
//  Created by Антон Шуплецов on 19/03/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//

import Foundation
import MultipeerConnectivity

func generateMessageId() -> String {
    let string = "\(arc4random_uniform(UINT32_MAX))+\(Date.timeIntervalSinceReferenceDate)+\(arc4random_uniform(UINT32_MAX))".data(using: .utf8)?.base64EncodedString()
    return string!
}

class MultiPeerCommunicator: NSObject, Communicator {

    var online: Bool = false

    var myPeerID: MCPeerID!
    var userName = UserDefaults.standard.string(forKey: "profileName") ?? "Without name"
    var mcNearbyServiceBrowser: MCNearbyServiceBrowser!
    var mcNearbyServiceAdvertiser: MCNearbyServiceAdvertiser!

    var activeSessions: [String: MCSession] = [:]

    weak var delegate: CommunicatorDelegate?

    override init() {

        myPeerID = MCPeerID(displayName: userName)

        mcNearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: ["userName": userName], serviceType: "tinkoff-chat")

        mcNearbyServiceBrowser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: "tinkoff-chat")
        super.init()

        mcNearbyServiceBrowser.delegate = self
        mcNearbyServiceAdvertiser.delegate = self

        mcNearbyServiceAdvertiser.startAdvertisingPeer()
        mcNearbyServiceBrowser.startBrowsingForPeers()


    }


    func manageSession(with peerID: MCPeerID) -> MCSession {
        
        let session = MCSession(peer: myPeerID, securityIdentity: nil, encryptionPreference: .none)
        session.delegate = self

        guard activeSessions[peerID.displayName] == nil else {
            return activeSessions[peerID.displayName]!
            
        }
       

        activeSessions[peerID.displayName] = session
        return activeSessions[peerID.displayName]!
    }


    func sendMessage(string: String, to UserID: String, completionHandler: ((Bool, Error?) -> ())?) {
        guard let session = activeSessions[UserID] else {return}

        let preparedMessageToSend = ["eventType" : "TextMessage", "messageId" : generateMessageId(), "text" : string]
        guard let data = try? JSONSerialization.data(withJSONObject: preparedMessageToSend, options: .prettyPrinted) else { return }

        do {
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
            delegate?.didReceiveMessage(text: string, fromUser: myPeerID.displayName, toUser: UserID)
            if let completion = completionHandler {
                completion(true, nil)
            }
        } catch
            let error {
            if let completion = completionHandler {
                completion(false, error)
            }
        }
    }



 
}
extension MultiPeerCommunicator:  MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate, MCSessionDelegate{
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
   




}
