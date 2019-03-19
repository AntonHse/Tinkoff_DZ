//
//  CommunicationViewController.swift
//  TinkoffChat
//
//  Created by Антон Шуплецов on 19/03/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//

import UIKit
import MultipeerConnectivity


class CommunicationViewController: UIViewController, MCSessionDelegate, MCBrowserViewControllerDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        
        switch state {
        case MCSessionState.connected:
            print("Connecting: \(peerID.displayName)")
            
            
        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")
            
        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")
        }
        
        if mcSession.connectedPeers.count == 0{
            DispatchQueue.main.async {
                self.sendButton.isEnabled = false
            }
        }
        else{
                DispatchQueue.main.async {
                    self.sendButton.isEnabled = true
            }
        }
        
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            self.recMsg = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
            self.chatTextView.text = self.chatTextView.text + self.recMsg!
        }
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    var peerID : MCPeerID!
    var mcSession: MCSession!
    var mcAdvertiserAssistant: MCAdvertiserAssistant!
    
    
    @IBOutlet var chatTextView: UITextView!
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var connectionButton: UIBarButtonItem!
    
    
    
    @IBAction func sendButtonTaped(_ sender: Any) {
        
        if inputTextField.text != ""{
            sendMsg = "\n\(peerID.displayName): \(String(describing: inputTextField.text))\n"
            
            let message = sendMsg.data(using: String.Encoding.utf8, allowLossyConversion: false)
            
            do{
                try self.mcSession.send(message!, toPeers: self.mcSession.connectedPeers, with: .reliable)
            }
            catch{
                print("Error to send msg")
            }
            
            chatTextView.text = chatTextView.text + "\nMe:\(inputTextField.text!)\n"
            inputTextField.text = ""
            
        }
        else{
            let emptyAlert = UIAlertController(title: "You have not entered any text", message: nil, preferredStyle: .alert)
            
            emptyAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(emptyAlert,animated: true,completion: nil)
        }
        
        
    }
    
    @IBAction func connectionButtonTaped(_ sender: Any) {
        if mcSession.connectedPeers.count == 0 && !hosting{
            let connectionActionSheet = UIAlertController(title: "Our chat", message: "Do you want to host or join chat?", preferredStyle: .actionSheet)
            
            connectionActionSheet.addAction(UIAlertAction(title: "Host chat", style: .default, handler: { (action: UIAlertAction) in
                self.mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "Tinkoff-Chat", discoveryInfo: nil, session: self.mcSession)
                self.mcAdvertiserAssistant.start()
                self.hosting = true
            }))
            
            connectionActionSheet.addAction(UIAlertAction(title: "Join chat", style: .default, handler: { (action: UIAlertAction) in
                let mcBrowser = MCBrowserViewController(serviceType: "Tinkoff-chat", session: self.mcSession)
                mcBrowser.delegate = self
                self.present(mcBrowser,animated: true,completion: nil)
            }))
            
            connectionActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(connectionActionSheet,animated: true,completion: nil)
            
        }
        else if mcSession.connectedPeers.count == 0 && hosting{
            
            let waitActionSheet = UIAlertController(title: "Waiting...", message: "Whating for other to join the chat", preferredStyle: .actionSheet)
            
            waitActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(waitActionSheet,animated: true,completion: nil)
            
            
        }
        
        else{
            let dissconectActionSheet = UIAlertController(title: "Are you sure you want to disconnect", message: nil, preferredStyle: .actionSheet)
            
            dissconectActionSheet.addAction(UIAlertAction(title: "Dissconect", style: .destructive, handler: { (action: UIAlertAction) in
                self.mcSession.disconnect()
            }))
            
            dissconectActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(dissconectActionSheet,animated: true,completion: nil)
        }
    }
        
    
    
    var recMsg: String!
    var sendMsg: String!
    var hosting: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        peerID = MCPeerID(displayName: "TOHA")
        mcSession = MCSession(peer: peerID)
        mcSession.delegate = self
        
      sendButton.isEnabled = false
        chatTextView.isEditable = false
        hosting = false
        mcSession.disconnect()
       

        
        
    }
    

  

}
