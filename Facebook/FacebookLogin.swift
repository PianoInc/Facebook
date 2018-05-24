//
//  FacebookLogin.swift
//  Facebook
//
//  Created by JangDoRi on 2018. 5. 24..
//  Copyright © 2018년 piano. All rights reserved.
//

import FBSDKLoginKit

/**
 - parameter viewCtrl : ViewController context.
 - parameter isReady : 로그인 결과.
 */
func login(_ viewCtrl: UIViewController, isReady: @escaping ((Bool) -> ())) {
    guard FBSDKAccessToken.current() == nil else {
        isReady(true)
        return
    }
    let loginManager = FBSDKLoginManager()
    loginManager.logOut()
    loginManager.logIn(withReadPermissions: ["public_profile"], from: viewCtrl) { result, _ in
        if let result = result, !result.isCancelled {
            isReady(true)
        } else {
            isReady(false)
        }
    }
}

