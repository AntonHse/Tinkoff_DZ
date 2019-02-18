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
    
    
    @IBAction func EditButton(_ sender: Any) {
    }
    
    @IBOutlet weak var EditOutletButton: UIButton!
    
    
    @IBOutlet weak var UserPhotoImageView: UIImageView!

    @IBAction func CameraButton(_ sender: Any) {
       MakeAlertActionSheet()
    print("Выбери изображение профиля")
    }
    @IBOutlet weak var CameraOutletButton: UIButton!
    
    // Аутлеты и view еще не успели прогрузится, поэтому ошибка:
//    init() {
//        super.init(nibName: nil, bundle: nil)
//        print("Frame from Init: \(EditOutletButton.frame)")
//    }
//
//    required public init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         imagePickerController.delegate = self
        print("Frame from ViewDidLoad: \(EditOutletButton.frame)")
    
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
        print("Frame from ViewDidAppear: \(EditOutletButton.frame)")
        if flag{print(#function)}
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if flag{print(#function)}
        MakeConstrains()
    }
    
    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
        
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


    
    
    private func MakeConstrains() -> Void{
        
        CameraOutletButton.contentVerticalAlignment = .fill
        CameraOutletButton.contentHorizontalAlignment = .fill
        CameraOutletButton.imageEdgeInsets = UIEdgeInsets(top: CameraOutletButton.frame.height/4, left: CameraOutletButton.frame.height/4, bottom: CameraOutletButton.frame.height/4, right: CameraOutletButton.frame.height/4)
        CameraOutletButton.layer.cornerRadius = CameraOutletButton.frame.height/2
        CameraOutletButton.layer.masksToBounds = true
        UserPhotoImageView.layer.cornerRadius = CameraOutletButton.frame.height/2
        UserPhotoImageView.layer.masksToBounds = true
    }

     private func ChangeEditButton() -> Void{
        EditOutletButton.layer.cornerRadius = 5    // радиус закругления закругление
        EditOutletButton.layer.borderWidth = 2   // толщина обводки
        EditOutletButton.layer.borderColor = UIColor.black.cgColor// цвет обводки
        EditOutletButton.clipsToBounds = true
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
            UserPhotoImageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


