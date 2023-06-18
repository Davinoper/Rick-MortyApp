//
//  LoginViewController.swift
//  A2App
//
//  Created by Davi Noleto on 18/06/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var fldUser: UITextField!
    
    @IBOutlet weak var fldPassword: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (UserDefaults.standard.bool(forKey: "autologin")) {
            if let tabBarController = storyboard?.instantiateViewController(identifier: "tabBar") {
                tabBarController.modalTransitionStyle = .flipHorizontal
                tabBarController.modalPresentationStyle = .fullScreen
                self.present(tabBarController, animated: true, completion: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fldUser.resignFirstResponder()
        fldPassword.resignFirstResponder()
    }
    
    @IBAction func handleAutoLogin(_ sender: UISwitch) {
        if (validateUser() && sender.isOn) {
            UserDefaults.standard.setValue(true, forKey: "autologin")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    func validateUser() -> Bool {
        if let usuario = fldUser.text, let senha = fldPassword.text {
            if !usuario.isEmpty && !senha.isEmpty {
                if usuario == "davi" && senha == "123" {
                    return true
                
                }
            }
        }
        return false
    }
    
    @IBAction func tryLogin(_ sender: Any) {
        if validateUser() {
            if let tabBarController = storyboard?.instantiateViewController(identifier: "tabBar") {
                tabBarController.modalTransitionStyle = .flipHorizontal
                tabBarController.modalPresentationStyle = .fullScreen
                self.present(tabBarController, animated: true, completion: nil)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
