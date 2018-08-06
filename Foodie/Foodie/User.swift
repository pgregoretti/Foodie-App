//
//  User.swift
//  Foodie
//
//  Created by Pam on 11/7/16.
//  Copyright © 2016 Pam. All rights reserved.
//

import UIKit

class User: NSObject {
    var userId: String = ""
    var idToken: String = ""
    var fullName: String = ""
    var givenName: String = ""
    var familyName: String = ""
    var email: String = ""
    
    init(userId: String, idToken: String, fullName: String, givenName: String, familyName: String, email: String){
        self.userId = userId
        self.idToken = idToken
        self.fullName = fullName
        self.givenName = givenName
        self.familyName = familyName
        self.email = email
    }
    
    override init(){
        
    }

}
