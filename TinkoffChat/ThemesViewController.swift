//
//  ThemesViewController.swift
//  TinkoffChat
//
//  Created by Антон Шуплецов on 06/03/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {

    typealias v2CB = (_ infoToReturn: UIColor) -> Void

    @IBOutlet var theme1ButtonOutlet: UIButton!
    @IBOutlet var theme2ButtonOutlet: UIButton!
    @IBOutlet var theme3ButtonOutlet: UIButton!
    
    var model: Themes?
    var colorToReturn:v2CB?

    override func viewDidLoad() {
        super.viewDidLoad()
        model = Themes()

        makeButtonBeautifull(button: theme1ButtonOutlet)
        makeButtonBeautifull(button: theme2ButtonOutlet)
        makeButtonBeautifull(button: theme3ButtonOutlet)
    }

    // MARK: - IBAction
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: (true))
    }
    
    @IBAction func theme1ButtonAction(_ sender: Any) {
        self.view.backgroundColor = model?.theme1
        
        guard let cb = colorToReturn else {return}
        cb((model?.theme1)!)
    }
    
    @IBAction func theme2ButtonAction(_ sender: Any) {
        self.view.backgroundColor = model?.theme2
        
        guard let cb = colorToReturn else {return}
        cb((model?.theme2)!)
        
    }

    @IBAction func theme3ButtonAction(_ sender: Any) {
        self.view.backgroundColor = model?.theme3
        guard let cb = colorToReturn else {return}
        cb((model?.theme3)!)
        
    }

    private func makeButtonBeautifull(button: UIButton){
        button.layer.cornerRadius = 5    // радиус закругления закругление
        button.layer.borderWidth = 2   // толщина обводки
        button.layer.borderColor = UIColor.black.cgColor// цвет обводки
        button.clipsToBounds = true
    }
}
