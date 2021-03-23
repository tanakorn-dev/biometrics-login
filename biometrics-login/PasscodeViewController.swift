//
//  PasscodeViewController.swift
//  biometrics-login
//
//  Created by Woranittha Zunseng on 23/3/2564 BE.
//

import UIKit
import SwiftIcons
import Defaults
import LocalAuthentication

class PasscodeViewController: UIViewController {

    @IBOutlet var titleImage: UIImageView!
    @IBOutlet var passcode01Image: UIImageView!
    @IBOutlet var passcode02Image: UIImageView!
    @IBOutlet var passcode03Image: UIImageView!
    @IBOutlet var passcode04Image: UIImageView!
    @IBOutlet var delButton: UIButton!
    @IBOutlet var bioButton: UIButton!
    
    private let biometricIDAuth = BiometricIDAuth()
    private var pinCode: [String] = []
    private var pinStr: String {
        var value = ""
        
        self.pinCode.forEach { pin in
            value = value.appending(pin)
        }
        
        return value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleImage.setIcon(icon: .fontAwesomeSolid(.unlockAlt), textColor: .darkGray, size: CGSize(width: 50, height: 50))
        self.delButton.setIcon(icon: .fontAwesomeSolid(.arrowLeft), iconSize: 25, color: .white, forState: .normal)
        self.updatePassCodeUI()
        
        if Defaults[.isActiveBiometric] == true {
            self.checkBiometricType()
        } else {
            self.bioButton.isHidden = true
        }
    }
    
    private func checkBiometricType() {
        self.biometricIDAuth.canEvaluate { (canEvaluate, biometricType, canEvaluateError) in
            switch biometricType {
            case .faceID:
                self.bioButton.isHidden = false
                self.bioButton.setIcon(icon: .fontAwesomeSolid(.smile), iconSize: 25, color: .white, forState: .normal)
            case .touchID:
                self.bioButton.isHidden = false
                self.bioButton.setIcon(icon: .fontAwesomeSolid(.fingerprint), iconSize: 25, color: .white, forState: .normal)
            default:
                self.bioButton.isHidden = true
            }
        }
    }
    
    private func updatePassCodeUI() {
        if self.pinCode.count == 1 {
            self.passcode01Image.setIcon(icon: .fontAwesomeSolid(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
            self.passcode02Image.setIcon(icon: .fontAwesomeRegular(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
            self.passcode03Image.setIcon(icon: .fontAwesomeRegular(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
            self.passcode04Image.setIcon(icon: .fontAwesomeRegular(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
        } else if self.pinCode.count == 2 {
            self.passcode01Image.setIcon(icon: .fontAwesomeSolid(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
            self.passcode02Image.setIcon(icon: .fontAwesomeSolid(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
            self.passcode03Image.setIcon(icon: .fontAwesomeRegular(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
            self.passcode04Image.setIcon(icon: .fontAwesomeRegular(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
        } else if self.pinCode.count == 3 {
            self.passcode01Image.setIcon(icon: .fontAwesomeSolid(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
            self.passcode02Image.setIcon(icon: .fontAwesomeSolid(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
            self.passcode03Image.setIcon(icon: .fontAwesomeSolid(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
            self.passcode04Image.setIcon(icon: .fontAwesomeRegular(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
        } else if self.pinCode.count == 4 {
            self.passcode01Image.setIcon(icon: .fontAwesomeSolid(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
            self.passcode02Image.setIcon(icon: .fontAwesomeSolid(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
            self.passcode03Image.setIcon(icon: .fontAwesomeSolid(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
            self.passcode04Image.setIcon(icon: .fontAwesomeSolid(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
        } else {
            self.passcode01Image.setIcon(icon: .fontAwesomeRegular(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
            self.passcode02Image.setIcon(icon: .fontAwesomeRegular(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
            self.passcode03Image.setIcon(icon: .fontAwesomeRegular(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
            self.passcode04Image.setIcon(icon: .fontAwesomeRegular(.circle), textColor: .darkGray, size: CGSize(width: 22, height: 22))
        }
    }
    
    private func updatePassCode(pin: String) {
        if self.pinCode.count < 4 {
            self.pinCode.append(pin)
            
            if self.pinCode.count == 4 {
                if self.pinStr == "1234" {
                    Defaults[.isLogin] = true
                    self.dismiss(animated: true, completion: nil)
                } else {
                    let refreshAlert = UIAlertController(title: "Error", message: "Passcode wrong", preferredStyle: UIAlertController.Style.alert)

                    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

                    self.present(refreshAlert, animated: true, completion: nil)
                }
                self.pinCode.removeAll()
            }
            
            self.updatePassCodeUI()
        }
    }
    
    @IBAction func button01Action(_ sender: Any) {
        self.updatePassCode(pin: "1")
    }
    
    @IBAction func button02Action(_ sender: Any) {
        self.updatePassCode(pin: "2")
    }
    
    @IBAction func button03Action(_ sender: Any) {
        self.updatePassCode(pin: "3")
    }
    
    @IBAction func button04Action(_ sender: Any) {
        self.updatePassCode(pin: "4")
    }
    
    @IBAction func button05Action(_ sender: Any) {
        self.updatePassCode(pin: "5")
    }
    
    @IBAction func button06Action(_ sender: Any) {
        self.updatePassCode(pin: "6")
    }
    
    @IBAction func button07Action(_ sender: Any) {
        self.updatePassCode(pin: "7")
    }
    
    @IBAction func button08Action(_ sender: Any) {
        self.updatePassCode(pin: "8")
    }
    
    @IBAction func button09Action(_ sender: Any) {
        self.updatePassCode(pin: "9")
    }
    
    @IBAction func button00Action(_ sender: Any) {
        self.updatePassCode(pin: "0")
    }
    
    @IBAction func buttonBioAction(_ sender: Any) {
        self.biometricIDAuth.evaluate { [weak self] (success, error) in
            if success {
                Defaults[.isLogin] = true
                self?.dismiss(animated: true, completion: nil)
            } else {
                switch error {
                case .biometryNotAvailable:
                    let alertController = UIAlertController(title: "Error", message: "Face ID Not Available. Do you want to active", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in
                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                            return
                        }
                        
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            UIApplication.shared.open(settingsUrl)
                        }
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    self?.present(alertController, animated: true, completion: nil)
                default:
                    let alertController = UIAlertController(title: "Error", message: error?.errorDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                    alertController.addAction(okAction)
                    self?.present(alertController, animated: true, completion: nil)
                }
            }
            
        }
    }
    
    @IBAction func buttonDelAction(_ sender: Any) {
        if self.pinCode.count != 0 {
            self.pinCode.removeLast()
            self.updatePassCodeUI()
        }
    }
}
