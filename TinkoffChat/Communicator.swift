//
//  Communicator.swift
//  TinkoffChat
//
//  Created by Антон Шуплецов on 18/03/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//

import Foundation




protocol Communicator{
    func sendMessage(string: String, to UserID: String, completionHandler: (( _ success : Bool, _ error : Error?) -> ())?)
    var delegate : CommunicatorDelegate? {get set}
    var online : Bool {get set}
}
