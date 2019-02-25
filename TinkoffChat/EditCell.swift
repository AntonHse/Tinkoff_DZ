//
//  EditCell.swift
//  TinkoffChat
//
//  Created by Антон Шуплецов on 24/02/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//

import Foundation
func formatDate(dateFromStr: String) -> Date{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yy HH:mm"
    guard let stringToDate = dateFormatter.date(from: dateFromStr) else {
        fatalError("ERROR: Date conversion failed due to mismatched format.")
    }
    return stringToDate
}

protocol ConversationCellConfiguration: class {
    var name : String? {get set}
    var message : String? {get set}
    var date : Date? {get set}
    var online : Bool {get set}
    var hasUnreadMessades : Bool {get set}
}
protocol MessageCellConfiguration: class {
    var text : String? {get set}
}



class Users: ConversationCellConfiguration{
    var name: String?
    var message: String?
    var date: Date?
    var online: Bool
    var hasUnreadMessades: Bool
    init(name: String, message: String?, date: String, online: Bool, hasUnreadMessades: Bool){
        self.name = name
        if message == nil{self.message = "No messages yet"}
        else  {self.message = message}
        self.date = formatDate(dateFromStr: date)
        self.online = online
        self.hasUnreadMessades = hasUnreadMessades
    }
}

class Messages: MessageCellConfiguration{
    var text: String?
    var myMessage : Bool
    var date: Date
    init(text: String?, myMessage: Bool, dateInMessages: String?){
        if text == nil{self.text = "No messages yet"}
        else{self.text = text}
        self.myMessage = myMessage
        if dateInMessages == nil {self.date = formatDate(dateFromStr: "01.01.01 01:01")}
        else{self.date = formatDate(dateFromStr: dateInMessages!)}
    }
}

var users = [Users]()

func makeMessageAndDateTextFromMessages(){
    for i in 0...users.count - 1{
        let lastMessage = allMessages[i].count - 1

        users[i].message?.append(allMessages[i][lastMessage].text!)
     
        users[i].date = allMessages[i][lastMessage].date
        
    }

}


let firstUser = Users(name: "Ivan Pupkin", message: "" , date: "01.01.19 23:09", online: true, hasUnreadMessades: true)
let secondUser = Users(name: "Anton Pepko", message: "", date: "01.01.19 23:09", online: false, hasUnreadMessades: true)
let thirdUser = Users(name: "Mark Tomkin", message: "", date: "01.01.19 23:09", online: true, hasUnreadMessades: true)
let forthUser = Users(name: "Pavel Perov", message: "", date: "01.01.19 23:09", online: false, hasUnreadMessades: false)
let fifthUser = Users(name: "Vasia Klever", message: "", date: "01.01.19 23:09", online: false, hasUnreadMessades: false)
let sixthUser = Users(name: "Maks Bonin", message: "", date: "01.01.19 23:09", online: true, hasUnreadMessades: false)
let seventhUser = Users(name: "Tolia Pashin", message: "", date: "01.01.19 23:09", online: true, hasUnreadMessades: false)
let eighthUser = Users(name: "Anna Furrow", message: "", date: "01.01.19 23:09", online: false, hasUnreadMessades: false)
let ninthUser = Users(name: "Jane Nyland", message: "", date: "01.01.19 23:09", online: true, hasUnreadMessades: true)
let tenthUser = Users(name: "Bob Janzen", message: "", date: "01.01.19 23:09", online: false, hasUnreadMessades: false)
let eleventhUser = Users(name: "Carole Ahlers", message: "", date: "01.01.19 23:09", online: false, hasUnreadMessades: true)
let twelfthUser = Users(name: "Dan Krysin", message: "", date: "01.01.19 23:09", online: false, hasUnreadMessades: false)
let trirteenthUser = Users(name: "Dan Stinger", message: "", date: "01.01.19 23:09", online: true, hasUnreadMessades: false)
let fourteenthUser = Users(name: "Erica Wolfram", message: "", date: "01.01.19 23:09", online: false, hasUnreadMessades: true)
let fifteenthUser = Users(name: "Bryce Banner", message: "", date: "01.01.19 23:09", online: false, hasUnreadMessades: false)
let sixteenthUser = Users(name: "Bryce Bradway", message: "", date: "01.01.19 23:09", online: false, hasUnreadMessades: false)
let seventeenthUser = Users(name: "Tom Ford", message: "", date: "01.01.19 23:09", online: true, hasUnreadMessades: false)
let eightteenthUser = Users(name: "Tony Stark", message: "", date: "01.01.19 23:09", online: false, hasUnreadMessades: true)
let ninteenthUser = Users(name: "Alibaba Muskat", message: "", date: "01.01.19 23:09", online: false, hasUnreadMessades: false)




var firstUserMessages = [Messages]()
var secondUserMessages = [Messages]()
var thirdUserMessages = [Messages]()
var forthUserMessages = [Messages]()
var fifthUserMessages = [Messages]()
var sixthUserMessages = [Messages]()
var seventhUserMessages = [Messages]()
var eighthUserMessages = [Messages]()
var ninthUserMessages = [Messages]()
var tenthUserMessages = [Messages]()
var eleventhUserMessages = [Messages]()
var twelfthUserMessages = [Messages]()
var trirteenthUserMessages = [Messages]()
var fourteenthUserMessages = [Messages]()
var fifteenthUserMessages = [Messages]()
var sixteenthUserMessages = [Messages]()
var seventeenthUserMessages = [Messages]()
var eightteenthUserMessages = [Messages]()
var ninteenthUserMessages = [Messages]()

