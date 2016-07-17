//
//  AppDelegate.swift
//  FireBaseSample
//
//  Created by 西村 拓 on 2016/06/01.
//  Copyright © 2016年 TakuNishimura. All rights reserved.
//

import UIKit

import Firebase
import FirebaseMessaging

import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let fireBaseAuth = FirebaseAuth()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        firebaseSetting()
        
        return FBSDKApplicationDelegate.sharedInstance().application(
            application,
            didFinishLaunchingWithOptions: launchOptions)
    }

    private func firebaseSetting() {
        FIRApp.configure()
        FIRAnalytics.setUserID(UIDevice.currentDevice().identifierForVendor?.UUIDString)
        
        fireBaseAuth.authAnonymous()
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(
            application,
            openURL: url,
            sourceApplication: sourceApplication,
            annotation: annotation)
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print(userInfo)
    }
}

