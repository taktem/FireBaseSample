//
//  FacebookAuth.swift
//  FirebaseSample
//
//  Created by 西村 拓 on 2015/11/22.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

import FBSDKLoginKit

import RxSwift

class FacebookAuth: NSObject {
    
    let manager = FBSDKLoginManager()
    
    let fbDisposeBag = DisposeBag()
    
    func login(target target: UIViewController) -> Observable<FacebookUser> {
        return Observable.create {observer in
            
            if let token = FBSDKAccessToken.currentAccessToken() {
                
                if let result = FacebookUser.map(token: token) {
                    observer.on(.Next(result))
                    observer.onCompleted()
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
                    observer.on(.Error(error))
                }
                
                return AnonymousDisposable {
                    
                }
            }
            
            self.manager.logInWithReadPermissions(["public_profile", "email", "user_friends"],
                fromViewController: target) { (result: FBSDKLoginManagerLoginResult!, error: NSError!) -> Void in
                    if let result = FacebookUser.map(token: result.token) {
                        observer.on(.Next(result))
                        observer.onCompleted()
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: nil)
                        observer.on(.Error(error))
                    }
            }
            
            return AnonymousDisposable {
                
            }
        }
    }
}
