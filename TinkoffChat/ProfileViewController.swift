//
//  ViewController.swift
//  DZ_1
//
//  Created by Антон Шуплецов on 09/02/2019.
//  Copyright © 2019 Антон Шуплецов. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var flag : Bool = false
    let imagePickerController = UIImagePickerController()
    
    
    @IBAction func editButton(_ sender: Any) {
    }
    
    @IBOutlet weak var editOutletButton: UIButton!
    
    
    @IBOutlet weak var userPhotoImageView: UIImageView!

    @IBAction func cameraButton(_ sender: Any) {
       MakeAlertActionSheet()
    print("Выбери изображение профиля")
    }
    @IBOutlet weak var cameraOutletButton: UIButton!
    
    // Аутлеты и view еще не успели прогрузится и соответсвенно передать значения frame, поэтому ошибка:
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)   {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        printInConsoleLogs(nameOfMethod: #function)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        printInConsoleLogs(nameOfMethod: #function)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         imagePickerController.delegate = self
        printInConsoleLogs(nameOfMethod: #function)
    
        ChangeEditButton()
        
        if flag{print(#function)}
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if flag{print(#function)}
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//Когда выводим значние frame во ViewDidLoad, мы увидим параметры положения и размеров кнопки, которые актуальны для Iphone SE(девайс который выбран в .storyboard).
//А Когда выводим значние frame во ViewDidAppear, то увидим параметры положения и размеров кнопки, после завершения примения constrains
//тк мы выбрали в симуляторе девайс Iphone X( у которого другие габариты экрана), то из-за наличия constrains он подвинет кнопку "редактировать"
        printInConsoleLogs(nameOfMethod: #function)
        
        if flag{print(#function)}
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if flag{print(#function)}
        
    }
    
    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
        MakeConstrains()
        if flag{print(#function)}
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if flag{print(#function)}
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if flag{print(#function)}
    }

    func  printInConsoleLogs(nameOfMethod: String) -> Void{
        print("Frame from \(nameOfMethod): \(editOutletButton.frame)")

    }

    
    
    private func MakeConstrains() -> Void{
        
        cameraOutletButton.contentVerticalAlignment = .fill
        cameraOutletButton.contentHorizontalAlignment = .fill
        cameraOutletButton.imageEdgeInsets = UIEdgeInsets(top: cameraOutletButton.frame.height/4, left: cameraOutletButton.frame.height/4, bottom: cameraOutletButton.frame.height/4, right: cameraOutletButton.frame.height/4)
        cameraOutletButton.layer.cornerRadius = cameraOutletButton.frame.height/2
        cameraOutletButton.layer.masksToBounds = true
        userPhotoImageView.layer.cornerRadius = cameraOutletButton.frame.height/2
        userPhotoImageView.layer.masksToBounds = true
    }

     private func ChangeEditButton() -> Void{
        editOutletButton.layer.cornerRadius = 5    // радиус закругления закругление
        editOutletButton.layer.borderWidth = 2   // толщина обводки
        editOutletButton.layer.borderColor = UIColor.black.cgColor// цвет обводки
        editOutletButton.clipsToBounds = true
    }
    
    private func MakeAlertActionSheet() -> Void{
        
        let info = UIAlertController(title: nil, message: "Выбери изображение профиля", preferredStyle: .actionSheet)

        let galleryAction = UIAlertAction(title: "Установить из галерии", style: .default, handler: {(action:UIAlertAction) in self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        })
        
        let cameraAction = UIAlertAction(title: "Сделать фото", style: .default, handler: {(action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePickerController.sourceType = .camera
                self.present(self.imagePickerController, animated: true, completion: nil)
            }
            else
            {
                print("Camera not avaliable in simulator")
            }
            
        })
        
        let cancelAction = UIAlertAction(title:"Выход", style: .cancel )
        info.addAction(galleryAction)
        info.addAction(cameraAction)
        info.addAction(cancelAction)
        self.present(info, animated: true, completion: nil)
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            userPhotoImageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}


