//
//  CreateUserViewController.swift
//  FireBaseSample
//
//  Created by 西村 拓 on 2016/06/06.
//  Copyright © 2016年 TakuNishimura. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {

    /// Firebase
    private let firebaseAuth = FirebaseAuth()

    /// E-Mail Login
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction private func createUserButtonTapped() {
        firebaseAuth.createEmailUser(emailTextField.text!, password: passwordTextField.text!)
    }

}
