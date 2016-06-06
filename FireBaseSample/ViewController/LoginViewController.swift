//
//  LoginViewController.swift
//  FireBaseSample
//
//  Created by 西村 拓 on 2016/06/01.
//  Copyright © 2016年 TakuNishimura. All rights reserved.
//

import UIKit

import RxSwift

import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    /// Firebase
    private let firebaseAuth = FirebaseAuth()
    
    /// Rx 
    private let disposeBag = DisposeBag()
    
    /// E-Mail Login
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    /// Facebook Login
    private let facebookAuth = FacebookAuth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    //MARK: - Auth
    @IBAction private func emailLoginButtonTapped() {
        FIRAuth.authWithApp(FIRApp.defaultApp()!)?.signInWithEmail(
            emailTextField.text!,
            password: passwordTextField.text!, completion: { (user: FIRUser?, error: NSError?) in
                print(user?.uid)
        })
    }
    
    @IBAction private func facebookLoginButtonTapped() {
        facebookAuth.login(target: self)
            .subscribeNext { [unowned self] in
                self.firebaseAuth.firebaseLoginWithFacebook($0)
                    .subscribeNext { (firUser: FIRUser) in
                        
                    }
                    .addDisposableTo(self.disposeBag)
            }
            .addDisposableTo(disposeBag)
    }
}

