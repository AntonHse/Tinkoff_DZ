//
//  ConversationsListViewController.swift
//  TinkoffChat
//
//  Created by Антон Шуплецов on 22/02/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController{
    
 

    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var profileBarButton: UIBarButtonItem!
    
    @IBAction func profileBarButtonItemAction(_ sender: Any) {
        performSegue(withIdentifier: "profile", sender: nil)
       
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
        makeChats()
        addInformatiom()
        makeMessageAndDateTextFromMessages()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.barTintColor = UserDefaults.colorForKey(key: "color")
        
        tableView.delegate = self
        tableView.dataSource = self
     
      
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        
        
        if segue.identifier == "segue" {
            let destinationVC = segue.destination as! ChatViewController
            
            destinationVC.navigationTitle = sender as! String
            
        }
        //        for objective-c file(delegate):
        if let dest = segue.destination as? ThemesViewController {
            dest.delegate = self
        }
        
        //        for ThemesViewController.swift file(closure):
//        if let dest = segue.destination as? ThemesViewController {
//
//            dest.colorToReturn = {(dataReturned) -> ()in
//                self.logThemeChanging(selectedTheme: dataReturned)
//            }
//        }

    }

    func logThemeChanging(selectedTheme: UIColor){
        print("Color:\(selectedTheme)")
        
        if UserDefaults.standard.bool(forKey: "color") == false{
            UserDefaults.setColor(color: selectedTheme, forKey: "color")
        }
        UINavigationBar.appearance().barTintColor = UserDefaults.colorForKey(key: "color")
        
        
    }

    }




extension ConversationsListViewController: ThemesViewControllerDelegate{
    func themesViewController(_ controller: ThemesViewController, didSelectTheme selectedTheme: UIColor) {
        logThemeChanging(selectedTheme: selectedTheme)
    }
}
//End


extension UserDefaults {
    
    class func colorForKey(key: String) -> UIColor? {
        var color: UIColor?
        if let colorData = UserDefaults.standard.value(forKey: key) {
           //print(ok)
            color = NSKeyedUnarchiver.unarchiveObject(with: colorData as! Data) as? UIColor
        }
        return color
        
   
    }
    
    class func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            colorData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData?
        }
        UserDefaults.standard.set(colorData, forKey: key)
        UserDefaults.standard.synchronize()


    
    }
    

    
}

extension ConversationsListViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section{
        case 0:
            return onlineIndexes().count
        case 1:
            return offlineIndexes().count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        switch section{
            case 0:
                return "Online"
            case 1:
                return "History"
        default:
            break
        }
        return "ERROR"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0{
              performSegue(withIdentifier: "segue", sender: users[onlineIndexes()[indexPath.row]].name)
        }
        else if indexPath.section == 1{
            performSegue(withIdentifier: "segue", sender: users[offlineIndexes()[indexPath.row]].name)
        }
      
        
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath) as! FirstCell
        
        
        if indexPath.section == 0 {
            
            
            
            let date = users[onlineIndexes()[indexPath.row]].date
            cell.nameLabel.text = users[onlineIndexes()[indexPath.row]].name
            cell.textOfMessageLabel.text = users[onlineIndexes()[indexPath.row]].message
            cell.timeLabel.text = formatDatetoString(date: date!)
            
            if users[onlineIndexes()[indexPath.row]].hasUnreadMessades == true
            {
                cell.textOfMessageLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
            }
            
            cell.backgroundColor = UIColor.yellow
            
        }
        else
        {
            let date = users[offlineIndexes()[indexPath.row]].date
        cell.nameLabel.text = users[offlineIndexes()[indexPath.row]].name
        cell.textOfMessageLabel.text = users[offlineIndexes()[indexPath.row]].message
        cell.timeLabel.text = formatDatetoString(date: date!)
            
            if users[offlineIndexes()[indexPath.row]].hasUnreadMessades == true
            {
                cell.textOfMessageLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
            }
        }
        
        return cell
    }
   
  

}

func onlineIndexes() -> [Int]{
    var online : [Int] = []
    for i in 0...users.count - 1{
        if users[i].online == true{
            online.append(i)
        }
    }
    return online
}


func offlineIndexes() -> [Int]{
    var offline : [Int] = []
    for i in 0...users.count - 1{
        if users[i].online == false{
            offline.append(i)
        }
    }
    return offline
}

func formatDatetoString(date: Date) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy"
    if returnCurrentDate() == dateFormatter.string(from: date){
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: date)
        return time
    }
    else{
        dateFormatter.dateFormat = "dd MMM"
        let time = dateFormatter.string(from: date)
        return time
    }
}
func returnCurrentDate() -> String{
    let today = Date()
    let calendar = Calendar.current
    let day = calendar.component(.day, from: today)
    let month = calendar.component(.month, from: today)
    let year = calendar.component(.year, from: today)
    var currentDate = "\(day).\(month).\(year)"
    if month < 10{
        currentDate = "\(day).0\(month).\(year)"
    }
    else if day < 10{
        currentDate = "0\(day).\(month).\(year)"
    }
    return currentDate
}
