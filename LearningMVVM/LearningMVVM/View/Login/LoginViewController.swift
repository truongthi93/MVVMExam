//
//  LoginViewController.swift
//  LearningMVVM
//
//  Created by Thi Vo on 2018/9/25.
//  Copyright © 2018 UIT. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var textFiledEmail: UITextField!
    @IBOutlet weak var textFilePassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        //Todo: Get userdefault email and password
        
        let returnValueEmail: String = UserDefaults.standard.string(forKey: Constants.nameUserDefaultLoginEmail) ?? ""
        let returnValuePass: String = UserDefaults.standard.string(forKey: Constants.nameUserDefaultLoginPass) ?? ""
        
        textFiledEmail.text = returnValueEmail
        textFilePassword.text = returnValuePass
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnHSignInClick(_ sender: Any) {
        if (textFiledEmail.text == Constants.correct_email && textFilePassword.text == Constants.correct_password) {
            
            // Todo: Save to userdefault email and password
            UserDefaults.standard.setValue(textFiledEmail.text, forKey: Constants.nameUserDefaultLoginEmail)
            UserDefaults.standard.setValue(textFilePassword.text, forKey: Constants.nameUserDefaultLoginPass)
            
            let vc = ImageListViewController(nibName: Constants.nameImageListView, bundle: nil)
            let navb = UINavigationController(rootViewController: vc)
            self.present(navb, animated: true, completion: nil)
        }
        else {
            Utility.showAlert(message: Constants.showAletLoginFail, context: self)
        }
    }
}
