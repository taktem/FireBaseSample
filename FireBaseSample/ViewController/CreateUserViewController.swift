//
//  CreateUserViewController.swift
//  FireBaseSample
//
//  Created by 西村 拓 on 2016/06/06.
//  Copyright © 2016年 TakuNishimura. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class CreateUserViewController: UIViewController {

    /// Rx 
    private let disposeBag = DisposeBag()
    
    /// Firebase
    private let firebaseAuth = FirebaseAuth()

    /// E-Mail Login
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet private weak var emailLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func bind() {
        
        let emptyCheck = Observable
            .combineLatest(emailTextField.rx_text, passwordTextField.rx_text) { ($0, $1) }
            .map {($0.0.characters.count > 0, $0.1.characters.count > 0) }
            .map { $0.0 && $0.1 }
        
        let passwordCheck = Observable
            .combineLatest(passwordTextField.rx_text, confirmPasswordTextField.rx_text) { $0 == $1 }
        
        let _ = Observable
            .combineLatest(emptyCheck, passwordCheck) { ($0.0, $0.1) }
            .map { $0.0 && $0.1 }
            .subscribeNext { [unowned self] in
                self.emailLoginButton.enabled = $0
        }
    }
    
    @IBAction private func createUserButtonTapped() {
        
        firebaseAuth.createEmailUser(emailTextField.text!, password: passwordTextField.text!)
            .subscribe(onNext: { _ in
                Alert.show(title: "", message: "Success", buttonTitles: ["OK"])
                
                }, onError: { _ in
                    Alert.show(title: "", message: "Error", buttonTitles: ["OK"])
                }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
    }

    @IBAction private func cancelButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
