//
//  ViewController.swift
//  biometrics-login
//
//  Created by Woranittha Zunseng on 22/3/2564 BE.
//

import UIKit
import Defaults

class ViewController: UIViewController {

    @IBOutlet var statusSwitch: UISwitch!
    @IBOutlet var enableLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.statusSwitch.addTarget(self, action: #selector(valueChange), for: UIControl.Event.valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Defaults[.isLogin] == false {
            self.logOut()
        }
        
        if Defaults[.isActiveBiometric] == false {
            self.statusSwitch.isOn = false
        } else {
            self.statusSwitch.isOn = true
        }
    }

    @objc func valueChange(mySwitch: UISwitch) {
        Defaults[.isActiveBiometric] = mySwitch.isOn
    }
    
    private func logOut() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let passcodeViewController = storyBoard.instantiateViewController(withIdentifier: "PasscodeViewController") as? PasscodeViewController
        passcodeViewController?.modalPresentationStyle = .fullScreen
        self.present(passcodeViewController ?? PasscodeViewController(), animated: true, completion: nil)
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        Defaults[.isLogin] = false
        self.logOut()
    }
}

