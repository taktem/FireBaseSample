//
//  FirebaseAuth.swift
//  FirebaseSample
//
//  Created by 西村 拓 on 2016/06/06.
//  Copyright © 2016年 TakuNishimura. All rights reserved.
//

import RxSwift

import Firebase
import FirebaseAuth

import FBSDKLoginKit

class FirebaseAuth: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /**
      Anonymous Auth
     */
    final func authAnonymous() {
        FIRAuth.auth()?.signInAnonymouslyWithCompletion { (user: FIRUser?, error: NSError?) in
            
            print(user?.uid)
            
            user?.getTokenWithCompletion({ (token: String?, error: NSError?) in
                print(token)
            })
        }
    }
    
    /**
     Email Auth
     */
    final func createEmailUser(email: String, password: String) -> Observable<FIRUser> {
        
        return Observable.create { (observer: AnyObserver<FIRUser>) -> Disposable in
            FIRAuth.auth()?.createUserWithEmail(
                email,
                password: password,
                completion: {
                    (user: FIRUser?, error: NSError?) in
                    
                    if let user = user {
                        user.sendEmailVerificationWithCompletion(nil)
                        
                        observer.onNext(user)
                    } else if let error = error {
                        observer.onError(error)
                    }
                    
            })
            return AnonymousDisposable {}
        }
    }
    
    final func authEmail(email: String, password: String) {
       
        FIRAuth.auth()?.signInWithEmail(
            email,
            password: password,
            completion: { (user: FIRUser?, error: NSError?) in
                
                if let user = user {
                    if user.emailVerified {
                        Alert.show(title: "", message: "Login Success", buttonTitles: ["OK"])
                    } else {
                        Alert.show(title: "", message: "Email is not verified", buttonTitles: ["OK"])
                    }
                } else if let error = error {
                    Alert.show(title: "", message: error.localizedDescription, buttonTitles: ["OK"])
                }
        })
    }
    
    /**
     Facebook Auth
     */
    final func firebaseLoginWithFacebook(facebookUser: FacebookUser) -> Observable<FIRUser>  {
        
        let credential = FIRFacebookAuthProvider.credentialWithAccessToken(facebookUser.tokenString)
        
        return Observable.create { (observer: AnyObserver<FIRUser>) -> Disposable in
            
            if let user = FIRAuth.auth()?.currentUser {
                user.linkWithCredential(credential, completion: { (firUser: FIRUser?, error: NSError?) in
                    if let firUser = firUser {
                        observer.onNext(firUser)
                        observer.onCompleted()
                    } else if let error = error {
                        observer.onError(error)
                    }
                })
            } else {
                FIRAuth.auth()?.signInWithCredential(credential, completion: { (firUser: FIRUser?, error: NSError?) in
                    if let firUser = firUser {
                        observer.onNext(firUser)
                        observer.onCompleted()
                    } else if let error = error {
                        observer.onError(error)
                    }
                })
            }
            
            return AnonymousDisposable {}
        }
    }
    
}
