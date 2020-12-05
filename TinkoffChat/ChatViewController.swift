//
//  ChatViewController.swift
//  TinkoffChat
//
//  Created by Антон Шуплецов on 25/02/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController{
    
    var navigationTitle = ""

    // MARK: - IBOutlet

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var textOfMessage: UITextField!
    
    @IBAction func sendButtonAction(_ sender: Any) {
        let i = findIndexOfName(name: navigationTitle)
       // print(currentTime())
       // print("01.01.01 01:01")
        allMessages[i].append( Messages(text: textOfMessage.text,
                                        myMessage: true,
                                        dateInMessages: currentTime()))
    }
    
    @IBAction func hostAndJoin(_ sender: Any) {}

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationItem.title = navigationTitle
        //makeChats()
    }
}

func findIndexOfName(name: String) -> Int{
    var index = -1
    for i in 0...users.count-1{
        if users[i].name == name{
            index = i
        }
    }
    return index
    
}

// MARK: - Collection View DataSource & Delegate

extension ChatViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let i = findIndexOfName(name: navigationTitle)
        return allMessages[i].count
    }
//    func collectionView(_ collectionView: UICollectionView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        //cell.backgroundColor = UIColor.black
        
        let i = findIndexOfName(name: navigationTitle)
        
        if !allMessages[i][indexPath.row].myMessage {
            let date = users[offlineIndexes()[indexPath.row]].date
            cell.userMessageLabel.text = allMessages[i][indexPath.row].text
            cell.myTime.text = formatDatetoString(date: date!)
            // print(users[offlineIndexes()[indexPath.row]].date)
        } else {
            cell.myMessageLabel.text = allMessages[i][indexPath.row].text
        }
        
        
        cell.userMessageLabel.layer.cornerRadius = 10
        cell.userMessageLabel.layer.masksToBounds = true
        cell.userMessageLabel.backgroundColor = UIColor.yellow
        
        cell.myMessageLabel.backgroundColor = UIColor.green
        cell.myMessageLabel.layer.cornerRadius = 10
        cell.myMessageLabel.layer.masksToBounds = true
        //cell.userMessageLabel.bounds.inset(by: UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13))
        //cell.userMessageLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.55).isActive = true
        //cell.userMessageLabel.textCo
        return cell
    }
}