var allMessages =  [firstUserMessages, secondUserMessages, thirdUserMessages, forthUserMessages, fifthUserMessages, sixthUserMessages, seventhUserMessages, eighthUserMessages, ninthUserMessages, tenthUserMessages, eleventhUserMessages, twelfthUserMessages, trirteenthUserMessages, fourteenthUserMessages, fifteenthUserMessages, sixteenthUserMessages, seventeenthUserMessages, eightteenthUserMessages, ninteenthUserMessages ]
//let firstUserMess = Messages(text:)

func makeChats(){
    for i in 0...9{
        let chat = Messages(text: "№\(i) of messagee", myMessage: false, dateInMessages: "1\(i).02.19 10:09")
    firstUserMessages.append(chat)
    }
    for i in 0...5{
        let chat = Messages(text: "№\(i) of message", myMessage: false, dateInMessages: "1\(i).01.19 11:09")
        secondUserMessages.append(chat)
    }

    for i in 0...7{
        let chat = Messages(text: "№\(i) of message", myMessage: false, dateInMessages: "1\(i).02.19 23:00")
        thirdUserMessages.append(chat)
    }
    for i in 0...9{
        let chat = Messages(text: "№\(i) of message", myMessage: false, dateInMessages: "1\(i).02.19 23:09")
        forthUserMessages.append(chat)
    }
    for i in 0...8{
        let chat = Messages(text: "№\(i) of message", myMessage: false, dateInMessages: "1\(i).01.19 23:09")
        fifthUserMessages.append(chat)
    }

    for i in 0...4{
        let chat = Messages(text: "№\(i) of message", myMessage: false, dateInMessages: "1\(i).02.19 23:09")
        sixthUserMessages.append(chat)
    }

    for i in 0...5{
        let chat = Messages(text: "№\(i) of message", myMessage: false, dateInMessages: "1\(i).01.19 23:09")
        seventhUserMessages.append(chat)
    }
    for i in 0...7{
        let chat = Messages(text: "№\(i) of message", myMessage: false, dateInMessages: "1\(i).02.19 23:09")
        eighthUserMessages.append(chat)
    }

    
        let chatNil = Messages(text: nil, myMessage: false, dateInMessages: nil)
        ninthUserMessages.append(chatNil)
    

   
        let chat = Messages(text: nil, myMessage: false, dateInMessages: nil)
        tenthUserMessages.append(chat)
    

    for i in 0...3{
        let chat = Messages(text: "№\(i) of message", myMessage: false, dateInMessages: "1\(i).01.19 23:09")
        eleventhUserMessages.append(chat)
    }

    for i in 0...2{
        let chat = Messages(text: "№\(i) of message", myMessage: false, dateInMessages: "1\(i).01.19 23:09")
        twelfthUserMessages.append(chat)
    }

    for i in 0...9{
        let chat = Messages(text: "№\(i) of message", myMessage: false, dateInMessages: "1\(i).02.19 23:09")
        trirteenthUserMessages.append(chat)
    }

    for i in 0...8{
        let chat = Messages(text: "№\(i) of message", myMessage: false, dateInMessages: "1\(i).01.19 23:09")
        fourteenthUserMessages.append(chat)
    }

    for i in 0...5{
        let chat = Messages(text: "№\(i) of message", myMessage: false, dateInMessages: "1\(i).02.19 23:09")
        fifteenthUserMessages.append(chat)
    }
    for i in 0...6{
        let chat = Messages(text: "№\(i) of message", myMessage: false, dateInMessages: "1\(i).01.19 23:09")
        sixteenthUserMessages.append(chat)
    }
    
    let today = Date()
    let calendar = Calendar.current
    let day = calendar.component(.day, from: today)
    let hour = calendar.component(.hour, from: today) - 1
    if hour >= 10{
        let chatToday = Messages(text: "Hello", myMessage: false, dateInMessages: "\(day).02.19 \(hour):09")
        seventeenthUserMessages.append(chatToday)
    }
        
    else{  let chatToday = Messages(text: "Hello", myMessage: false, dateInMessages: "\(day).02.19 0\(hour):09")
        seventeenthUserMessages.append(chatToday)}
    

    
    if hour >= 10{
        let chatTodayOffline = Messages(text: "Hello", myMessage: false, dateInMessages: "\(day).02.19 \(hour):09")
        eightteenthUserMessages.append(chatTodayOffline)
    }
        
    else{  let chatTodayOffline = Messages(text: "Hello", myMessage: false, dateInMessages: "\(day).02.19 0\(hour):09")
        eightteenthUserMessages.append(chatTodayOffline)}
    

    for i in 0...6{
        let chat = Messages(text: "№\(i) of message", myMessage: false, dateInMessages: "1\(i).01.19 23:09")
        ninteenthUserMessages.append(chat)
    }

    
    
}






func addInformatiom(){
        users.append(firstUser)
        users.append(secondUser)
        users.append(thirdUser)
        users.append(forthUser)
        users.append(fifthUser)
    users.append(sixthUser)
    users.append(seventhUser)
    users.append(eighthUser)
    users.append(ninthUser)
    users.append(tenthUser)
    users.append(eleventhUser)
    users.append(twelfthUser)
    users.append(trirteenthUser)
    users.append(fourteenthUser)
    users.append(fifteenthUser)
    users.append(sixteenthUser)
    users.append(seventeenthUser)
    users.append(eightteenthUser)
    users.append(ninteenthUser)
    
    
 
}





