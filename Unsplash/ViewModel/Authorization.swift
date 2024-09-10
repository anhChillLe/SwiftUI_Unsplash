//
//  Authorization.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 5/9/24.
//

import Foundation
import SwiftUI
import Alamofire

@Observable
class Authorization {
    var isLogined: Bool
    
    init() {
        self.isLogined = UserDefaults.standard.string(forKey: "token") != nil
    }
    
    func requestCode(){
        AuthorizeAction.requestCode()
    }
    
    func login(code: String){
        AuthorizeAction.requestToken(code: code){ result in
            switch result {
            case .success(let response):
                print(response.scope)
                self.saveToken(accessToken: response.accessToken)
                self.isLogined = true
                self.getUserProfile()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func logout(){
        UserDefaults.standard.setValue(nil, forKey: "token")
        UserDefaults.standard.setValue(nil, forKey: "profile")
        self.isLogined = false
    }
    
    func getUserProfile(){
        CurrentUser.getProfile { result in
            switch result {
            case .success(let profile):
                let wrappedUser: CodableWrapper<CurrentUser?> = .init(value: profile)
                UserDefaults.standard.setValue(wrappedUser.rawValue, forKey: "profile")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func saveToken(accessToken: String){
        UserDefaults.standard.setValue(accessToken, forKey: "token")
    }
}
