//
//  ViewController.swift
//  DZ_1
//
//  Created by Антон Шуплецов on 09/02/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var flagOff : Bool = true
    
    func turnOffLogicOfViewController(){
        flagOff = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        turnOffLogicOfViewController()
        if flagOff{print(#function)}
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if flagOff{print(#function)}
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if flagOff{print(#function)}
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if flagOff{print(#function)}
    }
    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
        if flagOff{print(#function)}
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if flagOff{print(#function)}
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if flagOff{print(#function)}
    }
//    - viewDidAppear
//    - viewWillLayoutSubviews
//    - viewDidLayoutSubviews


}

