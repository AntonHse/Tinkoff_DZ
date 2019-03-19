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
    
    
    func logicOfEditButton(){
        cameraOutletButton.isEnabled = true
        cameraOutletButton.setImage(UIImage(named: "slr-camera-2-xxl"), for: .normal)
        cameraOutletButton.backgroundColor = UIColor.init(red: 0.247059, green: 0.470588, blue: 0.941176, alpha: 1)
        
        doneButtonOutlet.setTitle("Done", for: .normal)
        doneButtonOutlet.isEnabled = true
        
        backButton.setTitle("", for: .normal)
        backButton.isEnabled = false
        
        
        
        nameOfUserLabel.sizeToFit()
        nameOfUserLabel.text = "Имя пользователя"
        nameOfUserLabel.textColor = UIColor.gray
        nameOfUserLabel.font = UIFont(name: "System - Thin", size: 14)
        
        
        nameOfUserTFOutlet.isEnabled = true
        nameOfUserTFOutlet.borderStyle = .roundedRect
        nameOfUserTFOutlet.layer.borderColor = UIColor.gray.cgColor// цвет обводки
        nameOfUserTFOutlet.text = ""
        nameOfUserTFOutlet.placeholder = "Имя пользователя"
        nameOfUserTFOutlet.font = UIFont(name: "System - System", size: 14)
        
    
        editOutletButton.layer.borderWidth = 0  // толщина обводки
        editOutletButton.setTitle("", for: .disabled)
        
        
        
        infoAboutUserLabel.text = "О себе"
        infoAboutUserLabel.font = UIFont(name: "System - Thin", size: 14)
        infoAboutUserLabel.textColor = UIColor.gray
        
        infoAboutUserTFOutlet.isEnabled = true
        infoAboutUserTFOutlet.text = ""
        infoAboutUserTFOutlet.placeholder = "О себе"

        
        
        
        operationButtonOutlet.isEnabled = true
        operationButtonOutlet.backgroundColor = UIColor.yellow
        operationButtonOutlet.setTitle("OPERATAION", for: .normal)
        
        GCDEditButtonOutlet.isEnabled = true
        GCDEditButtonOutlet.backgroundColor = UIColor.yellow
        GCDEditButtonOutlet.setTitle("GCD", for: .normal)
        
        
        editOutletButton.isEnabled = false
        
        
        
    }
    func classicMode(){
        
        
        cameraOutletButton.isEnabled = false

        cameraOutletButton.backgroundColor = nil
        cameraOutletButton.setImage(nil, for: .normal)
        
        editOutletButton.isEnabled = true
        
        loadInfoOfUser()
        
        ChangeEditButton()
        
        doneButtonOutlet.setTitle("", for: .normal)
        doneButtonOutlet.isEnabled = false
        
        backButton.setTitle("Back", for: .normal)
        backButton.isEnabled = true
        
        nameOfUserTFOutlet.borderStyle = .none
        nameOfUserTFOutlet.font = UIFont.boldSystemFont(ofSize: 29)
        nameOfUserTFOutlet.textColor = UIColor.black
        nameOfUserTFOutlet.isEnabled = false
        
        
        
        infoAboutUserTFOutlet.isEnabled = false

       
        
        GCDEditButtonOutlet.isEnabled = false
        GCDEditButtonOutlet.backgroundColor = nil
        GCDEditButtonOutlet.setTitle("", for: .disabled)
        
        operationButtonOutlet.isEnabled = false
        operationButtonOutlet.backgroundColor = nil
        operationButtonOutlet.setTitle("", for: .disabled)
        
        
        
    }
    
    func saveInfoGCD(){
        operationButtonOutlet.isEnabled = false
        GCDEditButtonOutlet.isEnabled = false
        operationButtonOutlet.backgroundColor = nil
        GCDEditButtonOutlet.backgroundColor = nil

         activityIndicatorView.startAnimating()
        
        let globalQueue =  DispatchQueue(label: "com.app.queueAnton", attributes: .concurrent)
        let group = DispatchGroup()
        
        var isSaved: Bool = true
        
       
        let name = self.nameOfUserTFOutlet.text!
        let photo = self.userPhotoImageView.image!
        let info = self.infoAboutUserTFOutlet.text!

        


        group.enter()
        globalQueue.async
            {
                let custom = CustomData()
                custom.name = name
                custom.photo = photo
                custom.info = info
            
            
            if let encodeName =  NSKeyedArchiver.archivedData(withRootObject: custom.name) as NSData?,
                let encodePhoto =  custom.photo.jpegData(compressionQuality: 1.0) as NSData?,
                let encodeInfo = NSKeyedArchiver.archivedData(withRootObject: custom.info) as NSData?
                {
                    let encodedArray: [NSData] = [encodeName, encodePhoto, encodeInfo]
                    let defaults = UserDefaults.standard
                    
                    defaults.set(encodedArray, forKey:"custom" )
                    defaults.synchronize()
                }
            else
                {
                    isSaved = false
                }

                group.leave()
            }
        
        
        group.notify(queue: globalQueue)
        {
            if isSaved
            {
            DispatchQueue.main.async
                {
                    self.activityIndicatorView.stopAnimating()
                    //AlertController:
                    let alert = UIAlertController(title: "Данные сохранены", message: nil, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        self.GCDEditButtonOutlet.isEnabled = true
                        self.operationButtonOutlet.isEnabled = true
                        self.operationButtonOutlet.backgroundColor = UIColor.yellow
                        self.GCDEditButtonOutlet.backgroundColor = UIColor.yellow
                        self.loadForTextFields()
                    }
                    alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
                    
         
                }
            }
            else
            {
                DispatchQueue.main.async
                {
                    self.activityIndicatorView.stopAnimating()
                    //AlertController:
                    let alert = UIAlertController(title: "Ошибка", message: "Не удалось сохранить данные", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default){ (action) in
                        self.GCDEditButtonOutlet.isEnabled = true
                        self.operationButtonOutlet.isEnabled = true
                        self.operationButtonOutlet.backgroundColor = UIColor.yellow
                        self.GCDEditButtonOutlet.backgroundColor = UIColor.yellow
                    }
                    let repeatAction = UIAlertAction(title: "Повторить", style: .default) { (action) in self.saveInfoGCD()}
                    alert.addAction(okAction)
                    alert.addAction(repeatAction)
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
            }
        }
    
    }
    
    
    func saveInfoOperation(){
        operationButtonOutlet.isEnabled = false
        GCDEditButtonOutlet.isEnabled = false
        operationButtonOutlet.backgroundColor = nil
        GCDEditButtonOutlet.backgroundColor = nil
        
        activityIndicatorView.startAnimating()
        

        var isSaved: Bool = true
        
        
        let name = self.nameOfUserTFOutlet.text!
        let photo = self.userPhotoImageView.image!
        let info = self.infoAboutUserTFOutlet.text!
        
        

        let backGroundQueue = OperationQueue()
        

        
        
        
                let custom = CustomData()
                custom.name = name
                custom.photo = photo
                custom.info = info
                
        backGroundQueue.addOperation {
            
        
                if let encodeName =  NSKeyedArchiver.archivedData(withRootObject: custom.name) as NSData?,
                    let encodePhoto =  custom.photo.jpegData(compressionQuality: 1.0) as NSData?,
                    let encodeInfo = NSKeyedArchiver.archivedData(withRootObject: custom.info) as NSData?
                {
                    let encodedArray: [NSData] = [encodeName, encodePhoto, encodeInfo]
                    let defaults = UserDefaults.standard
                    
                    defaults.set(encodedArray, forKey:"custom" )
                    defaults.synchronize()
                }
                else
                {
                    isSaved = false
                }
                
        }
        
        
        

            if isSaved
            {
                DispatchQueue.main.async
                    {
                        self.activityIndicatorView.stopAnimating()
                        //AlertController:
                        let alert = UIAlertController(title: "Данные сохранены", message: nil, preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            self.GCDEditButtonOutlet.isEnabled = true
                            self.operationButtonOutlet.isEnabled = true
                            self.operationButtonOutlet.backgroundColor = UIColor.yellow
                            self.GCDEditButtonOutlet.backgroundColor = UIColor.yellow
                            self.loadForTextFields()
                        }
                        alert.addAction(alertAction)
                        self.present(alert, animated: true, completion: nil)
                        
                        
                }
            }
            else
            {
                DispatchQueue.main.async
                    {
                        self.activityIndicatorView.stopAnimating()
                        //AlertController:
                        let alert = UIAlertController(title: "Ошибка", message: "Не удалось сохранить данные", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default){ (action) in
                            self.GCDEditButtonOutlet.isEnabled = true
                            self.operationButtonOutlet.isEnabled = true
                            self.operationButtonOutlet.backgroundColor = UIColor.yellow
                            self.GCDEditButtonOutlet.backgroundColor = UIColor.yellow
                        }
                        let repeatAction = UIAlertAction(title: "Повторить", style: .default) { (action) in self.saveInfoOperation()}
                        alert.addAction(okAction)
                        alert.addAction(repeatAction)
                        self.present(alert, animated: true, completion: nil)
                        
                }
                
            }
        
    }
    
   
    var a = ""
    var b: UIImage = #imageLiteral(resourceName: "placeholder-user.png")
    var c = ""
    
    func loadInfoOfUser(){

        let globalQueue =  DispatchQueue(label: "com.app.queueAnton", attributes: .concurrent)
        globalQueue.async{
            let defaults = UserDefaults.standard
            if defaults.object(forKey: "custom") != nil{
                
                
                var customDataEncoded: [NSData] = defaults.object(forKey: "custom") as! [NSData]
                
                let unpackedName: String = NSKeyedUnarchiver.unarchiveObject(with: customDataEncoded[0] as Data) as! String
                let unpackedPhoto: UIImage = UIImage(data: customDataEncoded[1] as Data) ?? #imageLiteral(resourceName: "placeholder-user.png")
                let unpackedInfo: String = NSKeyedUnarchiver.unarchiveObject(with: customDataEncoded[2] as Data) as! String
                
                
                let customData = CustomData()
                customData.name = unpackedName
                customData.photo = unpackedPhoto
                customData.info = unpackedInfo
                
                

                
                
                
                DispatchQueue.main.async
                    {
                self.nameOfUserTFOutlet.text = customData.name
                self.userPhotoImageView.image = customData.photo
                self.infoAboutUserTFOutlet.text = customData.info
                }
                
            }
        
        }
    }
    
    
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet var GCDEditButtonOutlet: UIButton!
    
    @IBAction func GCDEditButtonAction(_ sender: Any) {
        print("GCD_Pressed")
        saveInfoGCD()
        
        
    }
    
    
    @IBOutlet var operationButtonOutlet: UIButton!
    
    @IBAction func operationButtonAction(_ sender: Any) {
        print("operationPressed")
        saveInfoOperation()
    }

    
    @IBOutlet var nameOfUserLabel: UILabel!
    @IBOutlet var nameOfUserTFOutlet: UITextField!

    @IBAction func nameOfUserTFAction(_ sender: Any) {
        if a == nameOfUserTFOutlet.text{
            GCDEditButtonOutlet.isEnabled = false
            operationButtonOutlet.isEnabled = false
        }
        else{
            GCDEditButtonOutlet.isEnabled = true
            operationButtonOutlet.isEnabled = true
        }
    }
    @IBOutlet var infoAboutUserLabel: UILabel!
    @IBOutlet var infoAboutUserTFOutlet: UITextField!
    
    
    
    @IBOutlet var backButton: UIButton!
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var doneButtonOutlet: UIButton!
    
    @IBAction func doneButtonAction(_ sender: Any) {
        classicMode()

    }
    



    @IBAction func editButton(_ sender: Any) {
        logicOfEditButton()
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
    
    func loadForTextFields(){
    
        let defaults = UserDefaults.standard
        //let globalQueue =  DispatchQueue(label: "com.app.queueAnton", attributes: .concurrent)

        if defaults.object(forKey: "custom") != nil{
            
            var customDataEncoded: [NSData] = defaults.object(forKey: "custom") as! [NSData]
            
            let unpackedName: String = NSKeyedUnarchiver.unarchiveObject(with: customDataEncoded[0] as Data) as! String
            let unpackedPhoto: UIImage = UIImage(data: customDataEncoded[1] as Data) ?? #imageLiteral(resourceName: "placeholder-user.png")
            let unpackedInfo: String = NSKeyedUnarchiver.unarchiveObject(with: customDataEncoded[2] as Data) as! String
            
            
            self.a = unpackedName
            self.b = unpackedPhoto
            self.c = unpackedInfo
            
 
        
    
        }
    
}

    
    func editMode(){
        GCDEditButtonOutlet.backgroundColor = UIColor.yellow
        operationButtonOutlet.backgroundColor = UIColor.yellow
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         imagePickerController.delegate = self
       // printInConsoleLogs(nameOfMethod: #function)
        classicMode()
       GCDEditButtonOutlet.isEnabled = false

        
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
        //printInConsoleLogs(nameOfMethod: #function)
        
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


