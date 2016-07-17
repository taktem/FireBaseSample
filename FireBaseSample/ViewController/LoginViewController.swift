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
        
        view.endEditing(true)
        
        firebaseAuth.authEmail(emailTextField.text!, password: passwordTextField.text!)
            .subscribe(onNext: { (user: FIRUser) in
                
                // メールバリデーションが完了しているか確認
                if user.emailVerified {
                    Alert.show(title: "", message: "Login Success", buttonTitles: ["OK"])
                } else {
                    Alert.show(title: "", message: "Email is not verified", buttonTitles: ["OK"])
                }
                
                }, onError: { (error: ErrorType) in
                    
                }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
        
    }
    
    @IBAction private func facebookLoginButtonTapped() {
        
        view.endEditing(true)
        
        facebookAuth.login(target: self)
            .subscribe(onNext: { [unowned self] in
                self.authWithFacebook($0)
                }, onError: {
                    Alert.show(title: "", message: ($0 as NSError).localizedDescription, buttonTitles: ["OK"])
                }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
    }
    
    private func authWithFacebook(facebookUser: FacebookUser) {
        
        firebaseAuth.firebaseLoginWithFacebook(facebookUser)
            .subscribe(onNext: { _ in
                Alert.show(title: "", message: "Facebook auth Success", buttonTitles: ["OK"])
                }, onError: {
                    Alert.show(title: "", message: ($0 as NSError).localizedDescription, buttonTitles: ["OK"])
                }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
    }

}